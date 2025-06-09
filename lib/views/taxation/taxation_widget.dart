import 'package:flutter/material.dart';
import 'package:money_mantor/views/states/taxation/taxation_state.dart';
import 'package:money_mantor/views/states/taxation/taxation_statefulwidget.dart';

class TaxationWidget extends TaxationStatefulWidget {
  const TaxationWidget({super.key});

  //const PersonWidget({super.key, super.person});

  @override
  State<StatefulWidget> createState() => _TexationState();
}

class _TexationState extends TaxationState<TaxationWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(""),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: const Column(
        children: [
          
        ],
      ),
    );
  }
}
