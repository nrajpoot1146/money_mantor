import 'package:money_mantor/global.dart';
import 'package:money_mantor/models/contracts/person_contracts.dart';
import 'package:money_mantor/models/contracts/transaction_contracts.dart';
import 'package:money_mantor/repository/repo.dart';

import '../models/person_model.dart';
import '../models/transaction_model.dart';

class TransactionRepo extends Repo<Transaction> {
  @override
  Future<int> add(Transaction t) async {
    var map = t.toMap();
    map[TransactionContracts.TRANSACTION_TYPE] =
        map[TransactionContracts.TRANSACTION_TYPE].toString();
    map[TransactionContracts.DATE_TIME] =
        map[TransactionContracts.DATE_TIME].toString();

    return Global.Db.getDataBaseInstance().insert(
      TransactionContracts.TABLE_NAME,
      map,
    );
  }

  @override
  Future<int> delete(int id) async {
    return Global.Db.getDataBaseInstance().delete(
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

    return Global.Db.getDataBaseInstance().update(
      TransactionContracts.TABLE_NAME,
      map,
      where: '${TransactionContracts.ID} = ?',
      whereArgs: [t.id],
    );
  }

  @override
  Future<List<Transaction>?> fetchAll() async {
    var data = await Global.Db.getDataBaseInstance().query(
        TransactionContracts.TABLE_NAME,
        groupBy: TransactionContracts.DATE_TIME,
        orderBy: '${TransactionContracts.DATE_TIME} DESC');
    return Future.value(_filterList(data));
  }

  @override
  Future<Transaction?> fetchById(int id) async {
    var data = await Global.Db.getDataBaseInstance().query(
      TransactionContracts.TABLE_NAME,
      where: '${TransactionContracts.ID} = ?',
      whereArgs: [id],
    );
    return Future.value(_filter(data.first));
  }

  Future<List<Transaction>?> fetchAllByPerson(Person person) async {
    var data = await Global.Db.getDataBaseInstance().query(
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
      Global.Log.e(e);
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
