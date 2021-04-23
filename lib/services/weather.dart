import 'package:climate_app/services/networking.dart';
import 'package:climate_app/screens/location_screen.dart';
import 'package:climate_app/services/location.dart';

class WeatherModel {
  String apikey ='Your_api';
  Future getcityweather(String city) async{
    Networking networking = Networking('http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apikey&units=metric');
    var weatherdata = await networking.getdata();
    return weatherdata;
  }
  double latitude;
  double longitude;

  Future getweatherdata()async{
    Location location = new Location();
    await location.givelocation();
    latitude = location.Latitude;
    longitude = location.Longitude;
    print(latitude);
    Networking networking = Networking('http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey&units=metric');
    var weatherdata = await networking.getdata();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {

    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
