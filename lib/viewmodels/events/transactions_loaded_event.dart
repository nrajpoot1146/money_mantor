import 'package:money_mantor/models/transaction_model.dart';
import 'package:money_mantor/mvvm/observer.dart';

class TransactionsLoadedEvent extends ViewEvent {
  // ignore: unused_field
  final List<Transaction> list;
  TransactionsLoadedEvent(this.list) : super('$TransactionsLoadedEvent');
}
