import '../../../models/person_model.dart';
import '../loaded_event.dart';

class PersonLoadedEvent extends LoadedEvent<List<Person>> {
  PersonLoadedEvent(List<Person> data) : super("$PersonLoadedEvent", data);
}
