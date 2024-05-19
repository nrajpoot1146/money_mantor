import 'package:flutter/material.dart';
import 'package:money_mantor/models/person_model.dart';
import 'package:money_mantor/repository/person_repo.dart';
import 'package:money_mantor/viewmodels/events/loading_event.dart';
import 'package:money_mantor/viewmodels/events/person_events/person_deleted_event.dart';
import 'package:money_mantor/viewmodels/events/person_events/person_loaded_event.dart';
import 'package:money_mantor/views/Contracts/persons_statefulwidget.dart';

import '../../viewmodels/person_viewmodel.dart';

abstract class PersonsState<T extends PersonsStatefulWidget> extends State<T> {
  final PersonViewModel viewModel = PersonViewModel(PersonRepo());
  bool isLoading = false;
  List<Person> personsList = List.empty();

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
          (p0) => setState(
            () {
              personsList = p0.data;
            },
          ),
        );

    viewModel.on<PersonDeletedEvent>().listen((p0) => viewModel.fetchAll());
    viewModel.fetchAll();
    super.initState();
  }
}
