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
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
