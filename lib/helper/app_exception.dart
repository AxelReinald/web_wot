class AppException implements Exception {
  final dynamic message;
  final dynamic prefix;

  AppException({this.message, this.prefix});

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message: "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message: "Invalid Request: ");
}

class InvalidSessionExpression extends AppException {
  InvalidSessionExpression([String? message])
      : super(message: "Invalid Session: ");
}
