import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:money_mantor/utils/mvvm/observer.dart';

// base class for view models
abstract class BaseViewModel {
  final Map<Object, EventObservers> _observerList = {};

  @protected
  final Logger logger;

  BaseViewModel(this.logger);

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
      logger.e("No Subscriber found for: ${viewEvent.runtimeType}");
    }
  }
}
