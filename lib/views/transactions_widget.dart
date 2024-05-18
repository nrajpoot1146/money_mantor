import 'package:flutter/material.dart';
import 'package:money_mantor/global.dart';
import 'package:money_mantor/mvvm/observer.dart';
import 'package:money_mantor/views/Contracts/transactions_state.dart';
import 'package:money_mantor/views/Contracts/transactions_statefulwidget.dart';
import 'package:money_mantor/views/custom_widgets/transaction_list_item.dart';
import 'package:money_mantor/views/transaction_widget.dart';

class TransactionsWidget extends TransactionsStatefulWidget {
  const TransactionsWidget({super.key});

  @override
  State<StatefulWidget> createState() => _TransactionsWidgetState();
}

class _TransactionsWidgetState extends TransactionsState<TransactionsWidget>
    implements EventObserver {
  @override
  Widget build(BuildContext context) {
    
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Cutomer name'),
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
                                  ),
                                ),
                              )
                              .then(
                                (value) => viewModel.fetchAll(),
                              ),
                          Global.Log.i(transaction.toString()),
                        },
                        onLongPress: (transaction){
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
                        builder: (context) => const TransactionWidget(),
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
