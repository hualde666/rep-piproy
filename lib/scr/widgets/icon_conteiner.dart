import 'package:contacts_service/contacts_service.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piproy/channel/channel_android.dart';

import 'package:piproy/scr/funciones/url_funciones.dart';
import 'package:piproy/scr/pages/gps_page.dart';
import 'package:piproy/scr/pages/mostrar_contacto.dart';
import 'package:piproy/scr/pages/wifi_page.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';

import 'package:piproy/scr/providers/estado_celular.dart';
import 'package:provider/provider.dart';

Widget conteinerIcon(
    BuildContext context, Icon icon, String tarea, Contact contacto) {
  final celProvider = Provider.of<EstadoProvider>(context);
  bool activoGps = celProvider.conexionGps;
  bool activoDatos = celProvider.conexionDatos;
  bool activoWifi = celProvider.conexionWifi;

  String phone;
  bool prendida;
  IconData nuevoIcon;
  Widget widget;

  if (phone != null) {
    phone = contacto.phones.elementAt(0).value;
  }
  switch (tarea) {
    case 'bateria':
      widget = Pila();
      break;
    case 'wifi':
      nuevoIcon = activoWifi ? Icons.wifi_rounded : Icons.wifi_off_rounded;

      widget = dispositivo(activoWifi, nuevoIcon);
      break;

    case 'gps':
      nuevoIcon = activoGps ? Icons.gps_fixed : Icons.gps_off_rounded;

      widget = dispositivo(activoGps, nuevoIcon);
      break;
    case 'señal':
      nuevoIcon = activoDatos
          ? Icons.signal_cellular_alt_rounded
          : Icons.signal_cellular_off_rounded;

      widget = dispositivo(activoDatos, nuevoIcon);
      break;
    case 'linterna':
      prendida = celProvider.linterna;
      nuevoIcon =
          prendida ? Icons.filter_alt_rounded : Icons.filter_alt_outlined;

      widget = dispLinterna(context, prendida, nuevoIcon);
      break;
    default:
      {
        widget = Center(
            child: Container(
          width: 70.0,
          height: 70.0,
          decoration: BoxDecoration(
              color: (tarea == 'whatsapp')
                  ? Colors.green
                  : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(80),
              border: Border.all(color: Colors.white, width: 2.0)),
          child:
              //  (tarea == 'whatsapp')
              //     ? Image(
              //         image: AssetImage('assets/whatsapp.png'),
              //       ) // fit: BoxFit.cover))
              //     :
              icon,
        ));
        break;
      }
  }

  return GestureDetector(
      child: widget,
      onTap: () => funcionIcon(context, tarea, contacto, prendida));
}

funcionIcon(
    BuildContext context, String tarea, Contact contacto, bool prendida) {
  String phone;
  if (contacto != null) {
    phone = contacto.phones.elementAt(0).value;
  }

  switch (tarea) {
    case 'discado':

      ///  *** llamada desde menu horizontal
      llamar("");
      break;
    case 'llamada':

      /// *** llamada desde el contacto
      llamar(phone);
      break;
    case 'mensaje':
      mensaje("");
      break;
    case 'mensajeC':
      mensaje(phone);
      break;
    case 'bateria':
      break;
    case 'wifi':
      // prender y apagar)
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WifiPage()));
      break;
    case 'gps':
      // prender y apagar
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => GpsPage()));
      break;
    case 'linterna':
      AndroidChannel _androidChannel = AndroidChannel();

      if (prendida) {
        Provider.of<EstadoProvider>(context, listen: false).swichLinterna =
            false;
        _androidChannel.onoffLinterna(false);
      } else {
        Provider.of<EstadoProvider>(context, listen: false).swichLinterna =
            true;
        _androidChannel.onoffLinterna(true);
      }

      break;
    case 'whatsapp':
      abrirWhatsapp(phone, '');
      break;
    case 'configurar':
      Navigator.pushNamed(context, 'configurar');
      break;
    case 'editar':
      Provider.of<ContactosProvider>(context, listen: false).contacto =
          contacto;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MostrarContacto()));

      break;
    case 'alarma':
      final apiProvider =
          Provider.of<AplicacionesProvider>(context, listen: false);
      final listaApi = apiProvider.categoryApi['Todas'];
      final Application api = listaApi.firstWhere(
          (element) => element.packageName == 'com.android.deskclock',
          orElse: null);
      if (api != null) {
        api.openApp();
      }
      break;
  }
}

Widget dispositivo(bool activo, IconData icon) {
  final Color color = activo ? Colors.green[900] : Colors.red[900];

  return Center(
      child: Container(
    width: 70.0,
    height: 70.0,
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(80),
        border: Border.all(color: Colors.white, width: 2.0)),
    child: Center(child: Icon(icon, size: 40.0, color: Colors.white)),
  ));
}

Widget dispLinterna(BuildContext context, bool activo, IconData icon) {
  final Color color = activo ? Colors.yellow : Theme.of(context).primaryColor;

  return Center(
      child: Container(
    width: 70.0,
    height: 70.0,
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(80),
        border: Border.all(color: Colors.white, width: 2.0)),
    child: Center(child: Icon(icon, size: 40.0, color: Colors.white)),
  ));
}

class Pila extends StatefulWidget {
  Pila();
  @override
  _PilaState createState() => _PilaState();
}

class _PilaState extends State<Pila> {
  Color color;
  int nivelBateria;
  bool cargando;
  Icon icon;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final celProvider = Provider.of<EstadoProvider>(context);
    nivelBateria = celProvider.nivelBateria;
    color = celProvider.bateriaColor;
    cargando = celProvider.cargandoBateria;

    return Center(
        child: Container(
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
                color: cargando ? Colors.blue[900] : color,
                borderRadius: BorderRadius.circular(80),
                border: Border.all(color: Colors.white, width: 2.0)),
            child: Center(
              child: Text(
                '$nivelBateria%',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ) // Icon(Icons.battery_std, size: 40.0, color: Colors.white),
            ));
  }
}
