import 'package:flutter/material.dart';
import 'package:money_mantor/views/states/khata/person_state.dart';

class PersonInfoFormScreen extends PersonAddNewStatefulWidget {
  const PersonInfoFormScreen({super.key, super.person});

  @override
  State<StatefulWidget> createState() => _PersonAddNewState();
}

class _PersonAddNewState extends PersonAddNewState<PersonInfoFormScreen> {
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
