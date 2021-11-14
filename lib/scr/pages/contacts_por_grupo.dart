import 'package:contacts_service/contacts_service.dart';

import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';

import 'package:piproy/scr/pages/contact_seleccion.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';

import 'package:piproy/scr/widgets/contactos_card.dart';
import 'package:piproy/scr/widgets/header_app.dart';

import 'package:provider/provider.dart';

class ContactsPorGrupoPage extends StatelessWidget {
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
    final contactosProvaide = new ContactosProvider();
    final apiProvider = Provider.of<AplicacionesProvider>(context);

    final grupo = apiProvider.tipoSeleccion;
    final lista = [];
    if (grupo == 'Todos') {
      lista.addAll(contactosProvaide.listaContactos);
    } else {
      lista.addAll(generarLista(apiProvider.categoryContact[grupo],
          contactosProvaide.listaContactos));
    }

    List<Widget> listaContact =
        List.generate(lista.length, (i) => TarjetaContacto2(context, lista[i]));

    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: headerApp(context, '$grupo', Text(''), 0.0),
      body: ListView(
        padding: EdgeInsets.only(bottom: 60),
        children: listaContact,
      ),
      floatingActionButton: grupo != 'Todos'
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BotonFlotante(pagina: 'grupoContact'),
                FloatingActionButton.extended(
                  heroTag: "agregar",
                  icon: Icon(
                    Icons.add,
                    size: 40,
                    color: Colors.white,
                  ),
                  label: Text(
                    'agregar',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  backgroundColor: Color.fromRGBO(249, 75, 11, 1),
                  onPressed: () {
                    // SELECCION DE contactos POR TIPO
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectContactsPage()));
                  },
                ),
              ],
            )
          : null,
    ));
  }
}
