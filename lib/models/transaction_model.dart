import 'package:money_mantor/models/contracts/transaction_contracts.dart';
import 'package:money_mantor/models/model_base.dart';

class Transaction extends ModelBase
{
  final int personId;
  final double amount;
  final TransactionType transactionType;
  final String note;
  final DateTime dateTime;

  Transaction({
    super.id,
    required this.personId,
    required this.amount,
    required this.transactionType,
    required this.note,
    required this.dateTime,
  });

  Transaction.fromDefault()
      : personId = 9999,
        amount = 9999,
        transactionType = TransactionType.Taken,
        note = "",
        dateTime = DateTime.now(),
        super(id: 1);

  Transaction.fromMap(Map<String, Object?> map)
      : personId = map[TransactionContracts.PERSON_ID] as int,
        amount = map[TransactionContracts.AMOUNT] as double,
        transactionType =
            map[TransactionContracts.TRANSACTION_TYPE] as TransactionType,
        note = map[TransactionContracts.NOTE] as String,
        dateTime = map[TransactionContracts.DATE_TIME] as DateTime,
        super(id: map[TransactionContracts.ID] as int);

  Map<String, Object?> toMap() {
    return {
      TransactionContracts.ID: id,
      TransactionContracts.PERSON_ID: personId,
      TransactionContracts.AMOUNT: amount,
      TransactionContracts.TRANSACTION_TYPE: transactionType,
      TransactionContracts.NOTE: note,
      TransactionContracts.DATE_TIME: dateTime.toString()
    };
  }

  @override
  String toString() {
    return """$Transaction {
      ${TransactionContracts.ID}: $id,
      ${TransactionContracts.PERSON_ID}: $personId, 
      ${TransactionContracts.AMOUNT}: $amount, 
      ${TransactionContracts.TRANSACTION_TYPE}: $transactionType, 
      ${TransactionContracts.NOTE}: $note, 
      ${TransactionContracts.DATE_TIME}: $dateTime
      }""";
  }
}

// ignore: constant_identifier_names
enum TransactionType { Given, Taken }
