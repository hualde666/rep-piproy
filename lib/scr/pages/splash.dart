import 'package:flutter/material.dart';
import 'package:piproy/scr/pages/home2_page.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navegarHome();
  }

  _navegarHome() async {
    await Future.delayed(Duration(milliseconds: 1000));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home2Page()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
      body: Center(
          child: Container(
        height: 200,
        width: 500,
        child:
            Image(image: AssetImage('assets/vitalfon.png'), fit: BoxFit.cover),
      )),
    );
  }
}
