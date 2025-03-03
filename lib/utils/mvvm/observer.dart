
// unnecessary class created new class name EventObservers using which we can register multiple observer
import 'package:money_mantor/utils/AppEventBus/app_event_bus.dart';

// abstract class UiEventObserver {
//   void notify(ViewEvent event);
// }

// // 
// class EventObservers<T extends ViewEvent> {
//   List<Function(T)> observers = List.empty(growable: true);

//   void listen(Function(T) viewEvent) {
//     observers.add(viewEvent);
//   }

//   void notify(T viewEvent) {
//     for (var element in observers) {
//       element(viewEvent);
//     }
//   }
// }

// help to transfer data
abstract class ViewEvent extends AppEvent{
  ViewEvent(super.qualifier);
}
