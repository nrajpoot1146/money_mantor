import 'package:flutter/material.dart';
import 'package:money_mantor/viewmodels/events/loading_event.dart';
import 'package:money_mantor/viewmodels/events/transaction_events/transaction_deleted_event.dart';
import 'package:money_mantor/viewmodels/events/transaction_events/transactions_loaded_event.dart';
import 'package:money_mantor/views/Contracts/transactions_statefulwidget.dart';

import '../../models/transaction_model.dart';
import '../../repository/transaction_repo.dart';
import '../../viewmodels/transaction_viewmodel.dart';

abstract class TransactionsState<T extends TransactionsStatefulWidget>
    extends State<T> {
  final TransactionViewModel viewModel =
      TransactionViewModel(TransactionRepo());
  bool isLoading = false;
  List<Transaction> transactions = List.empty();

  double totalTakenAmount = 0.0;
  double totalGivenAmount = 0.0;

  void calculateTotalAmount() {
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
    viewModel.on<LoadingEvent>().listen(
          (p0) => setState(
            () {
              isLoading = p0.isLoading;
            },
          ),
        );

    viewModel.on<TransactionDeletedEvent>().listen(
          (p0) => {
            viewModel.fetchAllByPerson(widget.person),
            calculateTotalAmount(),
          },
        );

    viewModel.on<TransactionsLoadedEvent>().listen(
          (p0) => {
            setState(
              () {
                transactions = p0.data;
              },
            ),
            calculateTotalAmount(),
          },
        );
    viewModel.fetchAllByPerson(widget.person);
  }
}
