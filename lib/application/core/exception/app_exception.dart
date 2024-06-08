import 'network_exceptions.dart';

class AppException implements Exception  {
  final String? message;
  final int? code;

  @override
  String toString() {
    return 'AppException{message: $message, code: $code}';
  }

  AppException({required this.message, this.code});
}

class ServerException extends AppException {
  final ServerExceptionType type;
  final dynamic data;

  ServerException({
    required this.type,
    this.data,
    required String? message,
    int? code,
  }) : super(message: message, code: code);

  @override
  String toString() {
    return 'ServerException{type: $type ${super.toString()} Data:${data.toString()}}';
  }
}
