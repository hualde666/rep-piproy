import 'package:device_apps/device_apps.dart';

import 'package:flutter/material.dart';
import 'package:piproy/channel/channel_android.dart';

import 'package:piproy/scr/funciones/url_funciones.dart';
import 'package:piproy/scr/models/contactos_modelo.dart';

import 'package:piproy/scr/pages/mostrar_contacto.dart';

import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';

import 'package:piproy/scr/providers/estado_celular.dart';
import 'package:provider/provider.dart';

Widget conteinerIcon(
    BuildContext context, Icon icon, String tarea, ContactoDatos contacto) {
  final celProvider = Provider.of<EstadoProvider>(context);
  bool activoGps = celProvider.conexionGps;
  bool activoDatos = celProvider.conexionDatos;
  bool activoWifi = celProvider.conexionWifi;

  bool prendida;
  IconData nuevoIcon;
  Widget widget;

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
          : Icons.signal_cellular_off_outlined;

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
              border: Border.all(color: Colors.white, width: 0.5)),
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

funcionIcon(BuildContext context, String tarea, ContactoDatos contacto,
    bool prendida) async {
  final celProvider = Provider.of<EstadoProvider>(context, listen: false);

  bool activoDatos = celProvider.conexionDatos;

  switch (tarea) {
    case 'discado':
      if (activoDatos) {
        ///  *** llamada desde menu horizontal
        llamar("");
      }

      break;
    case 'llamada':
      if (activoDatos) {
        /// *** llamada desde el contacto
        llamar(contacto.telefono);
      }
      break;
    case 'mensaje':
      if (activoDatos) {
        mensaje("");
      }
      break;
    case 'mensajeC':
      if (activoDatos) {
        mensaje(contacto.telefono);
      }
      break;
    case 'bateria':
      break;
    case 'wifi':
      // prender y apagar)
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => WifiPage()));
      break;
    case 'gps':
      // prender y apagar
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => GpsPage()));
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
      if (contacto.whatsapptel != "") {
        abrirWhatsapp(contacto.whatsapptel, '');
      }

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
      //  final listaApi = apiProvider.categoryApi['Todas'];
      final Application api =
          await apiProvider.obtenerApi('com.android.deskclock');

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
        border: Border.all(color: Colors.white, width: 0.5)),
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
        border: Border.all(color: Colors.white, width: 0.5)),
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
            // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
                color: cargando ? Colors.blue[900] : color,
                borderRadius: BorderRadius.circular(80),
                border: Border.all(color: Colors.white, width: 0.5)),
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
