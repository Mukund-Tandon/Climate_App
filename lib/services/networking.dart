import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking{
  Networking(this.url);
  final String url;

  Future getdata() async{
    http.Response response=await http.get(url);
    if(response.statusCode==200)
    {
      String data = response.body;
      return jsonDecode(data);
    }
    else{
      print("no");
      print(response.statusCode);
    }

  }

}