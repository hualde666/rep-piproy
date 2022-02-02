import 'package:flutter/material.dart';
import 'package:piproy/scr/providers/usuario_pref.dart';

import 'package:piproy/scr/widgets/icon_conteiner.dart';
import 'package:provider/provider.dart';

Widget encabezadoIcon(BuildContext context) {
  //final bool isOn = false;
  final pref = Provider.of<Preferencias>(context);
  final List<Widget> _listaWidget = [
    pref.iTelefono
        ? widgetHorizontal(context, Icons.call, 'telefono')
        : Container(),
    pref.iBateria
        ? widgetHorizontal(context, Icons.battery_std, 'bateria')
        : Container(),
    pref.iWifi
        ? widgetHorizontal(
            context,
            Icons.wifi,
            'wifi',
          )
        : Container(),
    pref.iLinea
        ? widgetHorizontal(
            context,
            Icons.signal_cellular_alt_rounded,
            'linea',
          )
        : Container(),
    pref.iGps
        ? widgetHorizontal(
            context,
            Icons.gps_fixed_rounded,
            'gps',
          )
        : Container(),
    pref.iLinterna
        ? widgetHorizontal(
            context,
            Icons.filter_alt,
            'linterna',
          )
        : Container(),
    pref.iMensaje
        ? widgetHorizontal(
            context,
            Icons.chat,
            'mensaje',
          )
        : Container(),
    pref.iReloj
        ? widgetHorizontal(
            context,
            Icons.access_alarm,
            'alarma',
          )
        : Container(),
  ];
  final margen = 140 / _listaWidget.length;
  return Container(
    height: 91,
    margin: EdgeInsets.only(
      left: margen,
      top: 2,
      right: margen,
    ),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _listaWidget.length,
      itemBuilder: (context, i) => _listaWidget[i],
    ),
  );
}

Widget widgetHorizontal(BuildContext context, IconData icon, String titulo) {
  return Row(
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 75,
            child: conteinerIcon(
                context,
                Icon(
                  icon,
                  size: 40.0,
                ),
                titulo,
                null),
          ),
          Text(
            titulo,
            style: TextStyle(color: Colors.white60),
          )
        ],
      ),
      SizedBox(
        width: 10,
      ),
    ],
  );
}
