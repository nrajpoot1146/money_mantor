import 'package:flutter/material.dart';

import '../../models/person_model.dart';

class PersonListItem extends StatelessWidget {
  final Person person;
  final Function(Person)? ontap;
  const PersonListItem({super.key, required this.person, this.ontap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => ontap!(person),
      title: Text(person.name),
    );
  }
}
