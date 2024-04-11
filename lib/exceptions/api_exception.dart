import 'package:equatable/equatable.dart';

class ApiException extends Equatable implements Exception {
  const ApiException({
    required this.message,
    this.code,
    this.stackTrace,
  });

  final String message;
  final String? code;
  final StackTrace? stackTrace;

  @override
  String toString() =>
      'ApiException(message: $message, code: $code, stackTrace: $stackTrace),)';

  @override
  List<Object?> get props => [
        message,
        code,
        stackTrace,
      ];

  static const ApiException nullValueResponse =
      ApiException(message: 'Null value response on a non-nullable type');
}