import 'package:flutter/material.dart';

import 'package:contacts_service/contacts_service.dart';
import 'package:piproy/scr/models/items_lista_contactos.dart';

import 'package:piproy/scr/providers/contactos_provider.dart';
import 'package:piproy/scr/providers/lista_id_provider.dart';
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

  guardarLista() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // genera primero una lista con solo los id de contactos que
    // es lo que se guarda
    if (listaIdContacto != null) {
      prefs.setStringList('listaE', listaIdContacto);
    }
  }

  void _cambiarIcon() {
    setState(() {
      buscarIcon = !buscarIcon;
    });
  }

  Future<List<Contact>> cargarContactos() {
    lista = listaSelectInfo.listaContactos;
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    ListaIdProvider listaIdProvider = Provider.of<ListaIdProvider>(context);
    listaIdContacto = listaIdProvider.listaIdContacto;
    bool hayBusqueda = _searchController.text.isNotEmpty;
    double alto = MediaQuery.of(context).size.height * 0.73;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0), // here the desired height
        child: busqueda(),
      ),
      body: mostrarContactos(context),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.check_circle,
          size: 40,
          color: Colors.white,
        ),
        label: Text(
          'guardar',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        elevation: 10,
        backgroundColor: Color.fromRGBO(249, 75, 11, 1),
        onPressed: () {
          listaIdContacto = listaIdProvider.listaIdContacto;
          guardarLista();

          Navigator.pop(context);
        },
      ),
      // bottomNavigationBar: BottonBarNavegador(),
    );
  }

  titulo() {
    return AppBar(
        backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
        title: Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Selección Contactos'),
                  Text('de Emergencia'),
                ],
              ),
              IconButton(
                  // padding: EdgeInsets.only(right: 10.0),
                  icon: Icon(
                    Icons.search,
                    size: 30.0,
                  ),
                  tooltip: 'Busqueda',
                  onPressed: () {
                    // setState(() {
                    //   tituloApp = 2;
                    // });
                  }),
            ],
          ),
        ));
  }

  Widget busqueda() {
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

  Widget contactoWidget(
      BuildContext context, ItemListaEmergencia contacto, int i) {
    //  ListaIdProvider listaIdProvider = Provider.of<ListaIdProvider>(context);

    return Container(
      height: 150.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor, //Colors.green[300],
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.green)),
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
          Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 1.5,
                  child: Checkbox(
                      value: contacto.check,
                      activeColor: Colors.white,
                      checkColor: Colors.green,
                      onChanged: (value) {
                        contacto.check = value;

                        setState(() {
                          if (value) {
                            print(contacto.idcontacto);
                            Provider.of<ListaIdProvider>(context, listen: false)
                                .sumarIdContacto(contacto.idcontacto);
                          } else {
                            print(contacto.idcontacto);
                            Provider.of<ListaIdProvider>(context, listen: false)
                                .quitarIdContacto(contacto.idcontacto);
                          }
                        });
                        // listaIdContacto = listaIdProvider.listaIdContacto;
                        // guardarLista();
                      }),
                ),
                contacto.check
                    ? Text(
                        'quitar',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    : Text(
                        'agregar',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
              ],
            ),
          )
        ],
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
                    return contactoWidget(context, listaContactosCheck[i], i);
                  }),
            );
          }
        });
  }
}
