import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;

Future<bool> followController(body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.post(
    Uri.parse(followUrl),
    headers: {'Authorization': 'Bearer ${user.token}'},
    body: body,
  );

  if (response.statusCode == 200) {
    return true;
  }
  return false;
}
