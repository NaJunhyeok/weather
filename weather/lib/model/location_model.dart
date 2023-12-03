LocationModel? locationModel;

class LocationModel {
  double latitude;
  double longitude;

  LocationModel({required this.latitude, required this.longitude});

  LocationModel.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'],
        longitude = json['longitude'];

  Map<String, dynamic> toJson() =>
      {'latitude': latitude, 'longtitude': longitude};
}
