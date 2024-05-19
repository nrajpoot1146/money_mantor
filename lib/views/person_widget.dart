import 'package:flutter/material.dart';
import 'package:money_mantor/views/Contracts/person_state.dart';
import 'package:money_mantor/views/Contracts/person_statefulwidget.dart';

class PersonWidget extends PersonStatefulWidget {
  const PersonWidget({super.key, super.person});

  @override
  State<StatefulWidget> createState() => _PersonState();
}

class _PersonState extends PersonState<PersonWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(""),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              initialValue: person.name,
              decoration: const InputDecoration(
                hintText: "Customer Name",
                border: OutlineInputBorder(),
              ),
              onChanged: onNameChanged,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              initialValue: person.emailId,
              decoration: const InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(),
              ),
              onChanged: onEmailChanged,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              initialValue: person.mobileNo,
              decoration: const InputDecoration(
                hintText: "Mobile Number",
                border: OutlineInputBorder(),
              ),
              onChanged: onMobileNoChanged,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextButton(
              onPressed: onSaveButtonPressed,
              child: const Text("Save"),
            ),
          )
        ],
      ),
    );
  }
}
