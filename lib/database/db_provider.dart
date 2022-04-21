import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/utils/routes.dart';

class DatabaseProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  String _token = "";

  String get token => _token;

  void saveToken(String token) async {
    SharedPreferences value = await _pref;
    value.setString("token", token);
  }


  Future<String> getToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey("token")) {
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;
    }  else {
      _token = "" ;
      notifyListeners();
      return "" ;
    }
  }

  void logOut(BuildContext context) async {
    final value = await _pref;
    value.clear();
    PageNavigator(ctx: context).nextPageOnly(page: const LoginScreen());

  }


}