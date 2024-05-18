import 'package:flutter/material.dart';
import 'package:money_mantor/models/person_model.dart';
import 'package:money_mantor/repository/person_repo.dart';
import 'package:money_mantor/viewmodels/events/person_events/person_deleted_event.dart';
import 'package:money_mantor/views/Contracts/persons_statefulwidget.dart';

import '../../mvvm/observer.dart';
import '../../viewmodels/events/person_events/person_add_event.dart';
import '../../viewmodels/events/person_events/person_loaded_event.dart';
import '../../viewmodels/person_viewmodel.dart';

abstract class TransactionsState<T extends PersonsStatefulWidget>
    extends State<T> implements EventObserver {
  final PersonViewModel viewModel = PersonViewModel(PersonRepo());
  bool isLoading = false;
  List<Person> transactions = List.empty();

  @override
  void notify(ViewEvent event) {
    if (event is PersonAddEvent) {
          } else if (event is PersonDeletedEvent) {

    } else if (event is PersonLoadedEvent){}
  }
}
