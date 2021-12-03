import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';

import 'package:piproy/scr/pages/envio_emergencia.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';
import 'package:piproy/scr/widgets/boton_home.dart';
import 'package:piproy/scr/widgets/boton_verde.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:contacts_service/contacts_service.dart';

import 'package:audioplayers/audioplayers.dart';

class BotonRojoPage extends StatefulWidget {
  @override
  State<BotonRojoPage> createState() => _BotonRojoPageState();
}

class _BotonRojoPageState extends State<BotonRojoPage> {
  final listaSelectInfo = new ContactosProvider();
  List<Contact> listaIdContacto = [];

  List<Contact> listaE = [];
  String mensaje;

  List<Contact> listaContactos = [];
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

  generarLista(List<String> listaNombre, List<Contact> listaContactos) {
    List<Contact> listaGrupo = [];

    if (listaNombre.isNotEmpty) {
      for (int i = 0; i < listaNombre.length; i++) {
        final contacto = listaContactos.firstWhere(
            (element) => element.displayName == listaNombre[i],
            orElse: () => null);
        if (contacto != null) {
          listaGrupo.add(contacto);
        }
      }
    }

    return listaGrupo;
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final contactosProvaide = Provider.of<ContactosProvider>(context);
    if (apiProvider.contactgrupos.contains('Emergencia')) {
      if (apiProvider.categoryContact['Emergencia'].isNotEmpty) {
        //*** con los nombres de la lista de contactos genero lista con los datos de cada contacto */
        listaContactos = [];
        listaContactos.addAll((generarLista(
            apiProvider.categoryContact['Emergencia'],
            contactosProvaide.listaContactos)));
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: headerEmergencia(context),
        body: listaContactos.isNotEmpty
            ? conListaEmergenia(context, listaContactos)
            : sinListaEmergenia(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: BotonFlotante(pagina: 'botonRojo'),
      ),
    );
  }
}

Widget headerEmergencia(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(200.0),
    // here the desired height
    child: Container(
      padding: EdgeInsets.only(top: 35),
      color: Color.fromRGBO(55, 57, 84, 1.0),
      height: 170,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              botonBackHeader(context),
              SizedBox(
                height: 100,
                width: 100,
              ),
              botonHomeHeader(context),
            ],
          ),
          Text('Alerta de Emergencia',
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    ),
  );
}

conListaEmergenia(BuildContext context, List<Contact> listaE) {
  return Center(
    child: Container(
      height: 500.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'EMERGENCIA ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 40.0,
            ),
          ),
          Text(
            'Enviar mensaje a mis contactos de emergencia',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
            ),
          ),
          GestureDetector(
            onTap: () {
              //******************* */
              final AudioCache player = new AudioCache();
              player.play('audio_emergencia.mpeg');
              //listaE[0].check = false;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResumenEnvioPage(
                            listaE: listaE,
                          )));
            },
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.0),
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
                      color: Theme.of(context).primaryColor,
                    )
                    // Theme.of(context).primaryColor),
                    ),
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(200, 0, 0, 1.0),
        borderRadius: BorderRadius.circular(20.0),
        // border: Border.all(color: Colors.white, width: 4.0)
      ),
    ),
  );
}

sinListaEmergenia(BuildContext context) {
  MediaQueryData queryData;
  queryData = MediaQuery.of(context);

  final alto = queryData.size.height;
  return Center(
      child: alto > 400
          ? Container(
              height: 400.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'ADVERTENCIA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                    ),
                  ),
                  Text(
                    'Debe registrar sus contactos de emergencia para poder notificar la emergencia',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(249, 75, 11, 1),
                borderRadius: BorderRadius.circular(20.0),
                // border: Border.all(color: Colors.white, width: 4.0)
              ),
            )
          : Container(
              height: 150.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ADVERTENCIA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                    ),
                  ),
                  Text(
                    'Debe registrar sus contactos de emergencia para poder notificar la emergencia',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(249, 75, 11, 1),
                borderRadius: BorderRadius.circular(20.0),
                // border: Border.all(color: Colors.white, width: 4.0)
              ),
            ));
}
