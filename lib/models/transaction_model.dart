import 'package:money_mantor/models/contracts/transaction_contracts.dart';

class Transaction {
  int? id;
  final int personId;
  final double amount;
  final TransactionType transactionType;
  final String note;
  final DateTime dateTime;

  Transaction({
    this.id,
    required this.personId,
    required this.amount,
    required this.transactionType,
    required this.note,
    required this.dateTime,
  });

  Transaction.fromDefault()
      : id = 1,
        personId = 9999,
        amount = 9999,
        transactionType = TransactionType.Taken,
        note = "",
        dateTime = DateTime.now();

  Transaction.fromMap(Map<String, Object?> map)
      : id = map[TransactionContracts.ID] as int,
        personId = map[TransactionContracts.PERSON_ID] as int,
        amount = map[TransactionContracts.AMOUNT] as double,
        transactionType =
            map[TransactionContracts.TRANSACTION_TYPE] as TransactionType,
        note = map[TransactionContracts.NOTE] as String,
        dateTime = map[TransactionContracts.DATE_TIME] as DateTime;

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
    return """Transaction {
      id: $id,
      personId: $personId, 
      amount: $amount, 
      transactionType: $transactionType, 
      note: $note, 
      dateTime: $dateTime
      }""";
  }
}

// ignore: constant_identifier_names
enum TransactionType { Given, Taken }
