import 'package:flutter/material.dart';
import 'package:climate_app/utilities/constants.dart';
import 'package:climate_app/services/weather.dart';
import 'package:climate_app/screens/city_screen.dart';
import 'package:flutter/services.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather});
  final locationweather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  String weathericon;
  String Cityname;
  int tempature;
  int condition;
  String weathermessage;

  @override
  void initState() {
    super.initState();
    uiUpdate(widget.locationweather);
  }
  void uiUpdate(dynamic weatherdata){
    setState(() {
      if(weatherdata == Null)
      {
        Cityname=' ';
        tempature = 0;
        weathericon = 'ERROR';
        weathermessage = 'Location Not Found';
        return;
      }
      Cityname = weatherdata['name'];
      double temp = weatherdata['main']['temp'];
      tempature= temp.toInt();
      print(tempature);
      condition = weatherdata['weather'][0]['id'];
      weathericon = weatherModel.getWeatherIcon(condition);
      weathermessage = weatherModel.getMessage(tempature);
      print(Cityname);
    });

  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/location_background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async{

                          var weather_data = await weatherModel.getweatherdata();
                          uiUpdate(weather_data);

                      },
                      child: Icon(
                        Icons.my_location,
                        size: 50.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () async{
                        var city = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }));
                        if(city != Null)
                          {
                            var data = await weatherModel.getcityweather(city);
                            uiUpdate(data);

                          }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '$tempature°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        '$weathericon️',
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "$weathermessage in $Cityname!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
