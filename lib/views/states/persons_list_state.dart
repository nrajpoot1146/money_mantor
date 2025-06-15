import 'package:flutter/material.dart';
import 'package:money_mantor/models/saving_data_model_base.dart';

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
  int touchIndex = -1;
  double totalAmount = 12000;
  List<Color> randomColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
  ];

  @override
  void initState() {
    super.initState();
    savingData.addAll([
      SavingDataModelBase("Banks", 4000, SavingType.bankAccount),
      SavingDataModelBase("EPFO", 3000, SavingType.epfoAccount),
      SavingDataModelBase("NPS", 5000, SavingType.nps),
    ]);
  }
}

abstract class SavingDetailsStatefulWidget extends StatefulWidget {
  const SavingDetailsStatefulWidget({super.key});
}
