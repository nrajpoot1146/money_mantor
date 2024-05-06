import 'package:money_mantor/models/transaction_model.dart';
import 'package:money_mantor/mvvm/observer.dart';

class TransactionDeletedEvent extends ViewEvent {
  // ignore: unused_field
  final Transaction? transaction;
  TransactionDeletedEvent({this.transaction}) : super('$TransactionDeletedEvent');
}
