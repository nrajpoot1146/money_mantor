import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:money_mantor/models/contracts/transaction_contracts.dart';
import 'package:money_mantor/repository/repo.dart';

import '../models/person_model.dart';
import '../models/transaction_model.dart';

@singleton
class TransactionRepo extends Repo<Transaction> {
  final Logger _logger;

  TransactionRepo(this._logger, super.db);
  @override
  Future<int> add(Transaction t) async {
    var map = t.toMap();
    map[TransactionContracts.TRANSACTION_TYPE] =
        map[TransactionContracts.TRANSACTION_TYPE].toString();
    map[TransactionContracts.DATE_TIME] =
        map[TransactionContracts.DATE_TIME].toString();

    return db.getDataBaseInstance().insert(
      TransactionContracts.TABLE_NAME,
      map,
    );
  }

  @override
  Future<int> delete(int id) async {
    return db.getDataBaseInstance().delete(
      TransactionContracts.TABLE_NAME,
      where: '${TransactionContracts.ID}= ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int> update(Transaction t) {
    var map = t.toMap();
    map[TransactionContracts.TRANSACTION_TYPE] =
        map[TransactionContracts.TRANSACTION_TYPE].toString();
    map[TransactionContracts.DATE_TIME] =
        map[TransactionContracts.DATE_TIME].toString();

    return db.getDataBaseInstance().update(
      TransactionContracts.TABLE_NAME,
      map,
      where: '${TransactionContracts.ID} = ?',
      whereArgs: [t.id],
    );
  }

  @override
  Future<List<Transaction>?> fetchAll() async {
    var data = await db.getDataBaseInstance().query(
        TransactionContracts.TABLE_NAME,
        groupBy: TransactionContracts.DATE_TIME,
        orderBy: '${TransactionContracts.DATE_TIME} DESC');
    return Future.value(_filterList(data));
  }

  @override
  Future<Transaction?> fetchById(int id) async {
    var data = await db.getDataBaseInstance().query(
      TransactionContracts.TABLE_NAME,
      where: '${TransactionContracts.ID} = ?',
      whereArgs: [id],
    );
    return Future.value(_filter(data.first));
  }

  Future<List<Transaction>?> fetchAllByPerson(Person person) async {
    var data = await db.getDataBaseInstance().query(
      TransactionContracts.TABLE_NAME,
      groupBy: TransactionContracts.DATE_TIME,
      orderBy: '${TransactionContracts.DATE_TIME} DESC',
      where: '${TransactionContracts.PERSON_ID} = ?',
      whereArgs: [person.id],
    );
    return Future.value(_filterList(data));
  }

  List<Transaction> _filterList(List<Map<String, Object?>> data) {
    List<Transaction> res = List.empty(growable: true);
    try {
      for (var element in data) {
        res.add(_filter(element));
      }
    } catch (e) {
      _logger.e(e);
    }
    return res;
  }

  Transaction _filter(Map<String, Object?> data) {
    Map<String, Object?> tempMap =
        data.map((key, value) => MapEntry(key, value));
    tempMap[TransactionContracts.TRANSACTION_TYPE] =
        TransactionType.values.firstWhere(
      (type) =>
          type.toString() == tempMap[TransactionContracts.TRANSACTION_TYPE],
    );
    tempMap[TransactionContracts.DATE_TIME] =
        DateTime.parse(tempMap[TransactionContracts.DATE_TIME] as String);
    return Transaction.fromMap(tempMap);
  }
}
