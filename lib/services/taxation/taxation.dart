import 'dart:math';

import 'package:money_mantor/di/locator.dart';
import 'package:money_mantor/repository/taxation_repo.dart';

// ignore: constant_identifier_names
const double SECTION_80C_MAX_LIMIT = 150000;

class Taxation {
  TaxationRepo? _repo;
  Taxation() {
    _repo = locator<TaxationRepo>();
  }
  double section80C() {
    double res = 0;
    _repo!.fetchById(1).then((value) => {
      res = value!.elss + value.lic
    },);
    return min(res, SECTION_80C_MAX_LIMIT);
  }

  double section10() {
    double res = 0;

    return res;
  }
}
