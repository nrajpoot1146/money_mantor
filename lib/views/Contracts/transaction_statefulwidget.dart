import 'package:flutter/cupertino.dart';
import 'package:money_mantor/models/transaction_model.dart';

abstract class TransactionStatefulWidget extends StatefulWidget{
  final Transaction? transaction;

  const TransactionStatefulWidget({super.key, this.transaction});
}