import '../models/station.dart';
import '../api_calls/fetch_all_stations.dart';

class StationState {
  final String name;
  final String shortName;
  final List<Station> stateStations;

  StationState(this.name, 
               this.shortName,
               this.stateStations);
  
  List<StationState> fetchAllStates() {
    List<Station> waStations = [];

    fetchAllStations().then((data){
      waStations = data;
    });

    return [
      StationState('Washington', 'WA', waStations),
      StationState('Idaho', 'ID', waStations),
    ];
  }
 }