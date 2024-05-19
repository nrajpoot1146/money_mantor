import '../../mvvm/observer.dart';

class LoadedEvent<T extends Object> extends ViewEvent{
  final List<T> data;
  LoadedEvent(super.qualifier, this.data);
}