import 'package:climate_app/services/location.dart';
import 'package:climate_app/services/weather.dart';
import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:climate_app/services/networking.dart';
import 'package:climate_app/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  
  @override
  void initState() {
    super.initState();
    getloactiondata();
  }
  void getloactiondata() async{
    WeatherModel weatherModel = WeatherModel();
    var weather_Data = await weatherModel.getweatherdata();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationweather: weather_Data);
    }));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
