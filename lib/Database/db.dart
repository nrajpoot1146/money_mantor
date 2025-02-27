import 'dart:io';

import 'package:money_mantor/global.dart';
import 'package:money_mantor/models/contracts/person_contracts.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../models/contracts/transaction_contracts.dart';

class DB {
  late Database _db;
  // ignore: non_constant_identifier_names
  final String DB_FILE_NAME = 'database.db'; 
  DB();

  void _onConfigure(db) {
    Global.Log.i("");
    Global.Log.t("db onConfiguration.");
  }

  void _onCreate(db, versio) {
    db.execute(PersonContracts.CREATE_TABLE);
    db.execute(TransactionContracts.CREATE_TABLE);
    Global.Log.t("db onCreate");
  }

  void _onDowngrade(db, oldVersion, newVersion) {
    Global.Log.t("db onDowngrade");
  }

  void _onOpen(db) {
    Global.Log.t("db onOpen");
  }

  void _onUpgrade(db, oldVersion, newVersion) {
    Global.Log.t("db onUpgrade");
  }

  Future<bool> init() async {
    var dbpath = r"C:\Data\Proj\money_mantor\lib\Database\";
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
      Global.Log.d(dbpath);
      _db = await openDatabase(dbpath,
          onConfigure: _onConfigure,
          onCreate: _onCreate,
          onDowngrade: _onDowngrade,
          onOpen: _onOpen,
          onUpgrade: _onUpgrade,
          version: 1);
      return Future.value(true);
    } else {
      Global.Log.e("Unknown Platform");
      return Future.value(false);
    }
  }

  Database getDataBaseInstance() {
    return _db;
  }
}
