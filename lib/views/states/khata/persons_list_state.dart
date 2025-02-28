import 'package:flutter/material.dart';
import 'package:money_mantor/di/locator.dart';
import 'package:money_mantor/models/person_model.dart';
import 'package:money_mantor/viewmodels/events/loading_event.dart';
import 'package:money_mantor/viewmodels/events/person_events/person_deleted_event.dart';
import 'package:money_mantor/viewmodels/events/person_events/person_loaded_event.dart';
import 'package:money_mantor/viewmodels/events/person_events/total_amount_loaded_event.dart';

import '../../../viewmodels/person_viewmodel.dart';

abstract class PersonsListState<T extends PersonsStatefulWidget> extends State<T> {
  final PersonViewModel viewModel = locator<PersonViewModel>();
  
  bool isLoading = false;
  List<Person> personsList = List.empty();
  Map<int, double> totalAmountByPersonId = {};

  @override
  void initState() {
    viewModel.on<LoadingEvent>().listen(
          (p0) => setState(
            () {
              isLoading = p0.isLoading;
            },
          ),
        );

    viewModel.on<PersonLoadedEvent>().listen(
          (p0) => {
            setState(
              () {
                personsList = p0.data;
              },
            ),
            for(var p in personsList){
              viewModel.fetchNetTotalAmountByPerson(p)
            }
          },
        );

    viewModel.on<TotalAmountLoadedEvent>().listen(
          (p0) => setState(
            () {
              totalAmountByPersonId[int.parse(p0.data['personid']!)] = double.parse(p0.data["amount"]!);
            },
          ),
        );

    viewModel.on<PersonDeletedEvent>().listen((p0) => viewModel.fetchAll());
    viewModel.fetchAll();
    super.initState();
  }
}

abstract class PersonsStatefulWidget extends StatefulWidget{
  const PersonsStatefulWidget({super.key});
}
