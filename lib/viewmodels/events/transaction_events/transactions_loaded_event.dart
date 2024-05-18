import 'package:money_mantor/models/transaction_model.dart';
import 'package:money_mantor/viewmodels/events/loaded_event.dart';

class TransactionsLoadedEvent extends LoadedEvent<Transaction> {
  TransactionsLoadedEvent(List<Transaction> transaction) : super('$TransactionsLoadedEvent', transaction);
}
