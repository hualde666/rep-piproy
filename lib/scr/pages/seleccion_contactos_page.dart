import 'package:flutter/material.dart';

import 'package:contacts_service/contacts_service.dart';
import 'package:piproy/scr/models/items_lista_contactos.dart';

import 'package:piproy/scr/providers/contactos_provider.dart';
import 'package:piproy/scr/providers/lista_id_provider.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

//class SeleccionContacto extends StatelessWidget {
class SeleccionContacto extends StatefulWidget {
  @override
  _SeleccionContactoState createState() => _SeleccionContactoState();
}

class _SeleccionContactoState extends State<SeleccionContacto> {
  bool cargando = true;
  final listaSelectInfo = new ContactosProvider();
  Future<List<Contact>> lista; // todos los contactos
  List<Contact> listaContactosFiltro;
  List<Contact> lista1;
  List<String> listaIdContacto = []; //  preferencias
  List<ItemListaEmergencia> listaContactosCheck = []; // filtro
  TextEditingController _searchController = TextEditingController();
  bool hayBusqueda = false;
  bool buscarIcon = true;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(filtrarContactos);
    // cargarPrefs();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  filtrarContactos() {
    List<Contact> _contactos = [];
    _contactos.addAll(lista1);
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

  generarLista(List<Contact> nuevalista) {
    listaContactosCheck = [];
    for (var contacto in nuevalista) {
      ItemListaEmergencia nuevo = ItemListaEmergencia(
          contacto.identifier,
          contacto.displayName,
          contacto.avatar,
          contacto.initials(),
          contacto.phones.elementAt(0).value,
          false);

      listaContactosCheck.add(nuevo);
    }

    //*** marco los que ya fueron seleccionados */
    if (listaIdContacto != null) {
      for (var id in listaIdContacto) {
        int i = listaContactosCheck.indexWhere(
            (listaContactosCheck) => listaContactosCheck.idcontacto == id);
        if (i >= 0) {
          listaContactosCheck[i].check = true;
        }
      }
    }
  }

  Future<List<Contact>> cargarContactos() {
    lista = listaSelectInfo.listaContactos;
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    ListaIdProvider listaIdProvider = Provider.of<ListaIdProvider>(context);
    listaIdContacto = listaIdProvider.listaIdContacto;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: headerApp(context, 'Selección Contactos', busqueda(), 80.0),
      body: GestureDetector(
          onTap: () {
            final FocusScopeNode focus = FocusScope.of(context);
            if (!focus.hasPrimaryFocus && focus.hasFocus) {
              FocusManager.instance.primaryFocus.unfocus();
            }
          },
          onTapUp: (_) {
            final FocusScopeNode focus = FocusScope.of(context);
            if (!focus.hasPrimaryFocus && focus.hasFocus) {
              FocusManager.instance.primaryFocus.unfocus();
            }
          },
          child: mostrarContactos(context)),
    );
  }

  Widget busquedaV() {
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
        flexibleSpace: Container(
            //color: Color.fromRGBO(55, 57, 84, 1.0),
            margin: EdgeInsets.only(top: 40.0, left: 5.0, right: 5.0),
            height: 100.0,
            child: Column(children: [
              TextField(
                style: TextStyle(
                    fontSize: 25.0, color: Colors.white54, height: 1.0),
                keyboardType: TextInputType.text,
                controller: _searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      //borderSide: BorderSide(color: Colors.amber),
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  labelStyle: TextStyle(color: Colors.white38, fontSize: 20),
                  labelText: 'Buscar Contacto:',
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            // _cambiarIcon();
                            setState(() {
                              _searchController.clear();
                            });
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Colors.white,
                            size: 30,
                          ),
                        )
                      : Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 30,
                        ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(25.0))),
                ),
              )
            ])));
  }

  Widget busqueda() {
    return Column(children: [
      TextField(
        style: TextStyle(fontSize: 25.0, color: Colors.white54, height: 1.0),
        keyboardType: TextInputType.text,
        controller: _searchController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              //borderSide: BorderSide(color: Colors.amber),
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          labelStyle: TextStyle(color: Colors.white38, fontSize: 20),
          labelText: 'Buscar Contacto:',
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    // _cambiarIcon();
                    setState(() {
                      _searchController.clear();
                    });
                  },
                  icon: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              : Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
        ),
      )
    ]);
  }

  Widget contactoWidget(
      BuildContext context, ItemListaEmergencia contacto, int i) {
    Color _colorBorde = Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: () {
        if (_colorBorde == Theme.of(context).primaryColor) {
          _colorBorde = Colors.yellow;
        } else {
          _colorBorde = Theme.of(context).primaryColor;
        }
        setState(() {});
      },
      child: Container(
        height: 150.0,
        margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
        decoration: BoxDecoration(
            color: _colorBorde, //Colors.green[300],
            borderRadius: BorderRadius.circular(20.0)),
        //  border: Border.all(color: _colorBorde, width: 2.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 200.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    contacto.nombre,
                    style: TextStyle(
                        fontSize: 28.0,
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
      ),
    );
  }

  mostrarContactos(BuildContext context) {
    double alto = MediaQuery.of(context).size.height * 0.73;
    bool hayBusqueda = _searchController.text.isNotEmpty;
    final listaIdProvider = Provider.of<ListaIdProvider>(context);

    return FutureBuilder(
        future: cargarContactos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            listaIdContacto = listaIdProvider.listaIdContacto;
            if (cargando) {
              lista1 =
                  List.generate(snapshot.data.length, (i) => snapshot.data[i]);
              generarLista(snapshot.data);

              cargando = false;
            }
            if (hayBusqueda) {
              generarLista(listaContactosFiltro);
            } else {
              generarLista(snapshot.data);
            }

            return Container(
              height: alto,
              child: ListView.builder(
                  itemCount: listaContactosCheck.length,
                  itemBuilder: (context, i) {
                    return ContactoWidget(context, listaContactosCheck[i], i);
                  }),
            );
          }
        });
  }
}

class ContactoWidget extends StatefulWidget {
  ContactoWidget(this.context, this.contacto, this.i);
  final ItemListaEmergencia contacto;
  final int i;
  final BuildContext context;

  @override
  _ContactoWidget createState() => _ContactoWidget();
}

class _ContactoWidget extends State<ContactoWidget> {
  List<String> listaIdContacto;

  guardarLista() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // genera primero una lista con solo los id de contactos que
    // es lo que se guarda
    if (listaIdContacto != null) {
      prefs.setStringList('listaE', listaIdContacto);
    }
  }

  @override
  Widget build(BuildContext context) {
    ListaIdProvider listaIdProvider = Provider.of<ListaIdProvider>(context);
    listaIdContacto = listaIdProvider.listaIdContacto;
    Color _colorBorde = widget.contacto.check
        ? Color.fromRGBO(55, 57, 84, 1.0)
        : Color.fromRGBO(55, 57, 84, 0.8);
    return GestureDetector(
      onDoubleTap: () {
        final FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus && focus.hasFocus) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      onTap: () {
        if (!widget.contacto.check) {
          _colorBorde = Color.fromRGBO(55, 57, 84, 1.0);
          Provider.of<ListaIdProvider>(context, listen: false)
              .sumarIdContacto(widget.contacto.idcontacto);
          widget.contacto.check = true;
        } else {
          _colorBorde = Color.fromRGBO(55, 57, 84, 0.8);
          Provider.of<ListaIdProvider>(context, listen: false)
              .quitarIdContacto(widget.contacto.idcontacto);
          widget.contacto.check = false;
        }
        guardarLista();
        setState(() {});
      },
      child: Container(
        width: double.infinity,
        height: 96.0,
        margin: EdgeInsets.symmetric(horizontal: 2.5, vertical: 1.0),
        decoration: BoxDecoration(
            color: _colorBorde, //Colors.green[300],
            borderRadius: BorderRadius.circular(20.0)),
        child: Center(
          child: Text(
            widget.contacto.nombre,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 28.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
