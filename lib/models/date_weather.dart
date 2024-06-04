class DateWeather{
final double temp;
final String country;
final String city;
final String skyState;
final double wind;
final double tempmin;
final double tempmax;
final double feelslike;
final double pressure;
final double humidity;



DateWeather({
  required this.temp,
  required this.city,
  required this.skyState ,
  required this.wind, 
  required this.tempmax,
  required this.tempmin,
  required this.feelslike,
  required this.country,
  required this.pressure,
  required this.humidity


  });
factory DateWeather.fromJson(Map<String , dynamic> json){
  String city = json["name"];
  String country = json["sys"]["country"];
  double temp = (json["main"]["temp"]as num).toDouble();
  double tempmin = (json["main"]["temp_min"] as num).toDouble();
  double tempmax = (json["main"]["temp_max"] as num).toDouble();
  double feelslike = (json["main"]["feels_like"] as num).toDouble();
  double wind = (json["wind"]["speed"] as num).toDouble();
  double pressure = (json["main"]["pressure"] as num).toDouble();
  double humidity = (json["main"]["humidity"] as num).toDouble();
  String skyState = json["weather"][0]["main"];


  return DateWeather(
    temp: temp,
    city: city,
    skyState: skyState,
    wind: wind ,
    tempmax: tempmax,
    tempmin: tempmin ,
    feelslike: feelslike,
    country: country,
    pressure: pressure,
    humidity: humidity);
}



}