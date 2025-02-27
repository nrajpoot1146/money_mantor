import 'package:flutter/cupertino.dart';
import 'package:money_mantor/models/transaction_model.dart';

import '../../../models/person_model.dart';

abstract class TransactionStatefulWidget extends StatefulWidget{
  final Transaction? transaction;
  final Person person;

  const TransactionStatefulWidget({super.key, this.transaction, required this.person});
}