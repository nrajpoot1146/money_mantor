
// unnecessary class created new class name EventObservers using which we can register multiple observer
abstract class EventObserver {
  void notify(ViewEvent event);
}

// 
class EventObservers<T extends ViewEvent> {
  List<Function(T)> observers = List.empty(growable: true);

  void listen(Function(T) viewEvent) {
    observers.add(viewEvent);
  }

  void notify(T viewEvent) {
    for (var element in observers) {
      element(viewEvent);
    }
  }
}

// help to transfer data
abstract class ViewEvent {
  String qualifier;
  ViewEvent(this.qualifier);

  @override
  String toString() {
    return 'ViewEvent{qualifier: $qualifier}';
  }
}
