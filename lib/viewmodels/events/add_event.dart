import 'package:money_mantor/mvvm/observer.dart';

class AddEvent extends ViewEvent{
  final bool isAdded;
  AddEvent(super.qualifier, this.isAdded);
}