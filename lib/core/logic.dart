import 'runner.dart';

/// Handle errors and run async every functionality that extends from this class.
///
/// * **author**: iruzo
/// * **params**: void.
/// * **return**: void.
abstract class Logic<T> implements Runner<T> {
  /// Execute the functionality.
  ///
  /// * **params**: void.
  /// * **return**: void.
  Future<T> call() async {
    if (T.toString() == "void") {
      return this.run().then((value) {
        return value;
      })
          // ignore: return_of_invalid_type_from_catch_error
          .catchError((e) =>
              print(this.runtimeType.toString() + "()" + " - " + e.toString()));
    } else {
      return await this.run().then((value) {
        return value;
      })
          // ignore: return_of_invalid_type_from_catch_error
          .catchError((e) =>
              print(this.runtimeType.toString() + "()" + " - " + e.toString()));
    }
  }
}
