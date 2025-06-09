import 'package:flutter/material.dart';
import 'package:money_mantor/global.dart';

import '../../models/person_model.dart';

class PersonListItem extends StatelessWidget {
  final Person person;
  final Function(Person)? ontap;
  final double amount;
  const PersonListItem(
      {super.key, required this.person, this.ontap,required this.amount});

  @override
  Widget build(BuildContext context) {
    Global.Log.t("build $amount");
    return Container(
      margin: const EdgeInsets.all(1),
      child: ListTile(
        onTap: () => ontap!(person),
        title: Text(person.name),
        subtitle: Text(
          amount.toString(),
          style: TextStyle(color: amount < 0 ? Colors.red : Colors.green),
          textAlign: TextAlign.right,
        ),
        tileColor: Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
