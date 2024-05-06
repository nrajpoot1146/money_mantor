// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:logger/logger.dart';
import 'package:money_mantor/Database/db.dart';

abstract class Global {
  static late Logger Log;
  static late DB Db;

  static Future<bool> init() async{
    Log = Logger();
    Db = DB();
    bool res = await Db.init();
    return Future.value(res);
  }
}
