import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/header_app.dart';

class LinternaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: headerApp(context, 'Linterna', Text(''), 0.0),
        //backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
        body: _mostrar(),
      ),
    );
  }

  Widget _mostrar() {
    return Center(
      child: Container(
        child: Text(
          'Linterna',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
