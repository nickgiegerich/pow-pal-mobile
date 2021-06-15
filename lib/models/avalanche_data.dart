
class AvalancheData  {
  int id;
  List<Coordinates> coordinates = [];
  String name;
  String center;
  String timezone;
  String state;
  String travelAdvice;
  String danger;
  int dangerLevel;
  String color;
  String stroke;
  String fontColor;
  String link;

  AvalancheData(
      {this.id,
      this.coordinates,
      this.name,
      this.center,
      this.timezone,
      this.state,
      this.travelAdvice,
      this.danger,
      this.dangerLevel,
      this.color,
      this.stroke,
      this.fontColor,
      this.link});

  AvalancheData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['coordinates'] != null) {
      coordinates = new List<Coordinates>.empty(growable: true);
      json['coordinates'].forEach((v) {
        coordinates.add(new Coordinates.fromJson(v));
      });
    }
    name = json['name'];
    center = json['center'];
    timezone = json['timezone'];
    state = json['state'];
    travelAdvice = json['travel_advice'];
    danger = json['danger'];
    dangerLevel = json['danger_level'];
    color = json['color'];
    stroke = json['stroke'];
    fontColor = json['font_color'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['center'] = this.center;
    data['timezone'] = this.timezone;
    data['state'] = this.state;
    data['travel_advice'] = this.travelAdvice;
    data['danger'] = this.danger;
    data['danger_level'] = this.dangerLevel;
    data['color'] = this.color;
    data['stroke'] = this.stroke;
    data['font_color'] = this.fontColor;
    data['link'] = this.link;
    return data;
  }
}

class Coordinates {
  int id;
  double lat;
  double lon;
  int idOfArea;

  Coordinates({this.id, this.lat, this.lon, this.idOfArea});

  Coordinates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lat = json['lat'];
    lon = json['lon'];
    idOfArea = json['id_of_area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['id_of_area'] = this.idOfArea;
    return data;
  }
}

