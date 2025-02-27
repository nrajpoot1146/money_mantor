import 'package:money_mantor/models/section80C_model.dart';
import 'package:money_mantor/repository/repo.dart';

class TaxationRepo extends Repo<Section80C> {
  @override
  Future<int> add(Section80C t) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<int> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Section80C>?> fetchAll() {
    // TODO: implement fetchAll
    throw UnimplementedError();
  }

  @override
  Future<Section80C?> fetchById(int id) {
    Section80C section80c = Section80C();
    section80c.elss = 10;
    section80c.lic = 10;
    section80c.nps = 10;
    section80c.nsc = 10;
    section80c.ppf = 10;
    
    return Future<Section80C>.value(section80c);
  }

  @override
  Future<int> update(Section80C t) {
    // TODO: implement update
    throw UnimplementedError();
  }

}