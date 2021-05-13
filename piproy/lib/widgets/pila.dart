import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:battery/battery.dart';

class NivelPila extends StatelessWidget {
  final Battery battery = Battery();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getNivelBateria(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print('****');
          return Container(
            width: double.infinity,
            height: 50.0,
            child: Card(
                child: Center(
                  child: Text('${snapshot.data} %',
                      style: TextStyle(color: Colors.white, fontSize: 25.0)),
                ),
                elevation: 10.0,
                color: Colors.teal[600],
                shadowColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(20.0),
                )

                //width: double.infinity,
                //height: 100.0,
                ),
          );
        });
  }

  Future _getNivelBateria() async {
    final int batteryLevel = await battery.batteryLevel;
    final int batteryLevel2 = 60;
    return batteryLevel2;
  }
}
