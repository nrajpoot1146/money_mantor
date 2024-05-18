import 'package:money_mantor/mvvm/observer.dart';

class DeletedEvent<T extends Object> extends ViewEvent{
  final T? data;
  DeletedEvent(super.qualifier, this.data);
}