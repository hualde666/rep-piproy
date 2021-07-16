import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:piproy/scr/providers/contactos_provider.dart';
import 'package:provider/provider.dart';

//class EmergenciaContactos extends StatelessWidget {
class EmergenciaContactos extends StatefulWidget {
  @override
  _EmergenciaContactos createState() => _EmergenciaContactos();
}

class _EmergenciaContactos extends State<EmergenciaContactos> {
  List<ItemListaEmergencia> listaE =
      []; // lista activa de contactos telefonos de emergencia
  List<String> listaPhone = []; // lista de telefonos guardados

// CARGA la lista de telefonos de emergemcia guardada
  cargarPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listaPhone = prefs.getStringList('listaE');
  }

// GRABA la lista de telefonos de emergemcia
  guardarLista() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // genera primero una lista con solo los numeros telefonicos que
    // es lo que se guarda
    listaPhone = List.generate(listaE.length, (i) => listaE[i].phone);
    prefs.setStringList('listaE', listaPhone);
  }

  @override
  Widget build(BuildContext context) {
    final listaSelectInfo = Provider.of<ContactosProvider>(context);

    if (listaE.length == 0) {
      cargarPrefs();
      listaSelectInfo.obtenerlistaContactos();
      if (listaPhone != null) {
        for (var numero in listaPhone) {
          // genera lista de CONTACTOS seleccionados con los telf guardados

          listaSelectInfo.generarListaSelect(numero);
        }
      }
    }

    listaE = listaSelectInfo.listaSelect;

    return Scaffold(
      appBar: AppBar(
        title: Text('Contactos de Emergencía'),
      ),
      body: listaSelectInfo.listaContactos.length == 0
          ? Center(
              child: Container(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
            )
          : pantallaInicial(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            tooltip: 'agergar',
            heroTag: 'agregar',
            onPressed: () {
              Navigator.pushNamed(context, 'selecContactos');
              setState(() {});
            },
          ),
          SizedBox(
            width: 20.0,
          ),
          FloatingActionButton(
            child: Icon(Icons.check),
            tooltip: 'guardar',
            heroTag: 'guardar',
            onPressed: () {
              // *** actualizar BD ***
              guardarLista();

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget pantallaInicial() {
    final listaSelectInfo = Provider.of<ContactosProvider>(context);
    listaE = listaSelectInfo.listaSelect;

    return listaE.length != 0
        ? ListView.builder(
            itemCount: listaE.length,
            itemBuilder: (context, i) {
              return Dismissible(
                onDismissed: (DismissDirection direction) {
                  // setState(() async {
                  Provider.of<ContactosProvider>(context, listen: false)
                      .cambiarCheck(listaE[i].iListaContacto, false);
                  Provider.of<ContactosProvider>(context, listen: false)
                      .quitarContacto(listaE[i].iListaContacto);

                  guardarLista();
                },
                key: UniqueKey(),
                background: Container(
                  padding: EdgeInsets.only(top: 25.0, left: 30.0),
                  color: Colors.red,
                  child: Text(
                    'ELIMINAR',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                child: contactoWidget(listaE[i]),
              );
            })
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

  Widget _avatar(ItemListaEmergencia contacto) {
    if (contacto.avatar.isEmpty) {
      return Container(
        height: 90.0,
        child: CircleAvatar(
          child: Text(
            contacto.initials,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w900,
                color: Colors.green),
          ),
          foregroundColor: Colors.green,
          backgroundColor: Colors.white,
          maxRadius: 50.0,
        ),
      );
    } else {
      return Container(
        height: 90.0,
        child: CircleAvatar(
          maxRadius: 50.0,
          backgroundImage: MemoryImage(contacto.avatar),
        ),
      );
    }
  }

  Widget contactoWidget(ItemListaEmergencia contacto) {
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
          _avatar(contacto),
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
                Text(contacto.phone,
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
