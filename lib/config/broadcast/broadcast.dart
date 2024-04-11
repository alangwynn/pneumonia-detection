import 'package:pneumonia_detection/config/broadcast/event_bus.dart';
import 'package:rxdart/rxdart.dart';

/// Event communication contract
abstract class BroadcastChannel<T extends EventBusEvent> {
  final BehaviorSubject<T?> _eventStreamController = BehaviorSubject<T?>();

  /// The event stream
  Stream<T?> get eventStream => _eventStreamController.stream;

  /// Current value of the stream
  T? get currentValue =>
      _eventStreamController.hasValue ? _eventStreamController.value : null;

  /// The event sink
  Sink<T?> get eventSink => _eventStreamController.sink;

  /// Dispose the event stream
  void dispose() {
    _eventStreamController.close();
  }
}