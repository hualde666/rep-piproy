import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

Widget googleBusqueda(BuildContext context, Application api) {
  return GestureDetector(
    child: Container(
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                  color: Colors.white, // Theme.of(context).primaryColor,
                  width: 1.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
              ),
              Container(
                child: Center(
                    child: Image(
                        image: AssetImage('assets/google.png'),
                        fit: BoxFit.fill)),
                height: 50,
                width: 250,
                //color: Colors.red),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.search,
                color: Colors.blue,
                size: 50,
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
                color: Colors.white, // Theme.of(context).primaryColor,
                width: 1.0))),
    onTap: () {
      // await DeviceApps.getApp(listaMenu[i].substring(3), true);
      if (api != null) {
        api.openApp();
      }
      //***abrirGoogle();
    },
  );
}
