import 'package:injectable/injectable.dart';
import 'package:money_mantor/models/contracts/person_contracts.dart';
import 'package:money_mantor/models/person_model.dart';
import 'package:money_mantor/repository/repo_base.dart';

@singleton
class PersonRepo extends RepoBase<Person> {
  PersonRepo(super.db, super.logger);

  @override
  Future<int> add(Person t) async {
    return db.getDataBaseInstance().insert(
      PersonContracts.TABLE_NAME,
      t.toMap(),
    );
  }

  @override
  Future<int> delete(int id) async {
    return db.getDataBaseInstance().delete(
      PersonContracts.TABLE_NAME,
      where: "${PersonContracts.ID} = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<List<Person>?> fetchAll() async {
    List<Person> res = List.empty(growable: true);
    var data =
        await db.getDataBaseInstance().query(PersonContracts.TABLE_NAME);
    try {
      for (var element in data) {
        var person = Person.fromMap(element);
        res.add(person);
      }
    } catch (e) {
      logger.e(e);
      return Future.value(null);
    }
    return Future.value(res);
  }

  @override
  Future<int> update(Person t) async {
    return db.getDataBaseInstance().update(
        PersonContracts.TABLE_NAME, t.toMap(),
        where: "${PersonContracts.ID} = ?", whereArgs: [PersonContracts.ID]);
  }

  @override
  Future<Person?> fetchById(int id) async {
    var data = await db.getDataBaseInstance().query(
      PersonContracts.TABLE_NAME,
      where: "${PersonContracts.ID} = ?",
      whereArgs: [id],
    );
    return Future.value(Person.fromMap(data.first));
  }
}
