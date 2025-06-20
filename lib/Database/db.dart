import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:money_mantor/Database/event/db_events.dart';
import 'package:money_mantor/di/configure_dependencies.dart';
import 'package:money_mantor/models/contracts/person_contracts.dart';
import 'package:money_mantor/models/contracts/taxation_contracts.dart';
import 'package:money_mantor/utils/AppEventBus/app_event_bus.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../models/contracts/transaction_contracts.dart';

@singleton
class DB {
  late Database _db;
  final Logger _logger;
  // ignore: non_constant_identifier_names
  final String DB_FILE_NAME = 'database.db'; 
  DB(this._logger);

  void _onConfigure(db) {
    _logger.i("");
    _logger.t("db onConfiguration.");
  }

  void _onCreate(db, version) {
    _logger.t("db onCreate");
    db.execute(PersonContracts.CREATE_TABLE);
    db.execute(TransactionContracts.CREATE_TABLE);
    db.execute(TaxationContracts.CREATE_TABLE);
    db.execute(TaxSlabContracts.CREATE_TABLE);
    
    locator<AppEventBus>().notifyAsync(DBCreateEvent(db));
  }

  void _onDowngrade(db, oldVersion, newVersion) {
    _logger.t("db onDowngrade");
  }

  void _onOpen(db) {
    _logger.t("db onOpen");
  }

  void _onUpgrade(db, oldVersion, newVersion) {
    _logger.t("db onUpgrade");
  }

  Future<bool> initasync() async {
    var dbpath = r"D:\Proj\money_mantor\lib\Database";
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      var databaseFactory = databaseFactoryFfi;
      _db = await databaseFactory.openDatabase(
        join(dbpath, DB_FILE_NAME),
        options: OpenDatabaseOptions(
            onConfigure: _onConfigure,
            onCreate: _onCreate,
            onDowngrade: _onDowngrade,
            onOpen: _onOpen,
            onUpgrade: _onUpgrade,
            version: 1),
      );
      return Future.value(true);
    } else if (Platform.isAndroid || Platform.isIOS) {
      dbpath = join(await getDatabasesPath(), DB_FILE_NAME);
      _logger.d(dbpath);
      _db = await openDatabase(dbpath,
          onConfigure: _onConfigure,
          onCreate: _onCreate,
          onDowngrade: _onDowngrade,
          onOpen: _onOpen,
          onUpgrade: _onUpgrade,
          version: 1);
      return Future.value(true);
    } else {
      _logger.e("Unknown Platform");
      return Future.value(false);
    }
  }

  Database getDataBaseInstance() {
    return _db;
  }
}
