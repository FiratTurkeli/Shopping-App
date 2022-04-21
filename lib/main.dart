import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants/color.dart';
import 'package:shop_app/database/db_provider.dart';

import 'package:shop_app/providers/auth_providers.dart';
import 'package:shop_app/splash.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   return MultiProvider(
     providers: [
     ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
       ChangeNotifierProvider(create: (_) => DatabaseProvider() ),

   ] ,
   child: MaterialApp(
     debugShowCheckedModeBanner: false,
     theme: ThemeData(
       backgroundColor: primary,
       appBarTheme: AppBarTheme(
         color: primary,
       ),
       primaryColor: primary),
     home: const SplashScreen(),
     ),
   );
  }
}




