import 'package:flutter/material.dart';

abstract class SavingDetailsState<T extends SavingDetailsStatefulWidget> extends State<T> {
  List<String> menuOptions = ['Bank Balance', 'EPFO Balance', 'NPC', 'FD', 'Stocks'];
  @override
  void initState() {
    super.initState();
  }
}

abstract class SavingDetailsStatefulWidget extends StatefulWidget{
  const SavingDetailsStatefulWidget({super.key});
}
