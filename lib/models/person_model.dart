import 'package:money_mantor/models/contracts/person_contracts.dart';
import 'package:money_mantor/models/model_base.dart';

class Person extends ModelBase {
  String name;
  String? mobileNo;
  String? emailId;

  Person({required this.name, this.mobileNo, this.emailId});

  Person.fromDefault()
      : name = 'Default',
        mobileNo = '1234567890',
        emailId = 'default@default.com',
        super(id: 1);

  Person.fromEmpty()
      : name = '',
        mobileNo = '',
        emailId = '';

  Person.fromMap(Map<String, Object?> map)
      : name = map[PersonContracts.NAME] as String,
        mobileNo = map[PersonContracts.MOBILE_NO] as String,
        emailId = map[PersonContracts.EMAIL_ID] as String,
        super(id: map[PersonContracts.ID] as int);

  Map<String, Object?> toMap() {
    return {
      PersonContracts.ID: id,
      PersonContracts.NAME: name,
      PersonContracts.MOBILE_NO: mobileNo,
      PersonContracts.EMAIL_ID: emailId
    };
  }

  @override
  String toString() {
    return """ $Person{
      ${PersonContracts.ID}: $id,
      ${PersonContracts.NAME}: $name,
      ${PersonContracts.MOBILE_NO}: $mobileNo,
      ${PersonContracts.EMAIL_ID}: $emailId
    }
    """;
  }
}
