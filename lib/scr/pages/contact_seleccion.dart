import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

import 'package:piproy/scr/models/api_tipos.dart';
import 'package:piproy/scr/models/contactos_modelo.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';

import 'package:piproy/scr/providers/db_provider.dart';

import 'package:piproy/scr/widgets/tres_botones_header.dart';
import 'package:provider/provider.dart';

class SelectContactsPage extends StatefulWidget {
  @override
  State<SelectContactsPage> createState() => _SelectContactsPageState();
}

class _SelectContactsPageState extends State<SelectContactsPage> {
  List<ContactoDatos> listaGrupo = [];
  bool abilitarBusqueda = false;
  bool hayBusqueda = false;
  bool buscar = false;
  TextEditingController _searchController = TextEditingController();
  List<ContactoDatos> listaContactosFiltro;
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

  filtrarContactos() {
    if (_searchController.text.isNotEmpty) {
      List<ContactoDatos> _contactos = [];

      _contactos.addAll(listaGrupo);
      _contactos.retainWhere((contacto) {
        String busquedaMinuscula = _searchController.text.toLowerCase();
        String nombreMinuscula = contacto.nombre.toLowerCase();
        return nombreMinuscula.contains(busquedaMinuscula);
      });
      setState(() {
        listaContactosFiltro = [];
        listaContactosFiltro.addAll(_contactos);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);

    final grupo = apiProvider.tipoSeleccion;
    // final listaGrupo = generarLista(
    //     apiProvider.categoryContact[grupo], contactosProvaide.listaContactos);

    // bool hayBusqueda = _searchController.text.isNotEmpty;

    Future<List<ContactoDatos>> obtenerListaGrupo() async {
      if (_searchController.text.isNotEmpty) {
        return listaContactosFiltro;
      } else {
        List<ContactoDatos> lista =
            await apiProvider.obtenerListaContactosGrupo(context, 'Todos');
        listaGrupo = [];
        listaGrupo.addAll(lista);
        // abilitarBusqueda = true;

        return listaGrupo;
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: SafeArea(
          child: Scaffold(
              appBar: PreferredSize(
                  preferredSize:
                      Size.fromHeight(250.0), // here the desired height
                  child: busqueda(context)),
              resizeToAvoidBottomInset: false,
              body: FutureBuilder(
                  future: obtenerListaGrupo(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (snapshot.hasData) {
                        List<Widget> listaContact = List.generate(
                            snapshot.data.length,
                            (i) => Contacto(
                                contactoSelec: snapshot.data[i],
                                apiProvider: apiProvider,
                                grupo: grupo));

                        return
                            // GestureDetector(
                            //   onTap: () {
                            //     FocusScope.of(context)
                            //         .requestFocus(new FocusNode());
                            //   },
                            //   child:
                            Container(
                          padding: EdgeInsets.only(bottom: 55),
                          child: ListView.builder(
                              padding: EdgeInsets.only(
                                bottom: 220,
                              ),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                return listaContact[i];
                              }),
                          //),
                        );
                      } else {
                        return Container();
                      }
                    }
                  }),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton.extended(
                  heroTag: "guardar",
                  icon: Icon(
                    Icons.save,
                  ),
                  label: Text(
                    'guardar',
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }))),
    );
  }

  Widget busqueda(BuildContext context) {
    return
        //AppBar(
        // backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
        // automaticallyImplyLeading: false,
        // flexibleSpace:
        Container(

            // margin: EdgeInsets.only(top: 5, left: 5.0, right: 5.0),
            height: 255.0,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                tresBotonesHeader(context, true, 'ContactoSeleccion'),
                Text(
                  'Seleccion de Contactos',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 7,
                      ),
                      child: TextField(
                        // enabled: abilitarBusqueda,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25.0, color: Colors.white54, height: 1.0),
                        keyboardType: TextInputType.name,
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                        // ],
                        controller: _searchController,
                        // autofocus: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              //borderSide: BorderSide(color: Colors.amber),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                          labelStyle:
                              TextStyle(color: Colors.white38, fontSize: 20),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                        ),
                      ),
                    )),
              ],
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

  final ContactoDatos contactoSelec;
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
                    .contains(widget.contactoSelec)
                ? Theme.of(context).backgroundColor
                : Colors.grey[700],
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Theme.of(context).primaryColor)),
        child: Center(
            child: Text(widget.contactoSelec.nombre,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 30))),
      ),
      onTap: () {
        if (widget.apiProvider.categoryContact[widget.grupo]
            .contains(widget.contactoSelec)) {
          //eliminar
          Provider.of<AplicacionesProvider>(context, listen: false)
              .eliminarContacto(widget.grupo, widget.contactoSelec);

          DbTiposAplicaciones.db
              .deleteApi(widget.grupo, widget.contactoSelec.nombre);
        } else {
          //agregar

          Provider.of<AplicacionesProvider>(context, listen: false)
              .agregarContacto(widget.grupo, widget.contactoSelec);
          final nuevo = new ApiTipos(
              grupo: widget.grupo,
              nombre: widget.contactoSelec.nombre,
              tipo: "2");
          DbTiposAplicaciones.db.nuevoTipo(nuevo);
        }
        setState(() {});
      },
    );
  }
}
