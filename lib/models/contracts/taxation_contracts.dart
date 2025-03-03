// ignore_for_file: constant_identifier_names

abstract class TaxationContracts {
  static const String TABLE_NAME = "FY_TABLE";

  static const String ID = "id";
  static const String NAME = "fy";

  static const String CREATE_TABLE = """CREATE TABLE $TABLE_NAME (
    $ID INTEGER PRIMARY KEY AUTOINCREMENT,
    $NAME TEXT
    )""";

  static const String INSERT = """INSERT INTO $TABLE_NAME(
  $NAME
  ) VALUES (?)""";
}

abstract class TaxSlabContracts {
  static const String TABLE_NAME = "TAX_SLABS";

  static const String ID = "id";
  static const String LOWER_LIMIT = "lower_limit";
  static const String UPPER_LIMIT = "upper_limit";
  static const String TAX_RATE = "tax_rate";
  static const String TAX_REGIME = "tax_regime";
  static const String FY_ID = "fy_id";

  static const String CREATE_TABLE = """CREATE TABLE $TABLE_NAME (
    $ID INTEGER PRIMARY KEY AUTOINCREMENT,
    $LOWER_LIMIT REAL DEFAULT 0,
    $UPPER_LIMIT REAL DEFAULT 0,
    $TAX_RATE REAL DEFAULT 0,
    $TAX_REGIME TEXT,
    $FY_ID INTEGER,
    FOREIGN KEY($FY_ID) REFERENCES ${TaxationContracts.TABLE_NAME}(${TaxationContracts.ID}))""";

  static const String INSERT = """INSERT INTO $TABLE_NAME(
    $LOWER_LIMIT,
    $UPPER_LIMIT,
    $TAX_RATE,
    $TAX_REGIME,
    $FY_ID
    ) VALUES (?, ?, ?, ?, ?)""";
}
