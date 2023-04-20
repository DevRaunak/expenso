import 'dart:async';

import 'package:expenso_31/custom_widgets/custom_logo_widget.dart';
import 'package:expenso_31/screens/user_onboarding/login/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {

    Timer(Duration(seconds: 2), (){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: CustomLogoWidget(mSize: width>500 ? 50.0 : 40.0, bgColor: Theme.of(context).canvasColor, iconColor: Theme.of(context).backgroundColor,),
      ),
    );
  }
}
