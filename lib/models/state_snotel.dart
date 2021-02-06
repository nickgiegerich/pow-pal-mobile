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
  String id;
  String name;
  String state;
  List<WeeklyData> weeklyData;
  List<HourlyData> hourlyData;
  // double startSnowWaterEq;
  // double changeSnowWaterEq;
  // double startSnowDepth;
  // double changeSnowDepth;

  Stations(
      {this.id,
      this.name,
      this.state,
      this.weeklyData, 
      this.hourlyData,
      // this.startSnowWaterEq,
      // this.changeSnowWaterEq,
      // this.startSnowDepth,
      // this.changeSnowDepth,
      });

  Stations.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    state = json['state'];
    if (json['weekly_snow'] != null) {
      weeklyData = new List<WeeklyData>();
      json['weekly_snow'].forEach((v) {
        weeklyData.add(new WeeklyData.fromJson(v));
      });
    }
    if (json['hourly_snow'] != null) {
      hourlyData = new List<HourlyData>();
      json['hourly_snow'].forEach((v) {
        hourlyData.add(new HourlyData.fromJson(v));
      });
    }
    // startSnowWaterEq = json['start_snow_water_eq'].toDouble();
    // changeSnowWaterEq = json['change_snow_water_eq'].toDouble();
    // startSnowDepth = json['start_snow_depth'].toDouble();
    // changeSnowDepth = json['change_snow_depth'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state'] = this.state;
    data['weekly_snow'] = this.weeklyData;
    data['hourly_snow'] = this.hourlyData;
    return data;
    // data['start_snow_water_eq'] = this.startSnowWaterEq;
    // data['change_snow_water_eq'] = this.changeSnowWaterEq;
    // data['start_snow_depth'] = this.startSnowDepth;
    // data['change_snow_depth'] = this.changeSnowDepth;
  }
}

class WeeklyData { 
  String id;
  String dataType;
  String date;
  String stationName;
  double startSnowWaterEq;
  double snowDepth;
  double precipAccumulation;
  double airTemp;
  double maxAirTemp;
  double minAirTemp;
  double avgAirTemp;
  int stationNumber;


  WeeklyData({
    this.id,
    this.dataType,
    this.date,
    this.stationName,
    this.startSnowWaterEq,
    this.snowDepth,
    this.precipAccumulation,
    this.airTemp,
    this.maxAirTemp,
    this.minAirTemp,
    this.avgAirTemp, 
    this.stationNumber
  });

  WeeklyData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    dataType = json['data_type'];
    date = json['date'];
    stationName = json['station_name'];
    startSnowWaterEq = json['start_snow_water_eq'].toDouble();
    snowDepth = json['snow_depth'].toDouble();
    precipAccumulation = json['precip_accumulation'].toDouble();
    airTemp = json['air_temp'].toDouble();
    maxAirTemp = json['max_air_temp'].toDouble();
    minAirTemp = json['min_air_temp'].toDouble();
    avgAirTemp = json['avg_air_temp'].toDouble();
    stationNumber = json['station'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data_type'] = this.dataType;
    data['date'] = this.date;
    data['station_name'] = this.stationName;
    data['start_snow_water_eq'] = this.startSnowWaterEq;
    data['snow_depth'] = this.snowDepth;
    data['precip_accumulation'] = this.precipAccumulation;
    data['air_temp'] = this.airTemp;
    data['max_air_temp'] = this.maxAirTemp;
    data['min_air_temp'] = this.minAirTemp;
    data['avg_air_temp'] = this.avgAirTemp;
    data['station'] = this.stationName;
    return data;
  }
}

class HourlyData { 
  String id;
  String dataType;
  String dateTime;
  String stationName;
  double snowWaterEq;
  double snowDepth;
  double precipAccumulation;
  double observedAirTemp;
  int stationNumber;


  HourlyData({
    this.id,
    this.dataType,
    this.dateTime,
    this.stationName,
    this.snowWaterEq,
    this.snowDepth,
    this.precipAccumulation,
    this.observedAirTemp,
    this.stationNumber
  });

  HourlyData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    dataType = json['data_type'];
    dateTime = json['date_time'];
    stationName = json['station_name'];
    snowWaterEq = json['snow_water_eq'].toDouble();
    snowDepth = json['snow_depth'].toDouble();
    precipAccumulation = json['precip_accumulation'].toDouble();
    observedAirTemp = json['observed_air_temp'].toDouble();
    stationNumber = json['station'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data_type'] = this.dataType;
    data['date_time'] = this.dateTime;
    data['station_name'] = this.stationName;
    data['snow_water_eq'] = this.snowWaterEq;
    data['snow_depth'] = this.snowDepth;
    data['precip_accumulation'] = this.precipAccumulation;
    data['observed_air_temp'] = this.observedAirTemp;
    data['station'] = this.stationName;
    return data;
  }
}
