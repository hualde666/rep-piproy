import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  //late  Animation<double> movingTop;
  // AnimationController _controller;
  @override
  void initState() {
    super.initState();

    // _controller = AnimationController(
    //     duration: const Duration(milliseconds: 2000), vsync: this);
    // _navegarHome();
  }

  @override
  Widget build(BuildContext context) {
    // final timeDilation = 10.0;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Staggered Animation'),
        ),
        body: Vitalfon());
  }
}

class Vitalfon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(microseconds: 1200),
        curve: Curves.elasticOut,
        color: Color.fromRGBO(55, 57, 84, 1.0),
        height: 50,
        width: 50,
        // child:            Image(image: AssetImage('assets/vitalfon.png'), fit: BoxFit.cover),
      ),
    );
  }
}
