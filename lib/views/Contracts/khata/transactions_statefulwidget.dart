import 'package:flutter/material.dart';

import '../../../models/person_model.dart';

abstract class TransactionsStatefulWidget extends StatefulWidget{
  final Person person;
  const TransactionsStatefulWidget({super.key, required this.person});
}