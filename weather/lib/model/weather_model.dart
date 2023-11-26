WeatherModel? weatherModel;

class WeatherModel {
  String locationName;

  WeatherModel({required this.locationName});

  WeatherModel.fromJson(Map<String, dynamic> json)
      : locationName = json['locationName'];

  Map<String, dynamic> toJson() => {'locationName': locationName};
}
