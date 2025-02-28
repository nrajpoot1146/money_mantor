import 'package:flutter/material.dart';
import 'package:money_mantor/di/locator.dart';
import 'package:money_mantor/viewmodels/home_screen_viewmodel.dart';

abstract class HomeScreenState<T extends HomeScreenStatefulWidget> extends State<T> {
  final HomeScreenViewmodel viewModel = locator<HomeScreenViewmodel>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }
}

abstract class HomeScreenStatefulWidget extends StatefulWidget{
  const HomeScreenStatefulWidget({super.key});
}
