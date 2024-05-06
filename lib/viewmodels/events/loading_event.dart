import 'package:money_mantor/mvvm/observer.dart';

class LoadingEvent extends ViewEvent{
  final bool isLoading;
  LoadingEvent({required this.isLoading}) : super('$LoadingEvent');
}