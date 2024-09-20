
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/key.dart';
import 'package:weather_app/models/date_weather.dart';


class ServiceWeather{
// API
static String bascAPI = "http://api.openweathermap.org/data/2.5/weather";



// get the Weather
Future<DateWeather> getWeather(double latitude , double longitude) async {
  final response = await http.get(Uri.parse("$bascAPI?lat=$latitude&lon=$longitude&appid=$apiWeatherKey&units=metric"));
  if( response.statusCode == 200){
  return DateWeather.fromJson(jsonDecode(response.body));
  }
  else{
    throw Exception("ERROR IN API");
  }
}
// Get the City 
Future<Position> getpositin() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied){
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.deniedForever) {
      // Handle the case where the user denied the permission forever.
      throw Exception("Location permissions are permanently denied, we cannot request permissions.");
    }

  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high
  );


  return position ;

}

}