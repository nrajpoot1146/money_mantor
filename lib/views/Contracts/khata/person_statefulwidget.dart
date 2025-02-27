import 'package:flutter/material.dart';

import '../../../models/person_model.dart';

abstract class PersonAddNewStatefulWidget extends StatefulWidget{
  final Person? person;
  const PersonAddNewStatefulWidget({super.key, this.person});
}