import 'package:flutter/material.dart';

import 'package:piproy/channel/channel_android.dart';
import 'package:piproy/scr/pages/home2_page.dart';

//import 'package:piproy/channel/channel_android.dart';

class LLamadasPermisos extends StatelessWidget {
  // GpsPage({@required context});
  //BuildContext context;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: 50,
                  // ),
                  Column(
                    children: [
                      Text(
                        'vitalfon',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 60,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        ' Para facilitar tus llamadas, vamos a requerir que nos autorices a realizar llamadas.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 35,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton.extended(
                heroTag: "siguiente",
                // icon: Icon(
                //   Icons.save,
                // ),
                label: Text(
                  'siguiente',
                ),
                onPressed: () async {
                  AndroidChannel _androidChannel = AndroidChannel();
                  // await FlutterPhoneDirectCaller.callNumber('');
                  await _androidChannel.permisoCall();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Home2Page()));
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => GeoPermisos()));
                })));
  }
}
