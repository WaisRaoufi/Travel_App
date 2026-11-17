abstract class Failure {
  final String message;

  Failure(this.message);
}

class someSpecificError extends Failure {
  someSpecificError(String message) : super(message);
}
