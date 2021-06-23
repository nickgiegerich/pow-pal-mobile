class StateModel {
  String fullName;
  String shortName;
  int stationCount;

  StateModel({this.fullName, this.shortName, this.stationCount});

  StateModel.fromJson(Map<String, dynamic> json) {
    fullName = json['state'];
    shortName = json['state_id'];
    stationCount = json['station_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.fullName;
    data['state_id'] = this.shortName;
    data['station_count'] = this.stationCount;
    return data;
  }
}
