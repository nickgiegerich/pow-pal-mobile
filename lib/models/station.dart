class Station { 
  final int id;
  final String name;
  final double startSnowWaterEq;
  final double changeInSnowWaterEq;
  final double startSnowDepth;
  final double changeSnowDepth;

  Station(this.name, 
          this.id, 
          this.startSnowWaterEq, 
          this.changeInSnowWaterEq, 
          this.startSnowDepth, 
          this.changeSnowDepth);
  
  static List<Station> fetchAll() { 
    return [
      Station('Alpine Meadows',908,7.9,0.5,20,2),
      Station('Beaver Pass',990,9.5,0.0,0.0,0.0),
      Station('Blewett Pass',352,2.7,0.1,8,2),
      Station('Brown Top',1080,15.2,0.0,47,2),
      Station('Buckinghorse',1107,10.5,-0.2,33,1),
    ];
  }

  static Station fetchByID(int stationID) { 
    List<Station> stations = Station.fetchAll();
    for (var i = 0; i < stations.length; i++) { 
      if (stations[i].id == stationID) { 
        return stations[i];
      }
    }
      return null;
  }
}
 



