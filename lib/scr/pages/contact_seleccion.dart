import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';
import 'package:piproy/scr/models/api_tipos.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';

import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

class SelectContactsPage extends StatelessWidget {
  generarLista(List<String> listaNombre, List<Contact> listaContactos) {
    List<Contact> listaGrupo = [];
    if (listaNombre.isNotEmpty) {
      for (int i = 0; i < listaNombre.length; i++) {
        final contacto = listaContactos
            .firstWhere((element) => element.displayName == listaNombre[i]);
        listaGrupo.add(contacto);
      }
    }

    return listaGrupo;
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final contactosProvaide = new ContactosProvider();
    final grupo = apiProvider.tipoSeleccion;
    final listaGrupo = generarLista(
        apiProvider.categoryContact[grupo], contactosProvaide.listaContactos);

    final List<Contact> listaTodos = contactosProvaide.listaContactos;
    return SafeArea(
        child: Scaffold(
      appBar: headerApp(context, 'Contactos', Text(''), 0.0),
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView.builder(
          padding: EdgeInsets.only(bottom: 65),
          itemCount: listaTodos.length,
          itemBuilder: (context, i) {
            return Contacto(
                contactoSelec: listaTodos[i],
                apiProvider: apiProvider,
                grupo: grupo);
          }),
      floatingActionButton: BotonFlotante(pagina: 'selecCont'),
    ));
  }
}

class Contacto extends StatefulWidget {
  const Contacto({
    Key key,
    @required this.contactoSelec,
    @required this.apiProvider,
    @required this.grupo,
  }) : super(key: key);

  final Contact contactoSelec;
  final AplicacionesProvider apiProvider;
  final String grupo;

  @override
  State<Contacto> createState() => _ContactoState();
}

class _ContactoState extends State<Contacto> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        width: double.infinity,
        height: 96.0,
        decoration: BoxDecoration(
            color: widget.apiProvider.categoryContact[widget.grupo]
                    .contains(widget.contactoSelec.displayName)
                ? Color.fromRGBO(55, 57, 84, 1)
                : Colors.grey[700],
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.white)),
        child: Center(
            child: Text(widget.contactoSelec.displayName,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 30))),
      ),
      onTap: () {
        if (widget.apiProvider.categoryContact[widget.grupo]
            .contains(widget.contactoSelec.displayName)) {
          //eliminar
          Provider.of<AplicacionesProvider>(context, listen: false)
              .eliminarContacto(widget.grupo, widget.contactoSelec);

          DbTiposAplicaciones.db
              .deleteApi(widget.grupo, widget.contactoSelec.displayName);
        } else {
          //agregar

          Provider.of<AplicacionesProvider>(context, listen: false)
              .agregarContacto(widget.grupo, widget.contactoSelec);
          final nuevo = new ApiTipos(
              grupo: widget.grupo,
              nombre: widget.contactoSelec.displayName,
              tipo: "2");
          DbTiposAplicaciones.db.nuevoTipo(nuevo);
        }
        setState(() {});
      },
    );
  }
}
