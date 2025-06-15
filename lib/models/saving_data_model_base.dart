import 'package:money_mantor/models/model_base.dart';

enum SavingType { bankAccount, epfoAccount, fdAccount, nps, stocks, other }

class SavingDataModelBase extends ModelBase {
  String _name;
  double _amount = 0.0;
  SavingType _savingType;
  DateTime _lastModified = DateTime.now();

  SavingDataModelBase(this._name, this._amount, this._savingType)
      : _lastModified = DateTime.now();

  SavingDataModelBase.fromDefault()
      : _name = 'DefaultBank',
        _amount = 100.00,
        _savingType = SavingType.other,
        _lastModified = DateTime.now(),
        super(id: 1);

  SavingDataModelBase.fromEmpty()
      : _name = '',
        _amount = 0.00,
        _savingType = SavingType.other,
        _lastModified = DateTime.now(),
        super(id: null);

  // BankDataItemModel.fromMap(Map<String, Object?> map)
  //     : id = map[PersonContracts.ID] as int,
  //       name = map[PersonContracts.NAME] as String,
  //       mobileNo = map[PersonContracts.MOBILE_NO] as String,
  //       emailId = map[PersonContracts.EMAIL_ID] as String;

  // Map<String, Object?> toMap() {
  //   return {
  //     PersonContracts.ID: id,
  //     PersonContracts.NAME: name,
  //     PersonContracts.MOBILE_NO: mobileNo,
  //     PersonContracts.EMAIL_ID: emailId
  //   };
  // }

  // @override
  /*String toString() {
    return """ $Person{
      ${PersonContracts.ID}: $id,
      ${PersonContracts.NAME}: $name,
      ${PersonContracts.MOBILE_NO}: $mobileNo,
      ${PersonContracts.EMAIL_ID}: $emailId
    }
    """;
  }*/

  String getName() => _name;

  double getAmount() => _amount;

  SavingType getType() => _savingType;

  DateTime getLastModified() => _lastModified;

  void setName(String name) {
    _name = name;
    _lastModified = DateTime.now();
  }

  void setAmount(double amount) {
    _amount = amount;
    _lastModified = DateTime.now();
  }

  void setType(SavingType savingType) {
    _savingType = savingType;
    _lastModified = DateTime.now();
  }
}
