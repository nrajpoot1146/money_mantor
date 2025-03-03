// lib/utils/event_bus.dart
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

/// A simple, globally accessible event bus.
///
/// Use this for general application-wide events where you don't need
/// fine-grained control or service-specific event buses.
@singleton
class AppEventBus {
  final Map<Object, AppEventObservers> _observerList = {};
  final Logger logger;

  AppEventBus(this.logger);

  // functions to register a method
  AppEventObservers<T> on<T extends AppEvent>() {
    var eventObservers = _observerList[T];
    if (eventObservers == null) {
      eventObservers = AppEventObservers<T>();
      _observerList[T] = eventObservers;
    }
    return eventObservers as AppEventObservers<T>;
  }

  bool unsubscribe<T extends AppEvent>() {
    if (_observerList.keys.contains(T)) {
      _observerList.remove(T);
      return true;
    } else {
      return false;
    }
  }

  void notify(AppEvent appEvent) {
    if (_observerList.containsKey(appEvent.runtimeType)) {
      try {
        _observerList[appEvent.runtimeType]!.notify(appEvent);
      } catch (e) {
        logger.e(e);
      }
    } else {
      logger.e("No Subscriber found for: ${appEvent.runtimeType}");
    }
  }

  Future<void> notifyAsync(AppEvent appEvent) async {
    if (_observerList.containsKey(appEvent.runtimeType)) {
      await _observerList[appEvent.runtimeType]!.notifyAsync(appEvent);
    } else {
      logger.e("No Subscriber found for: ${appEvent.runtimeType}");
    }
  }
}

class AppEventObservers<T extends AppEvent> {
  List<Function(T)> observers = List.empty(growable: true);

  void listen(Function(T) appEvent) {
    observers.add(appEvent);
  }

  void notify(T appEvent) {
    for (var element in observers) {
      element(appEvent);
    }
  }

  Future<void> notifyAsync(T appEvent) async {
    for (var element in observers) {
      await element(appEvent);
    }
  }
}

abstract class AppEvent {
  String qualifier;
  AppEvent(this.qualifier);

  @override
  String toString() {
    return 'AppEvent{qualifier: $qualifier}';
  }
}
