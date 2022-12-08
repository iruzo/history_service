import 'package:history_service/job/add.dart';
import 'package:history_service/job/delete.dart';
import 'package:history_service/job/read.dart';

/// History manager
///
/// * **author**: iruzo
/// * **params**: void.
/// * **return**: void.
class History {
  /// History manager
  ///
  /// * **author**: iruzo
  /// * **params**: void.
  /// * **return**: instance.
  History();

  /// Add entry to history.
  ///
  /// * **author**: iruzo
  /// * **params**: historyFolderPath (e.g. /history), entry.
  /// * **return**: void.
  add(String historyFolderPath, String entry) =>
      Add(historyFolderPath, entry).call();

  /// Read history history using arguments as filter.
  ///
  /// * **author**: iruzo
  /// * **params**:
  ///   * historyFolderPath (e.g. /history)
  ///   * [date (e.g. "0000-00-00 00:00:00.000Z") (You can specify as much as you want, if you want only a Year, you need to type the rest as 0, e.g. "2000-00-00 00:00:00.000000")
  ///   * [entry (e.g. some text that was saved before in the history)].
  /// * **return**: List with history entries.
  Future<List<String>> read(String historyFolderPath,
          [String? date, String? entry]) =>
      Read(historyFolderPath, date, entry).call();

  /// Delete history using arguments as filter.
  ///
  /// * **author**: iruzo
  /// * **params**:
  ///   * historyFolderPath (e.g. /history)
  ///   * [date (e.g. "0000-00-00 00:00:00.000Z") (You can specify as much as you want, if you want only a Year, you need to type the rest as 0, e.g. "2000-00-00 00:00:00.000000")
  ///   * [entry (e.g. some text that was saved before in the history)].
  /// * **return**: void.
  delete(String historyFolderPath, [String? date, String? entry]) =>
      Delete(historyFolderPath, date, entry).call();
}
