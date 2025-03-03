import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_mantor/models/transaction_model.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  final Function(Transaction)? onTap;
  final Function(Transaction)? onLongPress;
  const TransactionListItem({
    super.key,
    required this.transaction,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.,
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.all(2),
      
      height: 70,
      child: InkWell(
          onTap: () => {
            if (onTap != null) onTap!(transaction),
          },
          onLongPress: () => {
            if (onLongPress != null) onLongPress!(transaction),
          },
          splashColor: const Color.fromARGB(138, 131, 134, 131),
          splashFactory: InkRipple.splashFactory,
          child: Card(
            margin: const EdgeInsets.all(0),
            shape: const BeveledRectangleBorder(),
            color: const Color.fromARGB(161, 255, 255, 255),
            child: Row(
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 2, 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat("d MMM yyyy HH:MM")
                              .format(transaction.dateTime)
                              .toString(),
                          style: const TextStyle(fontSize: 10),
                        ),
                        const Align(
                          heightFactor: 1,
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
                    color: const Color.fromARGB(53, 255, 235, 238),
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
                    color: const Color.fromARGB(100, 232, 245, 233),
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
