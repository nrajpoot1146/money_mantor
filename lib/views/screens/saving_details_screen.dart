import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:money_mantor/di/configure_dependencies.dart';
import 'package:money_mantor/views/states/saving_details_screen_state.dart';
import 'package:money_mantor/views/widgets/custom_pie_chart.dart';
import 'package:money_mantor/views/widgets/saving_details_list_item.dart';

class SavingDetailsScreen extends SavingDetailsStatefulWidget {
  const SavingDetailsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SavingDetailsState();
}

class _SavingDetailsState extends SavingDetailsState<SavingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      appBar: AppBar(
          title: const Text("Customers"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: Column(
        children: [
          Container(
            //width: 300,
            height: 250,
            alignment: Alignment.centerLeft,
            child: CustomPieChart(data: pieChartData)
          ),
          Expanded(
            child: ListView.builder(
              itemCount: menuOptions.length,
              itemBuilder: (context, index) {
                return SavingDetailListItem(
                    name: menuOptions[index], index: index, amount: 100);
              },
            ),
          )
        ],
      ),
      floatingActionButton: Builder(
        builder: (BuildContext context) {
          return PopupMenuButton<String>(
            onSelected: (value) => {locator<Logger>().t("Selected: $value")},
            itemBuilder: (BuildContext context) => menuOptions.map((option) {
              return PopupMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            child: const FloatingActionButton(
              onPressed: null,
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
