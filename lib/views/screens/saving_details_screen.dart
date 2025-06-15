import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:money_mantor/di/configure_dependencies.dart';
import 'package:money_mantor/views/states/persons_list_state.dart';
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
          SizedBox(
            width: 300,
            height: 250,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 70,
                sections: savingData.asMap().entries.map(
                  (mapentry) {
                    return PieChartSectionData(
                      value: mapentry.value.getAmount(),
                      color: randomColors[mapentry.key%randomColors.length],
                      title: "${((mapentry.value.getAmount() / totalAmount) * 100)
                          .toStringAsFixed(0)} %",
                      radius: touchIndex == mapentry.key ? 25 : 20,
                      titleStyle: const TextStyle(
                        fontSize: 10,
                      ),
                    );
                  },
                ).toList(),
                pieTouchData:
                    PieTouchData(touchCallback: (touchEvent, touchResponse) {
                  var touchIndex =
                      touchResponse!.touchedSection!.touchedSectionIndex;
                  setState(() {
                    this.touchIndex = touchIndex;
                  });
                }),
              ),
            ),
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
