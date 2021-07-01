import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';
import 'package:provider/provider.dart';

//class EmergenciaContactos extends StatelessWidget {
class EmergenciaContactos extends StatefulWidget {
  @override
  _EmergenciaContactos createState() => _EmergenciaContactos();
}

class _EmergenciaContactos extends State<EmergenciaContactos> {
  List<ItemListaEmergencia> listaE;
  @override
  Widget build(BuildContext context) {
    final listaSelectInfo = Provider.of<ContactosProvider>(context);
    listaSelectInfo.obtenerlistaContactos();
    listaE = listaSelectInfo.listaSelect;
    return Scaffold(
      appBar: AppBar(
        title: Text('Contactos de Emergencía'),
      ),
      body: ListView.builder(
          itemCount: listaE.length,
          itemBuilder: (context, i) {
            return Dismissible(
              onDismissed: (DismissDirection direction) {
                setState(() {
                  Provider.of<ContactosProvider>(context, listen: false)
                      .cambiarCheck(listaE[i].iListaContacto, false);
                  Provider.of<ContactosProvider>(context, listen: false)
                      .quitarContacto(listaE[i].iListaContacto);
                });
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
          }),
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
              // setState(() {
              //  listaE = Provider.of<ContactosProvider>(context, listen: false)
              //      .listaSelect;
              // });
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
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _avatar(ItemListaEmergencia contacto) {
    if (contacto.avatar.isEmpty) {
      return Container(
        height: 90.0,
        child: CircleAvatar(
          child: Text(
            contacto.initials,
            style: TextStyle(fontSize: 30.0, color: Colors.green),
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
          color: Color.fromRGBO(55, 57, 84, 1.0), //Colors.green[300],
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
