import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:money_mantor/views/Contracts/transaction_state.dart';
import 'package:money_mantor/views/Contracts/transaction_statefulwidget.dart';

class TransactionWidget extends TransactionStatefulWidget {
  const TransactionWidget({super.key, super.transaction});

  @override
  State<StatefulWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends TransactionState<TransactionWidget> {
  @override
  Widget build(BuildContext context) {
    return isLoading
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
                    initialValue: amount != null ? amount.toString() : "",
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
                    onChanged: onAmountChange,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    initialValue: details ?? "",
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter details (Note, bill no etc)"),
                    onChanged: onNoteChange,
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
                          onChanged: onDateTimeChange,
                          initialValue: dateTime,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          initialPickerDateTime: dateTime,
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
                        onSelected: onTransactionTypeChange,
                        hintText: 'Select Type',
                        initialSelection: transactionType ?? "",
                        dropdownMenuEntries: dropDownMenuEntries,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextButton(
                    onPressed: onSaveButtonPressed,
                    child: const Text("Save"),
                  ),
                )
              ],
            ),
          );
  }
}
