// ignore_for_file: unused_field, prefer_final_fields

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_mantor/repository/transaction_repo.dart';
import 'package:money_mantor/viewmodels/events/loading_event.dart';
import 'package:money_mantor/viewmodels/events/transaction_events/transaction_add_event.dart';
import 'package:money_mantor/views/Contracts/transaction_statefulwidget.dart';

import '../../models/transaction_model.dart';
import '../../viewmodels/transaction_viewmodel.dart';

abstract class TransactionState<T extends TransactionStatefulWidget>
    extends State<T> {
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

    viewModel.on<LoadingEvent>().listen(
          (p0) => setState(
            () {
              isLoading = p0.isLoading;
            },
          ),
        );

    viewModel.on<TransactionAddEvent>().listen(
          (p0) => setState(
            () {
              if (Platform.isAndroid || Platform.isIOS) {
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
            },
          ),
        );

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
    viewModel.unsubscribe<LoadingEvent>();
    viewModel.unsubscribe<TransactionAddEvent>();
  }

  @protected
  void onAmountChange(value) {
    amount = double.parse(value);
  }

  @protected
  void onNoteChange(value) {
    details = value;
  }

  @protected
  void onDateTimeChange(value) {
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
      personId: widget.person.id!,
      amount: amount!,
      transactionType: transactionType!,
      note: details!,
      dateTime: dateTime,
    );
    viewModel.updateOrAdd(transaction);
  }
}
