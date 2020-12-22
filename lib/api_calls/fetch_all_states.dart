import '../models/state.dart';
import '../models/station.dart';
import '../api_calls/fetch_all_stations.dart';

List<StationState> fetchAllStates(List<Station> waStations) { 
  return [
      StationState('Washington', 'WA', waStations),
      StationState('Idaho', 'ID', waStations),
    ];
}