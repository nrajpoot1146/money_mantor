// ignore_for_file: constant_identifier_names

abstract class PersonContracts {
  static const String TABLE_NAME = "persons";

  static const String ID = "id";
  static const String NAME = "name";
  static const String MOBILE_NO = "mobileNo";
  static const String EMAIL_ID = "emailId";

  static const String CREATE_TABLE = """CREATE TABLE $TABLE_NAME (
    $ID INTEGER PRIMARY KEY AUTOINCREMENT,
    $NAME TEXT,
    $MOBILE_NO TEXT DEFAULT NULL,
    $EMAIL_ID TEXT DEFAULT NULL)""";
}
