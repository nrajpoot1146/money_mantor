import 'package:flutter/material.dart';
import 'package:money_mantor/global.dart';
import 'package:money_mantor/models/transaction_model.dart';
import 'package:money_mantor/mvvm/observer.dart';
import 'package:money_mantor/repository/transaction_repo.dart';
import 'package:money_mantor/viewmodels/events/loading_event.dart';
import 'package:money_mantor/viewmodels/events/transactions_loaded_event.dart';
import 'package:money_mantor/viewmodels/transaction_viewmodel.dart';
import 'package:money_mantor/views/custom_widgets/transaction_list_item.dart';
import 'package:money_mantor/views/transaction_widget.dart';

class TransactionsWidget extends StatefulWidget {
  const TransactionsWidget({super.key});

  @override
  State<StatefulWidget> createState() => _TransactionsWidgetState();
}

class _TransactionsWidgetState extends State<TransactionsWidget>
    implements EventObserver {
  final TransactionViewModel _transactionViewModel =
      TransactionViewModel(TransactionRepo());
  bool _isLoading = false;
  List<Transaction> _transactions = List.empty();

  double _totalTakenAmount = 0.0;
  double _totalGivenAmount = 0.0;

  void init() {
    _transactionViewModel.fetchAll();
  }

  void recalculateTotalAmount() {
    var tta = 0.0;
    var tga = 0.0;
    for (var element in _transactions) {
      if (element.transactionType == TransactionType.Taken) {
        tta += element.amount;
      } else {
        tga += element.amount;
      }
    }

    setState(() {
      _totalTakenAmount = tta;
      _totalGivenAmount = tga;
    });
  }

  @override
  void initState() {
    init();
    _transactionViewModel.subscribe(this);
    super.initState();
  }

  @override
  void reassemble() {
    //init();
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
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
                          children: [Text(_totalGivenAmount.toString())],
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
                          children: [Text(_totalTakenAmount.toString())],
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _transactions.length,
                    padding: const EdgeInsets.only(bottom: 100),
                    itemBuilder: (context, index) {
                      return TransactionListItem(
                        transaction: _transactions[index],
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
                                (value) => {
                                  setState(
                                    () {
                                      _transactionViewModel.fetchAll();
                                    },
                                  )
                                },
                              ),
                          Global.Log.i(transaction.toString()),
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
                      (value) => {
                        setState(
                          () {
                            _transactionViewModel.fetchAll();
                          },
                        ),
                      },
                    ),
              },
              child: const Icon(Icons.add),
            ),
          );
  }

  @override
  void notify(ViewEvent event) {
    if (event is LoadingEvent) {
      setState(() {
        _isLoading = event.isLoading;
      });
    } else if (event is TransactionsLoadedEvent) {
      setState(
        () {
          _transactions = event.list;
          recalculateTotalAmount();
        },
      );
    } else {
      Global.Log.e("Unknown Event.");
    }
  }
}
