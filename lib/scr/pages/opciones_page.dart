import 'package:flutter/material.dart';

import 'package:piproy/scr/providers/usuario_pref.dart';

import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

class OpcionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pref = Provider.of<Preferencias>(context);

    double ancho = (MediaQuery.of(context).size.width);

    List<Widget> opciones = [
      Divider(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      SizedBox(
        height: 5,
      ),
      Container(
        height: ancho,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: GridView.count(
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          crossAxisCount: 3,
          physics: NeverScrollableScrollPhysics(),
          children: [
            GestureDetector(
              onTap: () {
                pref.iTelefono = !pref.iTelefono;
              },
              child: IconOpcion(
                  iconop: Icons.call,
                  icontext: 'telefono',
                  activo: pref.iTelefono),
            ),
            GestureDetector(
                onTap: () {
                  pref.iBateria = !pref.iBateria;
                },
                child: IconOpcion(
                    iconop: Icons.battery_std,
                    icontext: 'bateria',
                    activo: pref.iBateria)),
            GestureDetector(
                onTap: () {
                  pref.iWifi = !pref.iWifi;
                },
                child: IconOpcion(
                    iconop: Icons.wifi, icontext: 'wifi', activo: pref.iWifi)),
            GestureDetector(
                onTap: () {
                  pref.iLinea = !pref.iLinea;
                },
                child: IconOpcion(
                    iconop: Icons.signal_cellular_alt_rounded,
                    icontext: 'linea',
                    activo: pref.iLinea)),
            GestureDetector(
                onTap: () {
                  pref.iGps = !pref.iGps;
                },
                child: IconOpcion(
                    iconop: Icons.gps_fixed_rounded,
                    icontext: 'gps',
                    activo: pref.iGps)),
            GestureDetector(
                onTap: () {
                  pref.iLinterna = !pref.iLinterna;
                },
                child: IconOpcion(
                    iconop: Icons.filter_alt,
                    icontext: 'linterna',
                    activo: pref.iLinterna)),
            GestureDetector(
                onTap: () {
                  pref.iMensaje = !pref.iMensaje;
                },
                child: IconOpcion(
                    iconop: Icons.chat,
                    icontext: 'mensaje',
                    activo: pref.iMensaje)),
            GestureDetector(
                onTap: () {
                  pref.iReloj = !pref.iReloj;
                },
                child: IconOpcion(
                    iconop: Icons.access_alarm,
                    icontext: 'reloj',
                    activo: pref.iReloj)),
          ],
        ),
      ),
      Divider(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      GestureDetector(
        onTap: () {
          pref.iGoogle = !pref.iGoogle;
        },
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: pref.iGoogle
                ? Theme.of(context).scaffoldBackgroundColor
                /** es un contacto o grupo de contacto */

                : Colors.grey,
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
                    width: 195,
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
        color: Theme.of(context).primaryColor,
      ),
      GestureDetector(
        onTap: () {
          pref.iContactos = !pref.iContactos;
        },
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: pref.iContactos
                ? Theme.of(context).scaffoldBackgroundColor
                /** es un contacto o grupo de contacto */

                : Colors.grey,
          ),
          child: Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(
                color:
                    /** es un contacto o grupo de contacto */
                    Colors.green,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                )),
            child: Center(
              child: Text(
                'Contactos',
                style: TextStyle(
                  color: Theme.of(context).backgroundColor,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
      ),
      Divider(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      GestureDetector(
        onTap: () {
          pref.iAplicaciones = !pref.iAplicaciones;
        },
        child: Container(
            height: 90,
            decoration: BoxDecoration(
              color: pref.iAplicaciones
                  ? Theme.of(context).scaffoldBackgroundColor
                  /** es un contacto o grupo de contacto */

                  : Colors.grey,
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                  color:
                      /** es un contacto o grupo de contacto */
                      Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  )),
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
        color: Theme.of(context).primaryColor,
      ),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: headerApp(context, 'Opciones Menu Principal', Text(''), 0.0,
            true, 'Opciones'),
        //    backgroundColor: Colors.white,
        body: Container(
          // padding: EdgeInsets.only(bottom: 40),
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
}

class IconOpcion extends StatelessWidget {
  const IconOpcion({@required this.iconop, this.icontext, this.activo});

  final bool activo;
  final IconData iconop;
  final String icontext;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).primaryColor, width: 2.0),
        color: activo
            ? Theme.of(context).scaffoldBackgroundColor
            // Theme.of(context).primaryColor
            : Colors.grey,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(80),
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 2.0)),
            child: Icon(
              iconop,
              size: 40.0,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Text(icontext,
                style: TextStyle(
                    color: Theme.of(context).primaryColor) //,Colors.white60),
                ),
          )
        ],
      ),
    );
  }
}
