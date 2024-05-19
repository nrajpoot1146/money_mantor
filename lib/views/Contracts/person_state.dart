import 'package:flutter/material.dart';
import 'package:money_mantor/repository/person_repo.dart';
import 'package:money_mantor/viewmodels/events/loading_event.dart';
import 'package:money_mantor/viewmodels/events/person_events/person_add_event.dart';
import 'package:money_mantor/viewmodels/person_viewmodel.dart';
import 'package:money_mantor/views/Contracts/person_statefulwidget.dart';

import '../../models/person_model.dart';

abstract class PersonState<T extends PersonStatefulWidget> extends State<T> {
  final PersonViewModel viewModel = PersonViewModel(PersonRepo());
  final Person person = Person.fromEmpty();
  bool isLoading = false;

  @override
  void initState() {
    viewModel.on<LoadingEvent>().listen(
          (p0) => setState(
            () {
              isLoading = p0.isLoading;
            },
          ),
        );

    viewModel.on<PersonAddEvent>().listen(
          (p0) => {
            Navigator.of(context).pop()
          },
        );
    super.initState();
  }

  @protected
  void onNameChanged(String name){
    person.name = name;
  }

  @protected
  void onEmailChanged(String email){
    person.emailId = email;
  }

  @protected
  void onMobileNoChanged(String mobno){
    person.mobileNo = mobno;
  }

  @protected
  void onSaveButtonPressed(){
    viewModel.updateOrAdd(person);
  }
}
