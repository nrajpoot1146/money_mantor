import 'dart:math';

enum SavingType { bankAccount, epfoAccount, fdAccount, nps, stocks, other }

class SavingModel {
  String _name;
  SavingType _savingType;
  double _amount;
  DateTime _lastModified = DateTime.now();
  SavingModel(String name, SavingType savingType, double amount)
      : _name = name,
        _savingType = savingType,
        _amount = amount;

  SavingModel.fromDefault()
      : _name = "ABC",
        _savingType = SavingType.other,
        _amount = Random(3).nextDouble(),
        _lastModified = DateTime.now();

  SavingModel.fromMap(Map<String, Object> map)
      : _name = map['name'] as String,
        _savingType = map['savingType'] as SavingType,
        _amount = map['amount'] as double,
        _lastModified = map['lastModified'] as DateTime;

  String getName() => _name;

  double getAmount() => _amount;

  SavingType getType() => _savingType;

  DateTime getLastModified() => _lastModified;

  void setName(String name){
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
