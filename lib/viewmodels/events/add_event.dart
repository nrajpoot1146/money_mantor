import 'package:money_mantor/utils/mvvm/observer.dart';

class AddEvent extends ViewEvent{
  final bool isAdded;
  AddEvent(super.qualifier, this.isAdded);
}