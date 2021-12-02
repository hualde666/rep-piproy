import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:provider/provider.dart';

Widget googleBusqueda(BuildContext context) {
  return GestureDetector(
    child: Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 1.5, horizontal: 5.0),
      alignment: Alignment.center,
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Container(
            child: Center(
                child: Image(
                    image: AssetImage('assets/google.png'), fit: BoxFit.fill)),
            height: 50,
            width: 250,
            //color: Colors.red),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.search,
            color: Colors.blue,
            size: 50,
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.white)),
    ),
    onTap: () {
      final apiProvider =
          Provider.of<AplicacionesProvider>(context, listen: false);
      final listaApi = apiProvider.categoryApi['Todas'];
      final Application api = listaApi.firstWhere(
          (element) =>
              element.packageName == 'com.google.android.googlequicksearchbox',
          orElse: null);
      if (api != null) {
        api.openApp();
      }
      //***abrirGoogle();
    },
  );
}
