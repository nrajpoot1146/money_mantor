import 'package:flutter/material.dart';
import 'package:money_mantor/models/saving_data_model_base.dart';
import 'package:money_mantor/views/widgets/custom_pie_chart.dart';

abstract class SavingDetailsState<T extends SavingDetailsStatefulWidget>
    extends State<T> {
  List<String> menuOptions = [
    'Bank Balance',
    'EPFO Balance',
    'NPS',
    'FD',
    'Stocks'
  ];

  List<SavingDataModelBase> savingData = [];
  List<CustomPieChartData> pieChartData = [];
  List<bool> isTextBold = [];
  int touchIndex = -1;
  double totalAmount = 12000;
  List<Color> randomColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.indigoAccent,
    Colors.purple,
    Colors.orange,
  ];

  FontWeight textFontWeight = FontWeight.normal;

  @override
  void initState() {
    super.initState();
    savingData.addAll([
      SavingDataModelBase("Banks", 4000, SavingType.bankAccount),
      SavingDataModelBase("EPFO", 3000, SavingType.epfoAccount),
      SavingDataModelBase("NPS", 5000, SavingType.nps),
      SavingDataModelBase("Other", 6000, SavingType.other),
      SavingDataModelBase("Stocks", 6000, SavingType.stocks),
      SavingDataModelBase("FD", 6000, SavingType.fdAccount),
    ]);

    // prepare data for piechart
    savingData.forEach((data) => pieChartData.add(
        CustomPieChartData(label: data.getName(), value: data.getAmount())));
  }
}

abstract class SavingDetailsStatefulWidget extends StatefulWidget {
  const SavingDetailsStatefulWidget({super.key});
}
