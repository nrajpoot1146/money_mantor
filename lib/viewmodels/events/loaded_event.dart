import '../../mvvm/observer.dart';

class LoadedEvent<T extends Object> extends ViewEvent{
  final T data;
  LoadedEvent(super.qualifier, this.data);
}