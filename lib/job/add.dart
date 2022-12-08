import 'dart:io';

import 'package:history_service/core/logic.dart';

/// Add entry to history.
///
/// * **author**: iruzo
/// * **params**: historyFolderPath (e.g. /history), entry.
/// * **return**: void.
class Add extends Logic<void> {
  /// Add entry to history.
  ///
  /// * **author**: iruzo
  /// * **params**: historyFolderPath (e.g. /history), entry.
  /// * **return**: instance.
  Add(this._historyFolderPath, this._entry);

  String _entry;
  String _historyFolderPath;

  @override
  Future<void> run() async {
    DateTime dateTime = new DateTime.now();

    Directory historyDirectory = Directory(
        this._historyFolderPath + '/' + dateTime.year.toString()); // year
    if (!historyDirectory.existsSync())
      historyDirectory.create(recursive: true);

    historyDirectory = Directory(this._historyFolderPath +
        '/' +
        dateTime.year.toString() +
        '/' +
        dateTime.year.toString() +
        '-' +
        (dateTime.month < 10
            ? '0' + dateTime.month.toString()
            : dateTime.month.toString())); // month
    if (!historyDirectory.existsSync())
      historyDirectory.create(recursive: true);

    File historyFile = File(historyDirectory.path +
        '/' +
        dateTime.toString().split(' ')[0]); // day (file)
    if (!historyFile.existsSync()) historyFile.create(recursive: true);

    historyFile.writeAsString(
        '[' + dateTime.toString() + '] ' + this._entry + '\n',
        mode: FileMode.append);
  }
}
