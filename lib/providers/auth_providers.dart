import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants/url.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/database/db_provider.dart';
import 'package:shop_app/screens/home_screen.dart';
import 'package:shop_app/utils/routes.dart';
import '../models/user_model.dart';

class AuthenticationProvider extends ChangeNotifier {
 //base Url
 final requestBaseUrl = AppUrl.baserUrl;


 //Setter
 bool _isLoadiing = false ;
 String _resMessage = '' ;

 //Getter
 bool get isLoading => _isLoadiing;
 String get resMessage => _resMessage;

 void registerUser({
   required String name,
   required String email,
   required String password,
   required String id,
   required bool rememberMe,
   BuildContext? context,
}) async {
   _isLoadiing = true;
   notifyListeners();

   String url = '$requestBaseUrl/api/v1/user/register';

   final body = {
     "name" : name,
     "email": email,
     "password": password,
   };
   print(body);


   try {
     http.Response req = await http.post(
         Uri.parse(url),
         body: {
           "name" : name,
           "email": email,
           "password": password,
             });

     if (req.statusCode == 200) {
       final body = jsonDecode(req.body);
       print("Login Token : " + body["token"]);
       final token = body["token"];
       User user = User(name: name, password: password, email: email, id: id, token: token);
       DatabaseProvider().saveUser(user);
       DatabaseProvider().remember(rememberMe) ;
       DatabaseProvider().saveToken(token);
        PageNavigator(ctx: context).nextPageOnly(page: const HomeScreen());           
       _isLoadiing = false;
       _resMessage = "Acoount Created";
       notifyListeners();
     } else {
       final res = json.decode(req.body);
       _resMessage = res ["message"];
       print(res);
     }
   } on SocketException catch (_) {
     _isLoadiing = false;
     _resMessage = "Internet connection is not available";
     notifyListeners();
   } catch (e) {
     _isLoadiing = false;
     _resMessage = "Please try again";
     notifyListeners();
     print("!!!!  ${e} !!!!!!");
   }
   }

 void loginUser({
   required String email,
   required String password,
   required bool rememberMe,
   BuildContext? context,
 }) async {
   _isLoadiing = true;
   notifyListeners();

   String url = '$requestBaseUrl/api/v1/user/login';

   final body = {
     "email": email,
     "password": password,
   };
   print(body);

   try {
     http.Response req = await http.post(
         Uri.parse(url), body: ( {
       "email": email,
       "password": password,
     }));

     if (req.statusCode == 200) {
       final body = json.decode(req.body);
       print(body);
       print("Login Token : " + body["token"]);
       final token = body["token"];
       User user = User(password: password, email: email, token: token);
       DatabaseProvider().saveUser(user);
       DatabaseProvider().remember(rememberMe);
       print("Auth remember ${rememberMe}");
       DatabaseProvider().saveToken(token);
       PageNavigator(ctx: context).nextPageOnly(page: const HomeScreen());
       _isLoadiing = false;
       _resMessage = "Login successfull";
       notifyListeners();
     } else {
       final res = json.decode(req.body);
       _resMessage = res ["message"];

       print(res);
     }
   } on SocketException catch (_) {
     _isLoadiing = false;
     _resMessage = "Internet connection is not available";
     notifyListeners();
   } catch (e) {
     _isLoadiing = false;
     _resMessage = "Please try again";
     notifyListeners();
     print("!!!!  ${e} !!!!!!");
   }
 }

 void clear(){
   _resMessage = "";
   notifyListeners();
  }

 }




