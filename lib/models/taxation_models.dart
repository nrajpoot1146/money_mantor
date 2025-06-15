import 'package:money_mantor/models/contracts/taxation_contracts.dart';
import 'package:money_mantor/models/model_base.dart';

class FYModel extends ModelBase
{
  String? name;

  FYModel({required this.name});
  FYModel.fromDefault()
      : name = "",
        super(id: 0);

  FYModel.fromMap(Map<String, Object?> map)
      : name = map[TaxationContracts.NAME] as String,
        super(id: map[TaxationContracts.ID] as int);

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

class TaxSlabModel extends ModelBase
{
  double? lowerLimit;
  double? upperLimit;
  RegimeType? regimeType;
  int? fyId;

  TaxSlabModel.fromMap(Map<String, Object?> map)
      : lowerLimit = map[TaxSlabContracts.LOWER_LIMIT] as double,
        upperLimit = map[TaxSlabContracts.UPPER_LIMIT] as double,
        regimeType = map[TaxSlabContracts.TAX_REGIME] as RegimeType,
        fyId = map[TaxSlabContracts.FY_ID] as int,
        super(id: map[TaxSlabContracts.ID] as int);

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
