import 'package:money_mantor/models/contracts/taxation_contracts.dart';

class FYModel {
  int? id;
  String? name;

  FYModel({required this.id, required this.name});
  FYModel.fromDefault()
      : id = 0,
        name = "";

  FYModel.fromMap(Map<String, Object?> map)
      : id = map[TaxationContracts.ID] as int,
        name = map[TaxationContracts.NAME] as String;

  Map<String, Object?> toMap() {
    return {
      TaxationContracts.ID: id,
      TaxationContracts.NAME: name,
    };
  }

  @override
  String toString() {
    return """ $FYModel{
      ${TaxationContracts.ID}: $id,
      ${TaxationContracts.NAME}: $name,
    }
    """;
  }
}

class TaxSlabModel {
  int? id;
  double? lowerLimit;
  double? upperLimit;
  RegimeType? regimeType;
  int? fyId;

  TaxSlabModel.fromMap(Map<String, Object?> map)
      : id = map[TaxSlabContracts.ID] as int,
        lowerLimit = map[TaxSlabContracts.LOWER_LIMIT] as double,
        upperLimit = map[TaxSlabContracts.UPPER_LIMIT] as double,
        regimeType = map[TaxSlabContracts.TAX_REGIME] as RegimeType,
        fyId = map[TaxSlabContracts.FY_ID] as int;

  Map<String, Object?> toMap() {
    return {
      TaxSlabContracts.ID: id,
      TaxSlabContracts.LOWER_LIMIT: lowerLimit,
      TaxSlabContracts.UPPER_LIMIT: upperLimit,
      TaxSlabContracts.TAX_REGIME: regimeType,
      TaxSlabContracts.FY_ID: fyId
    };
  }

  @override
  String toString() {
    return """ $TaxSlabModel{
      ${TaxSlabContracts.ID}: $id,
      ${TaxSlabContracts.LOWER_LIMIT}: $lowerLimit,
      ${TaxSlabContracts.UPPER_LIMIT}: $upperLimit,
      ${TaxSlabContracts.TAX_REGIME}: $regimeType,
      ${TaxSlabContracts.FY_ID}: $fyId} """;
  }
}

// ignore: constant_identifier_names
enum RegimeType { OLD, NEW }
