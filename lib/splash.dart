import 'package:flutter/material.dart';
import 'package:shop_app/constants/color.dart';
import 'package:shop_app/database/db_provider.dart';
import 'package:shop_app/screens/home_screen.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Center(child: FlutterLogo(),),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 1), () {
      DatabaseProvider().getToken().then((value) {
        if (value == '') {
          PageNavigator(ctx: context).nextPageOnly(page: const LoginScreen());
        } else {
          PageNavigator(ctx: context).nextPageOnly(page: const HomeScreen());
        }
      });
    });
  }
}
