import 'package:flutter/material.dart';
import 'package:money_mantor/global.dart';
import 'package:money_mantor/mvvm/observer.dart';
import 'package:money_mantor/viewmodels/events/loading_event.dart';
import 'package:money_mantor/viewmodels/events/transaction_deleted_event.dart';
import 'package:money_mantor/viewmodels/events/transactions_loaded_event.dart';
import 'package:money_mantor/views/Contracts/transactions_statefulwidget.dart';

import '../../models/transaction_model.dart';
import '../../repository/transaction_repo.dart';
import '../../viewmodels/transaction_viewmodel.dart';

abstract class TransactionsState<T extends TransactionsStatefulWidget>
    extends State<T> implements EventObserver {
  final TransactionViewModel viewModel =
      TransactionViewModel(TransactionRepo());
  bool isLoading = false;
  List<Transaction> transactions = List.empty();

  double totalTakenAmount = 0.0;
  double totalGivenAmount = 0.0;

  @override
  void notify(ViewEvent event) {
    if (event is LoadingEvent) {
      setState(() {
        isLoading = event.isLoading;
      });
    } else if (event is TransactionsLoadedEvent) {
      setState(
        () {
          transactions = event.list;
          recalculateTotalAmount();
        },
      );
    } else if (event is TransactionDeletedEvent) {
      viewModel.fetchAll();
    } else {
      Global.Log.e("Unknown Event.");
    }
  }

  void recalculateTotalAmount() {
    var tta = 0.0;
    var tga = 0.0;
    for (var element in transactions) {
      if (element.transactionType == TransactionType.Taken) {
        tta += element.amount;
      } else {
        tga += element.amount;
      }
    }

    setState(() {
      totalTakenAmount = tta;
      totalGivenAmount = tga;
    });
  }

  @override
  void initState() {
    super.initState();
    viewModel.subscribe(this);
    viewModel.fetchAll();
  }
}
