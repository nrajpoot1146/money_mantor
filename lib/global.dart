// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:logger/logger.dart';
import 'package:money_mantor/Database/db.dart';

import 'di/locator.dart';

abstract class Global {
  static Logger Log = locator<Logger>();
  static DB Db = locator<DB>();

  static Future<bool> init() async{
    bool res = await Db.initasync();
    return Future.value(res);
  }
}
