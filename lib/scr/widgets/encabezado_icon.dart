import 'package:flutter/material.dart';
import 'package:piproy/scr/providers/usuario_pref.dart';

import 'package:piproy/scr/widgets/icon_conteiner.dart';
import 'package:provider/provider.dart';

Widget encabezadoIcon(BuildContext context) {
  //final bool isOn = false;
  final pref = Provider.of<Preferencias>(context);
  final List<Widget> _listaWidget = [
    // Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Container(
    //       height: 75,
    //       child: conteinerIcon(
    //           context,
    //           Icon(
    //             Icons.engineering,
    //             size: 40.0,
    //           ),
    //           'configurar',
    //           null),
    //     ),
    //     Text(
    //       'configurar',
    //       style: TextStyle(color: Colors.white60),
    //     )
    //   ],
    // ),
// lintern
    // SizedBox(
    //   width: 10,
    // ),
    pref.iTelefono
        ? Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 75,
                    child: conteinerIcon(
                        context,
                        Icon(
                          Icons.call,
                          size: 40.0,
                        ),
                        'discado',
                        null),
                  ),
                  Text(
                    'telefono',
                    style: TextStyle(color: Colors.white60),
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
        : Container(),

    pref.iBateria
        ? Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 75,
                    child: conteinerIcon(
                        context,
                        Icon(
                          Icons.battery_std,
                          size: 40.0,
                        ),
                        'bateria',
                        null),
                  ),
                  Center(
                    child: Text(
                      'batería',
                      style: TextStyle(color: Colors.white60),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
        : Container(),

    pref.iWifi
        ? Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 75,
                    child: conteinerIcon(
                        context,
                        Icon(
                          Icons.wifi,
                          size: 40.0,
                        ),
                        'wifi',
                        null),
                  ),
                  Text(
                    'wifi',
                    style: TextStyle(color: Colors.white60),
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
        : Container(),

    pref.iLinea
        ? Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 75,
                    child: conteinerIcon(
                        context,
                        Icon(
                          Icons.signal_cellular_alt_rounded,
                          size: 40.0,
                        ),
                        'señal',
                        null),
                  ),
                  Text(
                    'linea',
                    style: TextStyle(color: Colors.white60),
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
        : Container(),

    pref.iGps
        ? Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 75,
                    child: conteinerIcon(
                        context,
                        Icon(
                          Icons.gps_fixed_rounded,
                          size: 40.0,
                        ),
                        'gps',
                        null),
                  ),
                  Text(
                    'gps',
                    style: TextStyle(color: Colors.white60),
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
        : Container(),

    pref.iLinterna
        ? Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 75,
                    child: conteinerIcon(
                        context,
                        Icon(
                          Icons.filter_alt,
                          size: 40.0,
                        ),
                        'linterna',
                        null),
                  ),
                  Text(
                    'linterna',
                    style: TextStyle(color: Colors.white60),
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
        : Container(),

    pref.iMensaje
        ? Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 75,
                    child: conteinerIcon(
                        context,
                        Icon(
                          Icons.chat,
                          size: 40.0,
                        ),
                        'mensaje',
                        null),
                  ),
                  Text(
                    'mensaje',
                    style: TextStyle(color: Colors.white60),
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
        : Container(),

    pref.iReloj
        ? Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 75,
                    child: conteinerIcon(
                        context,
                        Icon(
                          Icons.access_alarms,
                          size: 40.0,
                        ),
                        'alarma',
                        null),
                  ),
                  Text(
                    'alarma',
                    style: TextStyle(color: Colors.white60),
                  )
                ],
              ),
            ],
          )
        : Container(),
  ];
  final margen = 140 / _listaWidget.length;
  return Container(
    height: 91,
    // color: Colors.blue,
    margin: EdgeInsets.only(
      left: margen,
      top: 2,
      right: margen,
    ),

    //width: MediaQuery.of(context).w,
    //margin: //EdgeInsets.only(top: 55.0),
    child: ListView.builder(
      //  padding: EdgeInsets.only(left: 5),
      // controller: PageController(initialPage: 1, viewportFraction: 0.5),
      scrollDirection: Axis.horizontal,
      itemCount: _listaWidget.length,
      itemBuilder: (context, i) => _listaWidget[i],
    ),
  );
}
