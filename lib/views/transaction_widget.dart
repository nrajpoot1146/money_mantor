import 'dart:io';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:money_mantor/global.dart';
import 'package:money_mantor/models/transaction_model.dart';
import 'package:money_mantor/mvvm/observer.dart';
import 'package:money_mantor/repository/transaction_repo.dart';
import 'package:money_mantor/viewmodels/events/loading_event.dart';
import 'package:money_mantor/viewmodels/events/transaction_add_event.dart';
import 'package:money_mantor/viewmodels/events/transactions_loaded_event.dart';
import 'package:money_mantor/viewmodels/transaction_viewmodel.dart';

class TransactionWidget extends StatefulWidget {
  final Transaction? transaction;
  const TransactionWidget({
    super.key,
    this.transaction
  });

  @override
  State<StatefulWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget>
    implements EventObserver {
  final TransactionViewModel _viewModel =
      TransactionViewModel(TransactionRepo());
  final List<DropdownMenuEntry> _dropDownMenuEntries =
      List.empty(growable: true);
  double? _amount;
  String? _details;
  DateTime _dateTime = DateTime.now();
  TransactionType? _transactionType;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _viewModel.subscribe(this);
    for (var element in TransactionType.values) {
      _dropDownMenuEntries
          .add(DropdownMenuEntry(value: element, label: element.name));
    }

    _amount = widget.transaction!.amount;
    _details = widget.transaction!.note;
    _dateTime = widget.transaction!.dateTime;
    _transactionType = widget.transaction!.transactionType;
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text("Customer name"),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    initialValue: _amount != null ? _amount.toString() : "",
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Amount",
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    onChanged: (value) => {
                      _amount = double.parse(value),
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    initialValue: _details??"",
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter details (Note, bill no etc)"),
                    onChanged: (value) => {
                      _details = value,
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 10,
                        child: DateTimeFormField(
                          onChanged: (value) => {_dateTime = value!},
                          initialValue: _dateTime,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          initialPickerDateTime: _dateTime,
                          dateFormat: DateFormat("dd/MM/yyyy hh:mm:ss"),
                          mode: DateTimeFieldPickerMode.dateAndTime,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      DropdownMenu(
                        onSelected: (value) => {
                          _transactionType = value,
                        },
                        hintText: 'Select Type',
                        initialSelection: _transactionType ?? "",
                        dropdownMenuEntries: _dropDownMenuEntries,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextButton(
                    onPressed: () {
                      Transaction transaction = Transaction(
                        personId: 1,
                        amount: _amount!,
                        transactionType: _transactionType!,
                        note: _details!,
                        dateTime: _dateTime,
                      );
                      _viewModel.add(transaction);
                    },
                    child: const Text("Save"),
                  ),
                )
              ],
            ),
          );
  }

  @override
  void notify(ViewEvent event) {
    Global.Log.i('Recieved: $event');

    if (event is LoadingEvent) {
      setState(
        () {
          _isLoading = event.isLoading;
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
}
