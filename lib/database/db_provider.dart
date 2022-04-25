import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/utils/routes.dart';

import '../models/user_model.dart';

class DatabaseProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  String _token = "";

  String get token => _token;

   bool _rememberMe = false;

   bool get rememberMe => rememberMe;

   User? model;
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

  Future remember (bool value) async {
    SharedPreferences remember = await _pref;
    remember.setBool("rememberMe", value);
    print("Pref remember ${value.toString()}");
  }

  Future<bool?> getRemember() async {
    SharedPreferences value = await _pref;
      bool? data = value.getBool("rememberMe");
      _rememberMe =data!;
      notifyListeners();
      return data;

  }


  void logOut(BuildContext context) async {
    final value = await _pref;
    value.clear();
    PageNavigator(ctx: context).nextPageOnly(page: const LoginScreen());

  }

  // gerekli olması durumunda
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("name", user.name.toString());
    print("NAMEEE ${user.name}"); //for control
    prefs.setString("email", user.email.toString());
    prefs.setString("password", user.password.toString());

    return prefs.commit();
  }
  //gerekli olması durumunda
  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? name = prefs.getString("name");
    String? email = prefs.getString("email");
    String? password = prefs.getString("password");

    return User(
        name: name,
        email: email,
        password: password
    );
  }





}