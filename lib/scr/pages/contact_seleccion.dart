import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';
import 'package:piproy/scr/models/api_tipos.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';

import 'package:piproy/scr/providers/db_provider.dart';

import 'package:piproy/scr/widgets/tres_botones_header.dart';
import 'package:provider/provider.dart';

class SelectContactsPage extends StatefulWidget {
  @override
  State<SelectContactsPage> createState() => _SelectContactsPageState();
}

class _SelectContactsPageState extends State<SelectContactsPage> {
  List<Contact> listaGrupo = [];
  bool hayBusqueda = false;
  bool buscar = false;
  TextEditingController _searchController = TextEditingController();
  List<Contact> listaContactosFiltro;
  @override
  void initState() {
    super.initState();

    _searchController.addListener(filtrarContactos);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  generarLista(List<String> listaNombre, List<Contact> listaContactos) {
    listaGrupo = [];
    if (listaNombre.isNotEmpty) {
      for (int i = 0; i < listaNombre.length; i++) {
        final contacto = listaContactos
            .firstWhere((element) => element.displayName == listaNombre[i]);
        listaGrupo.add(contacto);
      }
    }

    return listaGrupo;
  }

  filtrarContactos() {
    final contactosProvaide = new ContactosProvider();
    List<Contact> _contactos = [];

    _contactos.addAll(contactosProvaide.listaContactos);
    if (_searchController.text.isNotEmpty) {
      _contactos.retainWhere((contacto) {
        String busquedaMinuscula = _searchController.text.toLowerCase();
        String nombreMinuscula = contacto.displayName.toLowerCase();
        return nombreMinuscula.contains(busquedaMinuscula);
      });
      setState(() {
        listaContactosFiltro = _contactos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    final contactosProvaide = new ContactosProvider();
    final grupo = apiProvider.tipoSeleccion;
    // final listaGrupo = generarLista(
    //     apiProvider.categoryContact[grupo], contactosProvaide.listaContactos);

    final List<Contact> listaTodos = [];
    bool hayBusqueda = _searchController.text.isNotEmpty;
    if (hayBusqueda) {
      listaTodos.addAll(listaContactosFiltro);
    } else {
      listaTodos.addAll(contactosProvaide.listaContactos);
    }
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(222.0), // here the desired height
          child: busqueda(context)),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: BotonFlotante(pagina: 'selecCont'),
    ));
  }

  Widget busqueda(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        margin: EdgeInsets.only(top: 10, left: 5.0, right: 5.0),
        height: 242.0,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            tresBotonesHeader(context),
            Divider(
              height: 1,
            ),
            Text(
              'Seleccion de Contactos',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            TextField(
              style:
                  TextStyle(fontSize: 25.0, color: Colors.white54, height: 1.0),
              keyboardType: TextInputType.text,
              controller: _searchController,
              // autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    //borderSide: BorderSide(color: Colors.amber),
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                labelStyle: TextStyle(color: Colors.white38, fontSize: 20),
                labelText: 'Buscar Contacto :',
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            buscar = true;
                          });
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 30,
                        ))
                    : Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30,
                      ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
              ),
            ),
          ],
        ),
      ),
    );
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
              .eliminarContacto(widget.grupo, widget.contactoSelec.displayName);

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
