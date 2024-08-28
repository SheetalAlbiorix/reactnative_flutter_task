class CustomException implements Exception {
  final String? message;
  final String? prefix;

  CustomException([this.message, this.prefix]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class NoInternetException extends CustomException {
  NoInternetException([message]) : super(message, "");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "");
}

class FetchDataException extends CustomException {
  FetchDataException([String? message]) : super(message, "");
}
