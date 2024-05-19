import 'package:flutter/material.dart';
import 'package:money_mantor/global.dart';
import 'package:money_mantor/views/Contracts/persons_state.dart';
import 'package:money_mantor/views/Contracts/persons_statefulwidget.dart';
import 'package:money_mantor/views/custom_widgets/person_list_item.dart';
import 'package:money_mantor/views/person_widget.dart';
import 'package:money_mantor/views/transactions_widget.dart';

class PersonsWidget extends PersonsStatefulWidget {
  const PersonsWidget({super.key});

  @override
  State<StatefulWidget> createState() => _PesonsState();
}

class _PesonsState extends PersonsState<PersonsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Customers"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: ListView.builder(
        itemCount: personsList.length,
        padding: const EdgeInsets.only(bottom: 100),
        itemBuilder: (context, index) {
          return PersonListItem(
            person: personsList[index],
            ontap: (p) {
              Global.Log.i("On Tap: ${p.name}");
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TransactionsWidget(
                    person: p,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => const PersonWidget(),
                ),
              )
              .then(
                (value) => viewModel.fetchAll(),
              ),
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
