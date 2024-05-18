import 'package:money_mantor/global.dart';
import 'package:money_mantor/models/contracts/person_contracts.dart';
import 'package:money_mantor/models/person_model.dart';
import 'package:money_mantor/repository/repo.dart';

class PersonRepo extends Repo<Person> {
  @override
  Future<int> add(Person t) async {
    return Global.Db.getDataBaseInstance().insert(
      PersonContracts.TABLE_NAME,
      t.toMap(),
    );
  }

  @override
  Future<int> delete(int id) async {
    return Global.Db.getDataBaseInstance().delete(
      PersonContracts.TABLE_NAME,
      where: "${PersonContracts.ID} = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<List<Person>?> fetchAll() async {
    List<Person> res = List.empty(growable: true);
    var data =
        await Global.Db.getDataBaseInstance().query(PersonContracts.TABLE_NAME);
    try {
      for (var element in data) {
        var person = Person.fromMap(element);
        res.add(person);
      }
    } catch (e) {
      Global.Log.e(e);
      return Future.value(null);
    }
    return Future.value(res);
  }

  @override
  Future<int> update(Person t) async {
    return Global.Db.getDataBaseInstance().update(
      PersonContracts.TABLE_NAME,
      t.toMap(),
      where: "${PersonContracts.ID} = ?",
      whereArgs: [PersonContracts.ID]
    );
  }
}
