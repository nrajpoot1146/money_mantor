import 'package:money_mantor/models/contracts/person_contracts.dart';

class Person {
  int? id;
  String name;
  String? mobileNo;
  String? emailId;

  Person({required this.name, this.mobileNo, this.emailId});

  Person.fromDefault(Map<String, Object?> map)
      : id = 1,
      name = 'Default',
      mobileNo = '1234567890',
      emailId = 'default@default.com';

  Person.fromMap(Map<String, Object?> map)
      : id = map[PersonContracts.ID] as int,
      name = map[PersonContracts.NAME] as String,
      mobileNo = map[PersonContracts.MOBILE_NO] as String,
      emailId = map[PersonContracts.EMAIL_ID] as String;

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
