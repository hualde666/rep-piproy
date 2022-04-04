import 'package:flutter/material.dart';
import 'package:piproy/scr/models/contactos_modelo.dart';

import 'package:piproy/scr/pages/envio_emergencia.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';
import 'package:piproy/scr/providers/usuario_pref.dart';

import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:audioplayers/audioplayers.dart';

class BotonRojoPage extends StatefulWidget {
  @override
  State<BotonRojoPage> createState() => _BotonRojoPageState();
}

class _BotonRojoPageState extends State<BotonRojoPage> {
  final listaSelectInfo = new ContactosProvider();
  List<ContactoDatos> listaIdContacto = [];

  List<ContactoDatos> listaE = [];
  String mensaje;

  List<ContactoDatos> listaContactos = [];
  bool hayLista = true;

  @override
  void initState() {
    super.initState();
    cargarPrefs();
  }

  cargarPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    mensaje = prefs.getString('mensajeE');
    if (mensaje == null) {
      mensaje = "Necesito ayuda !!";
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);

    List<ContactoDatos> listaGrupo = [];
    if (apiProvider.contactgrupos.contains('Emergencia')) {
      if (apiProvider.categoryContact['Emergencia'].isNotEmpty) {
        //*** con los nombres de la lista de contactos genero lista con los datos de cada contacto */
        listaContactos = [];
        listaContactos.addAll(apiProvider.categoryContact['Emergencia']);
      }
    }
    Future<List<ContactoDatos>> obtenerListaGrupo() async {
      if (listaContactos.isEmpty) {
        List<ContactoDatos> lista =
            await apiProvider.obtenerListaContactosGrupo(context, 'Emergencia');

        listaContactos.addAll(lista);
      }
      return listaContactos;
    }

    return SafeArea(
      child: Scaffold(
        appBar:
            headerApp(context, 'Emergencia', Text(''), 0.0, false, 'BotonRojo'),
        //appBar: headerEmergencia(context),
        body: FutureBuilder(
            future: obtenerListaGrupo(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  listaGrupo.addAll(snapshot.data);
                }

                if (listaGrupo.isNotEmpty) {
                  // snapshot contiene lista de displayname de los contactos por grupo
                  return conListaEmergenia(context, snapshot.data);
                } else {
                  return sinListaEmergenia(context);
                }
              }
            }),
      ),
    );
  }
}

conListaEmergenia(BuildContext context, List<ContactoDatos> listaE) {
  final pref = Provider.of<Preferencias>(context);
  // double width = MediaQuery.of(context).size.width / 3;
  double height = (MediaQuery.of(context).size.height * 0.60);

  return SingleChildScrollView(
    child: Center(
      child: Container(
        height: height,
        margin: EdgeInsets.only(left: 10.0, bottom: 25, right: 10),
        //   alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'EMERGENCIA ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
              ),
            ),
            Container(
              child: Text(
                'Enviar mensaje a mis contactos de emergencia',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 30.0,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                //******************* */
                // await mandarSMS(listaE);
                final AudioCache player = new AudioCache();
                player.play('audio_emergencia.mpeg');
                mandarSMS(listaE);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResumenEnvioPage(
                              listaE: listaE,
                            )));
              },
              child: Container(
                height: MediaQuery.of(context).size.width <= 320 ? 150 : 180,
                width: MediaQuery.of(context).size.width <= 320 ? 150 : 180,
                decoration: BoxDecoration(
                    color: pref.paleta == '4' ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 4.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: Offset(2, 5),
                      ),
                    ]),
                child: Center(
                  child: Text('Enviar',
                      style: TextStyle(
                        fontSize: 50.0,
                        color: pref.paleta == '4'
                            ? Theme.of(context).primaryColor
                            : Colors.black,
                      )),
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: pref.paleta == '4'
                ? Colors.black
                : Color.fromRGBO(200, 0, 0, 1.0),
            borderRadius: BorderRadius.circular(20.0),
            border:
                Border.all(color: Theme.of(context).primaryColor, width: 4.0)),
      ),
    ),
  );
}

sinListaEmergenia(BuildContext context) {
  final pref = Provider.of<Preferencias>(context);
  double height = (MediaQuery.of(context).size.height * 0.60);
  return SingleChildScrollView(
    child: Center(
        child: Container(
      height: height,
      margin: EdgeInsets.only(left: 10.0, bottom: 80, right: 10),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ADVERTENCIA',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: pref.paleta == '4'
                  ? Theme.of(context).primaryColor
                  : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 40.0,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Debe registrar sus contactos de emergencia para poder notificar la emergencia',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: pref.paleta == '4'
                    ? Theme.of(context).primaryColor
                    : Colors.black,
                fontSize: 30.0,
              ),
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: pref.paleta == '4'
              ? Theme.of(context).backgroundColor
              : Color.fromRGBO(249, 75, 11, 1),
          borderRadius: BorderRadius.circular(20.0),
          border:
              Border.all(color: Theme.of(context).primaryColor, width: 4.0)),
    )),
  );
}
