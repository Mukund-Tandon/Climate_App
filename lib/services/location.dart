import 'package:geolocator/geolocator.dart';
class Location{
  double Latitude;
  double Longitude;
  Future<void> givelocation() async{
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      Latitude = position.latitude;
      Longitude = position.longitude;
      print('done');
    }
    catch(e)
    {
      print(e);
    }
  }
}