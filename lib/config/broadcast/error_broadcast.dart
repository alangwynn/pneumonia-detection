
import 'package:pneumonia_detection/config/broadcast/broadcast.dart';
import 'package:pneumonia_detection/config/broadcast/event_bus.dart';

/// Http error simple event class. Errors are coming from the http request and
/// Exceptions are coming from the client.
enum ErrorSimpleEventErrorType {
  /// Http error
  httpError,

  /// Client error
  socketException,

  /// Client error
  timeoutException,

  /// Client error
  cancelException,

  /// Client error
  malformedResponseException,

  /// Another client error
  unknownException,
}

/// Error simple event abstract class
abstract class IErrorEvent extends EventBusSimpleEvent {
  /// Error message
  String get message;

  /// Error stack trace
  StackTrace? get stackTrace;
}

/// Network error event abstract class
abstract class NetworkErrorEvent extends IErrorEvent {
  /// Error type
  /// @see [ErrorSimpleEventErrorType]
  ErrorSimpleEventErrorType get errorType =>
      ErrorSimpleEventErrorType.unknownException;
}

/// Basic implementation of IErrorEvent interface. It is used to create simple
/// generic error events.
final class ErrorSimpleEvent extends IErrorEvent {
  /// Error simple event constructor
  ErrorSimpleEvent({
    required this.message,
    this.stackTrace,
  });

  @override
  final String message;

  /// Error stack trace
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'ErrorSimpleEvent(message: $message, '
        'stackTrace: $stackTrace)';
  }
}

/// Http error simple event class
final class HttpErrorSimpleEvent extends NetworkErrorEvent {
  /// Http error simple event constructor
  HttpErrorSimpleEvent({
    required this.code,
    required this.message,
    this.stackTrace,
  });

  /// Http error code
  final String code;

  @override
  final String message;

  @override
  ErrorSimpleEventErrorType get errorType =>
      ErrorSimpleEventErrorType.httpError;

  /// Error stack trace
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'HttpErrorSimpleEvent(code: $code, message: $message, '
        'stackTrace: $stackTrace)';
  }
}

/// Client error simple event class
final class ClientErrorSimpleEvent extends NetworkErrorEvent {
  /// Client error simple event constructor
  ClientErrorSimpleEvent({
    required this.message,
    required this.errorType,
    this.stackTrace,
  });

  @override
  final String message;

  @override
  final ErrorSimpleEventErrorType errorType;

  /// Error stack trace
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'ClientErrorSimpleEvent(message: $message, '
        'errorType: $errorType)';
  }
}

/// Singleton class to handle http error and client exceptions communication
final class ErrorBroadcastChannel extends BroadcastChannel<IErrorEvent> {
  /// The singleton constructor
  factory ErrorBroadcastChannel() {
    return _instance;
  }

  /// The internal constructor
  ErrorBroadcastChannel._internal();

  /// The singleton instance
  static final ErrorBroadcastChannel _instance =
      ErrorBroadcastChannel._internal();
}