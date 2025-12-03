class Failure {
  final String msg;

  Failure({required this.msg});
}

final class ClientFailure extends Failure {
  ClientFailure({required super.msg});
}

final class ServerFailure extends Failure {
  ServerFailure({required super.msg});
}
