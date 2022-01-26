import 'package:flutter/material.dart';

import 'package:piproy/scr/providers/usuario_pref.dart';

import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

class OpcionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferencias>(context);
    List<Widget> opciones = [
      SizedBox(
        height: 5,
      ),
      Divider(
        height: 2,
        color: Colors.white,
      ),
      GestureDetector(
        onTap: () {
          pref.iTelefono = !pref.iTelefono;
        },
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: pref.iTelefono
                ?
                /** es un contacto o grupo de contacto */
                Theme.of(context).primaryColor
                : Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(80),
                    border: Border.all(color: Colors.white38, width: 2.0)),
                child: Icon(
                  Icons.call,
                  size: 40.0,
                ),
              ),
              Text(
                'teléfono',
                style: TextStyle(color: Colors.white60),
              )
            ],
          ),
        ),
      ),
      Divider(
        height: 2,
        color: Colors.white,
      ),
      GestureDetector(
        onTap: () {
          pref.iBateria = !pref.iBateria;
        },
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: pref.iBateria
                ?
                /** es un contacto o grupo de contacto */
                Theme.of(context).primaryColor
                : Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(80),
                    border: Border.all(color: Colors.white38, width: 2.0)),
                child: Icon(
                  Icons.battery_std,
                  size: 40.0,
                ),
              ),
              Text(
                'bateria',
                style: TextStyle(color: Colors.white60),
              )
            ],
          ),
        ),
      ),
      Divider(
        height: 2,
        color: Colors.white,
      ),
      GestureDetector(
        onTap: () {
          pref.iWifi = !pref.iWifi;
        },
        child: Container(
          decoration: BoxDecoration(
            color: pref.iWifi
                ?
                /** es un contacto o grupo de contacto */
                Theme.of(context).primaryColor
                : Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Container(
            height: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(80),
                      border: Border.all(color: Colors.white38, width: 2.0)),
                  child: Icon(
                    Icons.wifi,
                    size: 40.0,
                  ),
                ),
                Text(
                  'wifi',
                  style: TextStyle(color: Colors.white60),
                )
              ],
            ),
          ),
        ),
      ),
      Divider(
        height: 2,
        color: Colors.white,
      ),
      GestureDetector(
        onTap: () {
          pref.iLinea = !pref.iLinea;
        },
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: pref.iLinea
                ?
                /** es un contacto o grupo de contacto */
                Theme.of(context).primaryColor
                : Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(80),
                    border: Border.all(color: Colors.white38, width: 2.0)),
                child: Icon(
                  Icons.signal_cellular_alt_rounded,
                  size: 40.0,
                ),
              ),
              Text(
                'linea',
                style: TextStyle(color: Colors.white60),
              )
            ],
          ),
        ),
      ),
      Divider(
        height: 2,
        color: Colors.white,
      ),
      GestureDetector(
        onTap: () {
          pref.iGps = !pref.iGps;
        },
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: pref.iGps
                ?
                /** es un contacto o grupo de contacto */
                Theme.of(context).primaryColor
                : Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(80),
                    border: Border.all(color: Colors.white38, width: 2.0)),
                child: Icon(
                  Icons.gps_fixed_rounded,
                  size: 40.0,
                ),
              ),
              Text(
                'gps',
                style: TextStyle(color: Colors.white60),
              )
            ],
          ),
        ),
      ),
      Divider(
        height: 2,
        color: Colors.white,
      ),
      GestureDetector(
        onTap: () {
          pref.iLinterna = !pref.iLinterna;
        },
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: pref.iLinterna
                ?
                /** es un contacto o grupo de contacto */
                Theme.of(context).primaryColor
                : Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(80),
                    border: Border.all(color: Colors.white38, width: 2.0)),
                child: Icon(
                  Icons.filter_alt,
                  size: 40.0,
                ),
              ),
              Text(
                'linterna',
                style: TextStyle(color: Colors.white60),
              )
            ],
          ),
        ),
      ),
      Divider(
        height: 2,
        color: Colors.white,
      ),
      GestureDetector(
        onTap: () {
          pref.iMensaje = !pref.iMensaje;
        },
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: pref.iMensaje
                ?
                /** es un contacto o grupo de contacto */
                Theme.of(context).primaryColor
                : Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(80),
                    border: Border.all(color: Colors.white38, width: 2.0)),
                child: Icon(
                  Icons.chat,
                  size: 40.0,
                ),
              ),
              Text(
                'mensaje',
                style: TextStyle(color: Colors.white60),
              )
            ],
          ),
        ),
      ),
      Divider(
        height: 2,
        color: Colors.white,
      ),
      GestureDetector(
        onTap: () {
          pref.iReloj = !pref.iReloj;
        },
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: pref.iReloj
                ?
                /** es un contacto o grupo de contacto */
                Theme.of(context).primaryColor
                : Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(80),
                    border: Border.all(color: Colors.white38, width: 2.0)),
                child: Icon(
                  Icons.access_alarm,
                  size: 40.0,
                ),
              ),
              Text(
                'reloj',
                style: TextStyle(color: Colors.white60),
              )
            ],
          ),
        ),
      ),
      Divider(
        height: 2,
        color: Colors.white,
      ),
      GestureDetector(
        onTap: () {
          pref.iGoogle = !pref.iGoogle;
        },
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: pref.iGoogle
                ?
                /** es un contacto o grupo de contacto */
                Theme.of(context).primaryColor
                : Theme.of(context).scaffoldBackgroundColor,
            // borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            // alignment: Alignment.center,
            child: Container(
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                      color: Colors.white38, // Theme.of(context).primaryColor,
                      width: 0.5)),
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
                    height: 40,
                    width: 200,
                    //color: Colors.red),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.blue,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      Divider(
        height: 2,
        color: Colors.white,
      ),
      GestureDetector(
        onTap: () {
          pref.iContactos = !pref.iContactos;
        },
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: pref.iContactos
                ?
                /** es un contacto o grupo de contacto */
                Theme.of(context).primaryColor
                : Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(
                color:
                    /** es un contacto o grupo de contacto */
                    Colors.green,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.white38)),
            child: Center(
              child: Text(
                'Contactos',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
      ),
      Divider(
        height: 2,
        color: Colors.white,
      ),
      GestureDetector(
        onTap: () {
          pref.iAplicaciones = !pref.iAplicaciones;
        },
        child: Container(
            height: 90,
            decoration: BoxDecoration(
              color: pref.iAplicaciones
                  ?
                  /** es un contacto o grupo de contacto */
                  Theme.of(context).primaryColor
                  : Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                  color:
                      /** es un contacto o grupo de contacto */
                      Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.white38)),
              child: Center(
                child: Text(
                  'Aplicaciones',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            )),
      ),
      Divider(
        height: 2,
        color: Colors.white,
      ),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: headerApp(
            context, 'Opciones Menu Principal', Text(''), 0.0, true, 'paleta'),
        //    backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(bottom: 40),
          child: ListView.builder(
              padding: EdgeInsets.only(bottom: 100),
              itemCount: opciones.length,
              itemBuilder: (context, i) {
                return opciones[i];
              }),
        ),
      ),
    );
  }

  Widget opcionWidget(BuildContext context, Widget widget) {
    // final celProvider = Provider.of<EstadoProvider>(context);
    return GestureDetector(
      onTap: () {
        //guardarPreferenciaOpciones();
        //    celProvider.paleta = paleta.toString();
      },
      child: Container(
        height: 60,
        child: widget,
      ),
    );
  }
}
