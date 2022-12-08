/// Force functionality to override method "run" so all logic will be created inside that method.
///
/// * **author**: iruzo
abstract class Runner<T> {
  ///Method that will be executed in the functionality. Remember when overrided to establish async.
  Future<T> run();
}
