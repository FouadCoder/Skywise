
import 'package:flutter/material.dart';
import 'package:weather_app/colors.dart';

// ignore: camel_case_types
class containerIconText extends StatelessWidget{
  const containerIconText({super.key , required this.text, required this.secoundtext, required this.image});
    final String text;
    final String secoundtext;
    final String image;

  @override
  Widget build(BuildContext context) {

  // ignore: avoid_unnecessary_containers
  return Container( 
    margin:const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                          // height: MediaQuery.of(context).size.height * 0.05,
                          // width: MediaQuery.of(context).size.width * 0.10,
                          child: Image.asset(image)),
                          const SizedBox(width: 10),
                      Column(
                        children: [
                          Text(text , style:const TextStyle(color: white , fontSize: 20 , fontWeight: FontWeight.bold),),
                          Text(secoundtext ,style:const TextStyle(color: white , fontSize: 20 , fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                );
  }
  
}