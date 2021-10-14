import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';

import 'package:piproy/scr/funciones/lista_selecion_contactos.dart';
import 'package:piproy/scr/models/items_lista_contactos.dart';
import 'package:piproy/scr/providers/lista_id_provider.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:piproy/scr/providers/contactos_provider.dart';

//class EmergenciaContactos extends StatelessWidget {
class EmergenciaContactos extends StatefulWidget {
  @override
  _EmergenciaContactos createState() => _EmergenciaContactos();
}

class _EmergenciaContactos extends State<EmergenciaContactos> {
  final listaSelectInfo = new ContactosProvider();
  List<ItemListaEmergencia> listaE = []; // lista  de  contactos  de emergencia
  List<String> listaIdContacto;

  Future<List<Contact>> lista;
  bool cargando = true;
  @override
  void initState() {
    super.initState();
    cargarPrefs();
  }

// GRABA la lista de telefonos de emergemcia
  guardarLista() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // genera primero una lista con solo los id de contactos que
    // es lo que se guarda
    // listaIdContacto = List.generate(listaE.length, (i) => listaE[i].idcontacto);
    prefs.setStringList('listaE', listaIdContacto);
  }

  Future cargarPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listaIdContacto = prefs.getStringList('listaE');
    if (listaIdContacto == null) {
      listaIdContacto = [];
    }
    return;
  }

  Future<List<Contact>> cargarContactos() async {
    return await listaSelectInfo.listaContactos;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: headerApp(context, 'Contactos de Emergencia', Text(''), 0.0),
        body: pantallaInicial(context),
        floatingActionButton: botonesFab(),
      ),
    );
  }

  Widget botonesFab() {
    //ListaIdProvider listaIdProvider = Provider.of<ListaIdProvider>(context);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      BotonFlotante(pagina: 'emergiContactos'),
      FloatingActionButton.extended(
        heroTag: "emergCpntactos",
        icon: Icon(
          Icons.add_circle,
          size: 40,
          color: Colors.white,
        ),
        label: Text(
          'agregar',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(249, 75, 11, 1),
        onPressed: () {
          Navigator.of(context).pushNamed('selecContactos');
          cargando = true;
        },
      )
    ]);
  }

  Widget pantallaInicial(BuildContext context) {
    final listaIdProvider = Provider.of<ListaIdProvider>(context);
    double alto = MediaQuery.of(context).size.height * 0.78;

    return FutureBuilder(
        future: cargarContactos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (cargando) {
              listaIdProvider.listaIdContacto = listaIdContacto;

              cargando = false;
            }
            listaIdContacto = listaIdProvider.listaIdContacto;

            listaE = generaListaE(snapshot.data, listaIdContacto);

            return listaE.isNotEmpty
                ? Container(
                    height: alto,
                    child: ListView.builder(
                        itemCount: listaE.length,
                        itemBuilder: (context, i) {
                          return contactoWidget(listaE[i], i);
                        }),
                  )
                : Center(
                    child: Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Definir contactos de Emergencia. ',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Tocar simbolo  +  para añadir.',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    )),
                  );
          }
        });
  }

  Widget contactoWidget(ItemListaEmergencia contacto, int i) {
    String phone = contacto.phone.replaceAll('+', '');
    return Container(
      height: 100.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor, //Colors.green[300],
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.green)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //_avatar(contacto),
          Container(
            width: 200.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contacto.nombre,
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(phone,
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(' ${contacto.nombre}',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      content:
                          Text('¿Desea eliminar este contacto de emergencia?'),
                      // shape: CircleBorder(),
                      elevation: 14.0,
                      actionsPadding: EdgeInsets.symmetric(horizontal: 30.0),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Provider.of<ListaIdProvider>(context,
                                      listen: false)
                                  .quitarIdContacto(contacto.idcontacto);
                              listaE.removeWhere((item) =>
                                  item.idcontacto == contacto.idcontacto);

                              guardarLista();
                              Navigator.pop(context);
                              setState(() {});
                            },
                            child:
                                Text('Si', style: TextStyle(fontSize: 20.0))),
                        TextButton(
                            autofocus: true,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No', style: TextStyle(fontSize: 20.0)))
                      ],
                    ),
                  ),
                  icon: Icon(
                    Icons.delete,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'eliminar',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
