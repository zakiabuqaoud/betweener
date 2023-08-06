
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';

import '../models/user.dart';

Future<List<dynamic>?> searchController(body)async{



  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.post(
    Uri.parse(searchUrl),
    headers: {'Authorization': 'Bearer ${user.token}'},
    body: body,
  );



  if(response.statusCode == 200){
    Map<String,dynamic> resultOfSearch = jsonDecode(response.body);
    print("zaki final");

    if(resultOfSearch != null){
      List<dynamic> listOfUsers = resultOfSearch["user"];
      return listOfUsers;
    }

  }


}