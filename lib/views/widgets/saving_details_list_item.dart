import 'package:flutter/material.dart';
import 'package:money_mantor/global.dart';

class SavingDetailListItem extends StatelessWidget {
  final String name;
  final Function(String)? ontap;
  final double amount;
  const SavingDetailListItem(
      {super.key, required this.name, this.ontap, required this.amount});

  @override
  Widget build(BuildContext context) {
    Global.Log.t("build $amount");
    return Container(
      margin: const EdgeInsets.all(1),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10, right: 10),
        onTap: () => ontap!(name),
        title: Row(
          children: [
            Expanded(flex: 7, child: Text(name)),
            Expanded(
              flex: 4,
              child: Text(
                "₹ ${amount.toStringAsFixed(2)}",
                style: TextStyle(color: amount < 0 ? Colors.red : Colors.green),
                textAlign: TextAlign.right,
              ),
            )
          ],
        ),
        // subtitle: Text(
        //   amount.toString(),
        //   style: TextStyle(color: amount < 0 ? Colors.red : Colors.green),
        //   textAlign: TextAlign.right,
        // ),
        tileColor: Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
