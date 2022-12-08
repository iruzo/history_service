import 'dart:io';

import 'package:history_service/core/logic.dart';

/// Read history history using arguments as filter.
///
/// * **author**: iruzo
/// * **params**:
///   * historyFolderPath (e.g. /history)
///   * [date (e.g. "0000-00-00 00:00:00.000Z") (You can specify as much as you want, if you want only a Year, you need to type the rest as 0, e.g. "2000-00-00 00:00:00.000000")
///   * [entry (e.g. some text that was saved before in the history)].
/// * **return**: List with history entries.
class Read extends Logic<List<String>> {
  /// Read history history using arguments as filter.
  ///
  /// * **author**: iruzo
  /// * **params**:
  ///   * historyFolderPath (e.g. /history)
  ///   * [date (e.g. "0000-00-00 00:00:00.000Z") (You can specify as much as you want, if you want only a Year, you need to type the rest as 0, e.g. "2000-00-00 00:00:00.000000")
  ///   * [entry (e.g. some text that was saved before in the history)].
  /// * **return**: List with history entries.
  Read(this._historyFolderPath, [this._date, this._entry]);

  String? _date;
  String? _entry;

  String _historyFolderPath;

  @override
  Future<List<String>> run() async {
    List<File> historyFiles = [];
    List<String> result = [];

    // Filter by date
    if (this._date != null) {
      historyFiles = await _getFilesByDate();
      if (historyFiles.isEmpty) return [];
      for (File file in historyFiles) result.addAll(file.readAsLinesSync());
      result = _getResultByTime(result);
    } else {
      historyFiles =
          _getAllFilesFromDirectory(Directory(this._historyFolderPath));
      if (historyFiles.isEmpty) return [];
      for (File file in historyFiles) result.addAll(file.readAsLinesSync());
    }

    // Filter by entry
    if (this._entry != null)
      for (int i = result.length - 1; i >= 0; i--)
        if (!result[i].contains(this._entry!)) result.remove(result[i]);

    return result;
  }

  Future<List<File>> _getFilesByDate() async {
    Directory historyDirectory;

    String year = this._date!.split(' ')[0].split('-')[0];
    if (year == '0000') return [];
    historyDirectory = Directory(this._historyFolderPath + '/' + year); // year
    if (!historyDirectory.existsSync()) return [];

    String month = this._date!.split(' ')[0].split('-')[1];
    if (month == '00') return _getAllFilesFromDirectory(historyDirectory);
    historyDirectory = Directory(this._historyFolderPath +
        '/' +
        year +
        '/' +
        year +
        '-' +
        month); // month
    if (!historyDirectory.existsSync()) return [];

    String day = this._date!.split(' ')[0];
    if (day == '00') return _getAllFilesFromDirectory(historyDirectory);
    File historyFile = File(this._historyFolderPath +
        '/' +
        year +
        '/' +
        year +
        '-' +
        month +
        '/' +
        day); // day
    if (!historyFile.existsSync()) return [];

    return [historyFile];
  }

  List<String> _getResultByTime(List<String> results) {
    String hour = this._date!.split(' ')[1].split(':')[0]; // hour
    if (hour == '00') return results;
    for (int i = results.length - 1; i >= 0; i--)
      if (results[i].split(']')[0].split(' ')[1].split(':')[0] != hour)
        results.remove(results[i]);

    String minute = this._date!.split(' ')[1].split(':')[1]; // minute
    if (minute == '00') return results;
    for (int i = results.length - 1; i >= 0; i--)
      if (results[i].split(']')[0].split(' ')[1].split(':')[1] != minute)
        results.remove(results[i]);

    String seccond =
        this._date!.split(' ')[1].split(':')[2].split('.')[0]; // seccond
    if (seccond == '00') return results;
    for (int i = results.length - 1; i >= 0; i--)
      if (results[i].split(']')[0].split(' ')[1].split(':')[2].split('.')[0] !=
          seccond) results.remove(results[i]);

    String milSeccond =
        this._date!.split(' ')[1].split(':')[2].split('.')[1]; // milSeccond
    if (milSeccond == '000000') return results;
    for (int i = results.length - 1; i >= 0; i--)
      if (results[i].split(']')[0].split(' ')[1].split(':')[2].split('.')[1] !=
          milSeccond) results.remove(results[i]);

    return results;
  }

  List<File> _getAllFilesFromDirectory(Directory dir) {
    List<File> files = [];

    dir
        .listSync(recursive: true)
        .forEach((file) => {if (file is File) files.add(File(file.path))});

    return files;
  }

  //TODO @iruzo - This functionality should be reviewed to see if more legibility can be obtained.

}
