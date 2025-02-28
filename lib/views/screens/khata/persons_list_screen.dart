import 'package:flutter/material.dart';
import 'package:money_mantor/global.dart';
import 'package:money_mantor/views/states/khata/persons_list_state.dart';
import 'package:money_mantor/views/widgets/person_list_item.dart';
import 'package:money_mantor/views/screens/khata/person_info_form_screen.dart';
import 'package:money_mantor/views/screens/khata/transactions_list_screen.dart';

class PersonsListScreen extends PersonsStatefulWidget {
  const PersonsListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PesonsListState();
}

class _PesonsListState extends PersonsListState<PersonsListScreen> {
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
                  builder: (context) => TransactionsListScreen(
                    person: p,
                  ),
                ),
              ).then((v) {
                viewModel.fetchAll();
              },);
            },
            amount: totalAmountByPersonId[personsList[index].id] ?? 0,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => const PersonInfoFormScreen(),
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
