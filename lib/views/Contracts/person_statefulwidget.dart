import 'package:flutter/material.dart';

import '../../models/person_model.dart';

abstract class PersonStatefulWidget extends StatefulWidget{
  final Person? person;
  const PersonStatefulWidget({super.key, this.person});
}