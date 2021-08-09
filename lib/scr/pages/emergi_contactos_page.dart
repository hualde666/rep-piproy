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
  List<String> listaIdContacto = []; // lista de id contactos

// GRABA la lista de telefonos de emergemcia
  guardarLista() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // genera primero una lista con solo los numeros telefonicos que
    // es lo que se guarda
    listaIdContacto = List.generate(listaE.length, (i) => listaE[i].idcontacto);
    prefs.setStringList('listaE', listaIdContacto);
  }

  @override
  Widget build(BuildContext context) {
    final listaSelectInfo = Provider.of<ContactosProvider>(context);
    listaIdContacto = listaSelectInfo.listaIdContacto;

    if (listaIdContacto != null) {
      listaSelectInfo.listaSelect = [];
      for (var idContacto in listaIdContacto) {
        // genera lista de CONTACTOS seleccionados con los telf guardados

        listaSelectInfo.generarListaSelect(idContacto);
      }
    }

    listaE = listaSelectInfo.listaSelect;
    double alto = MediaQuery.of(context).size.height * 0.78;

    return Scaffold(
      appBar: AppBar(
        title: Text('Contactos de Emergencía'),
      ),
      body: pantallaInicial(),
      floatingActionButton: BotonesFab(),
    );
  }

  Widget BotonesFab() {
    double altopie = MediaQuery.of(context).size.height * 0.10;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton.extended(
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
          tooltip: 'agergar',
          heroTag: 'agregar',
          onPressed: () {
            Navigator.pushNamed(context, 'selecContactos');
            setState(() {});
          },
        ),
        SizedBox(
          height: 10,
        ),
        FloatingActionButton.extended(
          icon: Icon(
            Icons.check_circle,
            size: 40,
          ),
          label: Text(
            'guardar',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          backgroundColor: Color.fromRGBO(249, 75, 11, 1),
          tooltip: 'guardar',
          heroTag: 'guardar',
          onPressed: () {
            // *** actualizar BD ***
            guardarLista();

            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget pantallaInicial() {
    final listaSelectInfo = Provider.of<ContactosProvider>(context);
    listaE = listaSelectInfo.listaSelect;
    double alto = MediaQuery.of(context).size.height * 0.78;
    return listaE.isNotEmpty
        ? Container(
            height: alto,
            child: ListView.builder(
                itemCount: listaE.length,
                itemBuilder: (context, i) {
                  return contactoWidget(listaE[i]);
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

  Widget _avatar(ItemListaEmergencia contacto) {
    if (contacto.avatar.isEmpty) {
      return Container(
        height: 60.0,
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
        height: 60.0,
        child: CircleAvatar(
          maxRadius: 50.0,
          backgroundImage: MemoryImage(contacto.avatar),
        ),
      );
    }
  }

  Widget contactoWidget(ItemListaEmergencia contacto) {
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
                              Provider.of<ContactosProvider>(context,
                                      listen: false)
                                  .cambiarCheck(contacto.iListaContacto, false);
                              Provider.of<ContactosProvider>(context,
                                      listen: false)
                                  .quitarContacto(contacto.iListaContacto);
                              Provider.of<ContactosProvider>(context,
                                      listen: false)
                                  .quitarIdContacto(contacto.idcontacto);
                              print(
                                  'Lista id:  $listaIdContacto , ${contacto.idcontacto}');

                              guardarLista();
                              Navigator.pop(context);
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
