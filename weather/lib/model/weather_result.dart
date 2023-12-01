WeatherResult? weatherResult;

class WeatherResult {
  int baseDate;
  String baseTime;
  String category;

  WeatherResult(
      {required this.baseDate, required this.baseTime, required this.category});

  WeatherResult.fromJson(Map<String, dynamic> json)
      : baseDate = json['baseDate'],
        baseTime = json['baseTime'],
        category = json['category'];

  Map<String, dynamic> toJson() =>
      {'baseDate': baseDate, 'baseTime': baseTime, 'category': category};
}
