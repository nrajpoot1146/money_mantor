import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:money_mantor/di/configure_dependencies.dart';
import 'package:money_mantor/global.dart';
import 'package:money_mantor/views/widgets/custom_listtile.dart';

class SavingDetailListItem extends StatelessWidget {
  final int? index;
  final String name;
  final Function(String)? ontap;
  final Function(String)? onHover;
  final double amount;
  const SavingDetailListItem(
      {super.key, required this.name, this.index, this.ontap, required this.amount, this.onHover});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      child: CustomListTile(
        index: index,
        onTap: (index)=>{locator<Logger>().t(index)},
        title: Container(
          alignment: Alignment.centerLeft,
          height: 30,
          child: Text(name, style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),),
        ),
        subtitle: Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 2),
          child: Text(
            "Last updated: ${DateTimeFormat.onlyDate(DateTime.now())}",
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 10),
          ),
        ),
        trailing: Expanded(flex: 0, child: Text(amount.toStringAsFixed(2))),
      ),
      // child: ListTile(
      //   contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
      //   onTap: () => ontap!(name),
      //   title: Row(
      //     children: [
      //       Expanded(flex: 7, child: Text(name)),
      //       Expanded(
      //         flex: 4,
      //         child: Text(
      //           "₹ ${amount.toStringAsFixed(2)}",
      //           style: TextStyle(color: amount < 0 ? Colors.red : Colors.green),
      //           textAlign: TextAlign.right,
      //         ),
      //       )
      //     ],
      //   ),
      //   subtitle: Container(
      //     margin: const EdgeInsets.only(top: 2),
      //     child: Text(
      //       "Last updated: ${DateTimeFormat.onlyDate(DateTime.now())}",
      //       textAlign: TextAlign.right,
      //       style: const TextStyle(fontSize: 10),
      //     ),
      //   ),
      //   tileColor: Colors.grey[200],
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      // ),
    );
  }
}
