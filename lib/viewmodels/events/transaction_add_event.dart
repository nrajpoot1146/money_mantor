import 'package:money_mantor/mvvm/observer.dart';

class TransactionAddEvent extends ViewEvent {
  // ignore: prefer_typing_uninitialized_variables
  final isAdded;
  TransactionAddEvent({required this.isAdded}) : super('$TransactionAddEvent');
}
