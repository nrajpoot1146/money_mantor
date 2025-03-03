import 'package:injectable/injectable.dart';
import 'package:money_mantor/Database/event/db_events.dart';
import 'package:money_mantor/di/configure_dependencies.dart';
import 'package:money_mantor/models/contracts/taxation_contracts.dart';
import 'package:money_mantor/models/taxation_models.dart';
import 'package:money_mantor/repository/repo.dart';
import 'package:money_mantor/utils/AppEventBus/app_event_bus.dart';

@singleton
class FYRepo extends Repo<FYModel> {
  static const String _fy_prefix = "FY";

  FYRepo(super.db, super.logger) {
    locator<AppEventBus>().on<DBCreateEvent>().listen(fillDefaultValue);
  }

  @override
  Future<int> add(FYModel t) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<int> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<FYModel>?> fetchAll() {
    // TODO: implement fetchAll
    throw UnimplementedError();
  }

  @override
  Future<FYModel?> fetchById(int id) {
    // TODO: implement fetchById
    throw UnimplementedError();
  }

  @override
  Future<int> update(FYModel t) {
    // TODO: implement update
    throw UnimplementedError();
  }

  void fillDefaultValue(DBCreateEvent dbCreateEvent) async {
    int start = 24, end = 28;
    for (var i = start; i <= end; i++) {
      String fyname = _getfyName(i, i + 1);
      await dbCreateEvent.db.rawInsert(TaxationContracts.INSERT, [fyname]);
    }
  }

  String _getfyName(int firstYear, int secondYear) {
    return "$_fy_prefix$firstYear-$secondYear";
  }
}

@singleton
class TaxSlabRepo extends Repo<TaxSlabRepo> {
  TaxSlabRepo(super.db, super.logger) {
    locator<AppEventBus>().on<DBCreateEvent>().listen(fillDefaultValue);
  }

  @override
  Future<int> add(TaxSlabRepo t) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<int> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<TaxSlabRepo>?> fetchAll() {
    // TODO: implement fetchAll
    throw UnimplementedError();
  }

  @override
  Future<TaxSlabRepo?> fetchById(int id) {
    // TODO: implement fetchById
    throw UnimplementedError();
  }

  @override
  Future<int> update(TaxSlabRepo t) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<List<TaxSlabModel>?> fetchByFy(FYModel fy,
      {RegimeType regimeType = RegimeType.NEW}) async {
    List<TaxSlabModel>? ret = List<TaxSlabModel>.empty();
    var data = await db.getDataBaseInstance().query(
      TaxSlabContracts.TABLE_NAME,
      orderBy: TaxSlabContracts.LOWER_LIMIT,
      where:
          '${TaxSlabContracts.FY_ID} = ? and ${TaxSlabContracts.TAX_REGIME} = ?',
      whereArgs: [fy.id, regimeType],
    );
    try {
      for (var ts in data) {
        ret.add(TaxSlabModel.fromMap(ts));
      }
    } catch (e) {
      logger.e(e);
    }
    return Future.value(ret);
  }

  void fillDefaultValue(DBCreateEvent dbCreateEvent) async{
    int start = 24, end = 28;
    for (var i = start; i <= end; i++) {
      await dbCreateEvent.db.rawInsert(TaxSlabContracts.INSERT, [0, 10000, 5, RegimeType.NEW.toString(), 0]);
    }
  }
}
