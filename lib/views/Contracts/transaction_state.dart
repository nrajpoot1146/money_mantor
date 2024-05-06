// ignore_for_file: unused_field, prefer_final_fields

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_mantor/global.dart';
import 'package:money_mantor/mvvm/observer.dart';
import 'package:money_mantor/repository/transaction_repo.dart';
import 'package:money_mantor/viewmodels/events/loading_event.dart';
import 'package:money_mantor/viewmodels/events/transaction_add_event.dart';
import 'package:money_mantor/viewmodels/events/transactions_loaded_event.dart';
import 'package:money_mantor/views/Contracts/transaction_statefulwidget.dart';

import '../../models/transaction_model.dart';
import '../../viewmodels/transaction_viewmodel.dart';

abstract class TransactionState<T extends TransactionStatefulWidget>
    extends State<T> implements EventObserver {
  @protected
  int? id;

  @protected
  double? amount;

  @protected
  String? details;

  @protected
  DateTime dateTime = DateTime.now();

  @protected
  TransactionType? transactionType;

  @protected
  bool isLoading = false;

  @protected
  final TransactionViewModel viewModel =
      TransactionViewModel(TransactionRepo());

  @protected
  final List<DropdownMenuEntry> dropDownMenuEntries =
      List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    viewModel.subscribe(this);
    for (var element in TransactionType.values) {
      dropDownMenuEntries
          .add(DropdownMenuEntry(value: element, label: element.name));
    }

    id = widget.transaction?.id;
    amount = widget.transaction?.amount;
    details = widget.transaction?.note;
    dateTime = widget.transaction?.dateTime ?? DateTime.now();
    transactionType = widget.transaction?.transactionType;
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.unsubscribe(this);
  }

  @override
  void notify(ViewEvent event) {
    Global.Log.i('Recieved: $event');

    if (event is LoadingEvent) {
      setState(
        () {
          isLoading = event.isLoading;
        },
      );
    } else if (event is TransactionAddEvent) {
      if (Platform.isAndroid || Platform.isIOS) {
        // make toast message
        Fluttertoast.showToast(
          msg: "Added.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      Navigator.of(context).pop();
    } else if (event is TransactionsLoadedEvent) {
    } else {
      Global.Log.i("Unknown Event.");
    }
  }

  @protected
  void onAmountChange(value){
    amount = double.parse(value);
  }

  @protected
  void onNoteChange(value){
    details = value;
  }

  @protected
  void onDateTimeChange(value){
    dateTime = value;
  }

  @protected
  void onTransactionTypeChange(value) {
    transactionType = value;
  }

  @protected
  void onSaveButtonPressed() {
    Transaction transaction = Transaction(
      id: id,
      personId: 1,
      amount: amount!,
      transactionType: transactionType!,
      note: details!,
      dateTime: dateTime,
    );
    viewModel.updateOrAdd(transaction);
  }
}
