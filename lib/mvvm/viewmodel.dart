import 'package:money_mantor/mvvm/observer.dart';

abstract class EventViewModel {
  final List<EventObserver> _observerList = List.empty(growable: true);

  void subscribe(EventObserver eventObserver) {
    _observerList.add(eventObserver);
  }

  bool unsubscribe(EventObserver o) {
    if (_observerList.contains(o)) {
      _observerList.remove(o);
      return true;
    } else {
      return false;
    }
  }

  void notify(ViewEvent viewEvent) {
    for (var element in _observerList) {
        element.notify(viewEvent);
      }
  }
}
