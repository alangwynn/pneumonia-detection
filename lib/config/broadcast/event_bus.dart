/// Event communication contract
abstract class EventBusEvent {}

/// A simple event that does not a callback. The common use case is to notify
/// that something happened, e.g authentication state changed.
abstract class EventBusSimpleEvent extends EventBusEvent {}

/// A callback event. The common use case is to request something and expect
/// a response, e.g. request contact list to another package.
abstract class EventBusCallbackEvent<T> extends EventBusEvent {
  /// The callback to be called when the event is received
  void Function(T data) get callback;
}