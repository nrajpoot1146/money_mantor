import 'package:money_mantor/global.dart';
import 'package:money_mantor/mvvm/observer.dart';

// base class for view models
abstract class EventViewModel {
  final Map<Object, EventObservers> _observerList = {};

  // functions to register a method
  EventObservers<T> on<T extends ViewEvent>() {
    var eventObservers = EventObservers<T>();
    _observerList[T] = eventObservers;
    return eventObservers;
  }

  bool unsubscribe<T extends ViewEvent>() {
    if (_observerList.keys.contains(T)) {
      _observerList.remove(T);
      return true;
    } else {
      return false;
    }
  }

  void notify(ViewEvent viewEvent) {
    if (_observerList.containsKey(viewEvent.runtimeType)) {
      _observerList[viewEvent.runtimeType]!.notify(viewEvent);
    } else {
      Global.Log.e("No Subscriber found for: ${viewEvent.runtimeType}");
    }
  }
}
