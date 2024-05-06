// ignore_for_file: constant_identifier_names

abstract class TransactionContracts{
  static const String TABLE_NAME = "transactions";

  static const String ID = "id";
  static const String PERSON_ID = "personId";
  static const String AMOUNT = "amount";
  static const String TRANSACTION_TYPE = "transactionType";
  static const String NOTE = "note";
  static const String DATE_TIME = "datetime";

  static const String CREATE_TABLE = """CREATE TABLE $TABLE_NAME(
    $ID INTEGER PRIMARY KEY AUTOINCREMENT, 
    $PERSON_ID INTEGER, 
    $AMOUNT REAL,
    $TRANSACTION_TYPE TEXT,
    $NOTE TEXT,
    $DATE_TIME TEXT)""";

  static const String INSERT = """ INSERT INTO $TABLE_NAME(
  $PERSON_ID,
  $AMOUNT,
  $TRANSACTION_TYPE,
  $NOTE,
  $DATE_TIME
  ) VALUES ({0}, {1}, {2}, {3}, {4}) """;

  static const String SELECT_ALL = "SELECT * FROM $TABLE_NAME";
}