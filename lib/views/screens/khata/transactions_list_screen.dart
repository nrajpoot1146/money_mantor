import 'package:flutter/material.dart';
import 'package:money_mantor/global.dart';
import 'package:money_mantor/views/states/khata/transactions_list_state.dart';
import 'package:money_mantor/views/widgets/transaction_list_item.dart';
import 'package:money_mantor/views/screens/khata/transaction_info_form_screen.dart';

class TransactionsListScreen extends TransactionsListStatefulWidget {
  const TransactionsListScreen({super.key, required super.person});

  @override
  State<StatefulWidget> createState() => _TransactionsListScreenState();
}

class _TransactionsListScreenState extends TransactionsListState<TransactionsListScreen> {
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(widget.person.name),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      flex: 7,
                      child: Text('Total'),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.red[50],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text(totalGivenAmount.toString())],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.green[50],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text(totalTakenAmount.toString())],
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: transactions.length,
                    padding: const EdgeInsets.only(bottom: 100),
                    itemBuilder: (context, index) {
                      return TransactionListItem(
                        transaction: transactions[index],
                        onTap: (transaction) => {
                          Navigator.of(context)
                              .push(
                                MaterialPageRoute(
                                  builder: (con) => TransactionWidget(
                                    transaction: transaction,
                                    person: widget.person,
                                  ),
                                ),
                              )
                              .then(
                                (value) =>
                                    viewModel.fetchAllByPerson(widget.person),
                              ),
                          Global.Log.i(transaction.toString()),
                        },
                        onLongPress: (transaction) {
                          viewModel.deleteById(transaction.id!);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => TransactionWidget(
                          person: widget.person,
                        ),
                      ),
                    )
                    .then(
                      (value) => viewModel.fetchAllByPerson(widget.person),
                    ),
              },
              child: const Icon(Icons.add),
            ),
          );
  }
}
