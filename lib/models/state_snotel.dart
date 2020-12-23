class StateSnotel {
  String state;
  String stateId;
  List<Stations> stations;

  StateSnotel({this.state, this.stateId, this.stations});

  StateSnotel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    stateId = json['state_id'];
    if (json['stations'] != null) {
      stations = new List<Stations>();
      json['stations'].forEach((v) {
        stations.add(new Stations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['state_id'] = this.stateId;
    if (this.stations != null) {
      data['stations'] = this.stations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stations {
  int id;
  String name;
  double startSnowWaterEq;
  double changeSnowWaterEq;
  double startSnowDepth;
  double changeSnowDepth;
  String state;

  Stations(
      {this.id,
      this.name,
      this.startSnowWaterEq,
      this.changeSnowWaterEq,
      this.startSnowDepth,
      this.changeSnowDepth,
      this.state});

  Stations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startSnowWaterEq = json['start_snow_water_eq'].toDouble();
    changeSnowWaterEq = json['change_snow_water_eq'].toDouble();
    startSnowDepth = json['start_snow_depth'].toDouble();
    changeSnowDepth = json['change_snow_depth'].toDouble();
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['start_snow_water_eq'] = this.startSnowWaterEq;
    data['change_snow_water_eq'] = this.changeSnowWaterEq;
    data['start_snow_depth'] = this.startSnowDepth;
    data['change_snow_depth'] = this.changeSnowDepth;
    data['state'] = this.state;
    return data;
  }
}
