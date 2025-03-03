import 'package:money_mantor/utils/AppEventBus/app_event_bus.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

abstract class DBEvent extends AppEvent{
  final Database db;
  DBEvent(super.qualifier, this.db);
}

class DBCreateEvent extends DBEvent{
  DBCreateEvent(Database db) : super("$DBCreateEvent", db);
}