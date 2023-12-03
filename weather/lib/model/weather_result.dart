WeatherResult? weatherResult;

class WeatherResult {
  int baseDate;
  String baseTime;
  String temperture;

  WeatherResult(
      {required this.baseDate,
      required this.baseTime,
      required this.temperture});

  WeatherResult.fromJson(Map<String, dynamic> json)
      : baseDate = json['baseDate'],
        baseTime = json['baseTime'],
        temperture = json['temperture'];

  Map<String, dynamic> toJson() =>
      {'baseDate': baseDate, 'baseTime': baseTime, 'temperture': temperture};
}
