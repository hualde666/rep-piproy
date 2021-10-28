import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/header_app.dart';

class PilaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: headerApp(context, 'Bateria', Text(''), 0.0),
        //backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
        body: _mostrarPila(),
      ),
    );
  }

  Widget _mostrarPila() {
    return Center(
      child: Container(
        child: Text(
          'Estado Batería',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
