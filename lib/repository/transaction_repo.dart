import 'package:money_mantor/global.dart';
import 'package:money_mantor/models/contracts/transaction_contracts.dart';
import 'package:money_mantor/repository/repo.dart';

import '../models/transaction_model.dart';

class TransactionRepo extends Repo<Transaction>{
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
    List<Transaction> res = List.empty(growable: true);
    var data = await Global.Db.getDataBaseInstance().query(
        TransactionContracts.TABLE_NAME,
        groupBy: TransactionContracts.DATE_TIME,
        orderBy: '${TransactionContracts.DATE_TIME} DESC');

    try {
      for (var element in data) {
        Map<String, Object?> tempMap =
            element.map((key, value) => MapEntry(key, value));
        tempMap[TransactionContracts.TRANSACTION_TYPE] = TransactionType.values
            .firstWhere((type) =>
                type.toString() ==
                tempMap[TransactionContracts.TRANSACTION_TYPE]);
        tempMap[TransactionContracts.DATE_TIME] =
            DateTime.parse(tempMap[TransactionContracts.DATE_TIME] as String);
        res.add(
          Transaction.fromMap(tempMap),
        );
      }
    } catch (e) {
      Global.Log.e(e);
    }
    return Future.value(res);
  }
}
