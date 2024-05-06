import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_mantor/models/transaction_model.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  final Function? onTap;
  final Function? onLongPress;
  const TransactionListItem({
    super.key,
    required this.transaction,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // alignment: Alignment.,
      height: 75,
      child: InkWell(
        onTap: () {
          if (onTap != null) onTap!(transaction);
        },
        onLongPress: () => onLongPress,
        child: Card(
          color: Colors.grey[50],
          shape: const BeveledRectangleBorder(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat("d MMM yyyy HH:MM")
                            .format(transaction.dateTime)
                            .toString(),
                        style: const TextStyle(fontSize: 10),
                      ),
                      const Align(
                        heightFactor: 1.7,
                        alignment: Alignment.centerLeft,
                        child: Text("amount"),
                      ),
                      Text(
                        transaction.note
                            .substring(0, min(transaction.note.length, 30)),
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.red[50],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (transaction.transactionType == TransactionType.Given)
                            ? transaction.amount.toString()
                            : "",
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
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
                    children: [
                      Text(
                        (transaction.transactionType == TransactionType.Taken)
                            ? transaction.amount.toString()
                            : "",
                        style: const TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
