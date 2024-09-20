

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/colors.dart';
import 'package:weather_app/models/date_weather.dart';
import 'package:weather_app/service/service.dart';
import 'package:weather_app/widgets/container.dart';

class WeatherPage extends StatefulWidget{
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final weatherSeveice = ServiceWeather();
  DateWeather? weather;


@override
void initState() {
  super.initState();
  showDate();
}
// Time
  bool isDayTime() {
    DateTime now = DateTime.now();
    int hour = int.parse(DateFormat('H').format(now));
    return hour >= 6 && hour < 18;
  }

  // Animtions
  String getAnumtions(String? skyState){
    if (skyState == null) return "assets/sunny.json";
  bool daytime = isDayTime();
    switch(skyState.toLowerCase()){
    case "clear":
    case "sunny":
    return daytime? "assets/sunny.json" : "assets/clear.night.json";
    case "rain":
    case "light rain":
    case "moderate rain":
    case "drizzle":
    case "shower rain":
      return daytime? "assets/rain.morning.json" : "assets/rain.night.json";
    case "clouds":
    case "overcast clouds":
    case "few clouds":
    case "scattered clouds":
    case "mist":
    case "smoke":
    case "haze":
    case "dust":
    case "fog":
      return "assets/cloud.json"; 
    case "thunderstorm":
      return "assets/Thunderstorm.json";
    default:
      return daytime? "assets/sunny.json" : "assets/clear.night.json"; // Default to sunny animation
    }
  }

 // to get the date 
  Future<void> showDate() async {
    try{
    Position position = await weatherSeveice.getpositin();
    double latitudew = position.latitude;
    double longitudew = position.longitude;
    final weather_ = await weatherSeveice.getWeather(latitudew , longitudew);
    setState(() {
      weather = weather_; 
    });
    } 
    catch(e){
      if(mounted){
              ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unable to retrieve weather data. Please try again later.") ,
          backgroundColor: Colors.red,)
      );
      }
    }
  }
  // UI FOR SCREEN
  @override
  Widget build(BuildContext context) {
  bool daytimescreen = isDayTime();
  // Background for screen 
    String backgroundImage = daytimescreen ? 'assets/a3.jpeg' : 'assets/m6.jpeg' ;
  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage( backgroundImage ), fit: BoxFit.cover)
      ),
      child: SafeArea(
        child: 
          Center(
            child: weather == null ? const CircularProgressIndicator():
              ListView(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child:Container(
                    // For Text time // Day 
                    padding: const EdgeInsets.all(8.0),
                    margin:const EdgeInsets.all(7),
                    child: Text( DateFormat.MMMMEEEEd().format(DateTime.now()) ,
                    style:const TextStyle(color: white , fontSize: 20 , fontWeight: FontWeight.bold),),
                  ),
                ),
                const SizedBox(height: 50),
                // to make the text in center 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // City
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${weather?.country?? "Loading.."} ," , style: const TextStyle(
                        fontWeight: FontWeight.bold , fontSize: 20,color: white),),
                        Text("${weather?.city?? "Loading.."} " , style: const TextStyle(
                        fontWeight: FontWeight.bold , fontSize: 20,color: white),),
                      ],
                    ),
                // Anmition
                const SizedBox(height: 10),
                Lottie.asset(getAnumtions(weather?.skyState)),
                // Temp
                const SizedBox(height: 30),
                Text("${weather?.temp.round()?? "null"}°C" , style:const TextStyle(
                  fontWeight: FontWeight.bold , fontSize: 39,color: white
                ),),
                // Text skystate
                Text(weather?.skyState ?? "" , style:const TextStyle(
                  fontWeight: FontWeight.w500 , fontSize: 25,color: white
                ),),
                  ],
                ),
                // Row for min and max temp
                const SizedBox(height: 50),
                // For temp max and min
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    containerIconText(text: "Temp Max", secoundtext: "${weather?.tempmax.round() ?? ""} °C", image: "assets/hot.png"),
                    containerIconText(text: "Temp Min", secoundtext: "${weather?.tempmin.round() ?? ""} °C", image: "assets/cold.png")  
                ],),
                const SizedBox(height: 35),
                // for speed wind and feels like 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    containerIconText(text: "Feels like", secoundtext: "${weather?.feelslike.round() ?? ""} °C", image: "assets/feels.png"),
                    containerIconText(text: "Wind Speed", secoundtext: "${weather?.wind.round() ?? ""} M/S", image: "assets/wind.png")  
                ],),
                const SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    containerIconText(text: "Humidity", secoundtext: "${weather?.humidity.round() ?? ""} %", image: "assets/humidity.png"),
                    containerIconText(text: "Pressure", secoundtext: "${weather?.pressure.round() ?? ""} Mbar", image: "assets/pressure.png")  
                ],),
            ],),
          ),
      ),
    ),
  );
  }
}