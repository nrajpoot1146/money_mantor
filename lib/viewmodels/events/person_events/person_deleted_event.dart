import '../../../models/person_model.dart';
import '../deleted_event.dart';

class PersonDeletedEvent extends DeletedEvent<Person> {
  PersonDeletedEvent(Person data) : super("$PersonDeletedEvent", data);
}
