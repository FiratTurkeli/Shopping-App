import 'package:shared_preferences/shared_preferences.dart';


class PrefService{
  Future pageRoute(String token) async {
    // STORE VALUE OR TOKEN INSIDE SHARED PREF
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("login", token);
  }
}

