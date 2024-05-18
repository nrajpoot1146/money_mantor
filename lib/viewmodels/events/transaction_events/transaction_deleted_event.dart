import 'package:money_mantor/models/transaction_model.dart';
import 'package:money_mantor/viewmodels/events/deleted_event.dart';

class TransactionDeletedEvent extends DeletedEvent<Transaction> {
  TransactionDeletedEvent({required Transaction transaction}) : super('$TransactionDeletedEvent', transaction);
}
