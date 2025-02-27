import '../loaded_event.dart';

class TotalAmountLoadedEvent extends LoadedEvent<Map<String, String>> {
  TotalAmountLoadedEvent(Map<String, String> data) : super("$TotalAmountLoadedEvent", data);
}
