import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/userPro.dart';
import 'package:provider/provider.dart';

import '../navigations/navigationAnimation.dart';
import 'articleScreen.dart';
import 'registrationScreen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    final userPro = Provider.of<UserPro>(context, listen: false);
    if (!await userPro.isLoginUser()) {
      Navigator.pushReplacement(
          context, FadeNavigation(widget: RegistrationScreen()));
    } else {
      Navigator.pushReplacement(
          context, FadeNavigation(widget: ArticleScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
