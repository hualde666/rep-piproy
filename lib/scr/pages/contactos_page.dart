import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

import 'package:piproy/scr/providers/contactos_provider.dart';
import 'package:piproy/scr/widgets/boton_home.dart';
import 'package:piproy/scr/widgets/botonrojo_app.dart';

import 'package:piproy/scr/widgets/contactos_card.dart';

class ContactosPage extends StatefulWidget {
  @override
  _ContactosPageState createState() => _ContactosPageState();
}

class _ContactosPageState extends State<ContactosPage> {
  final contactProvider = new ContactosProvider();
  Future<List<Contact>> listaContactos;
  List<Contact> listaContactosFiltro;
  List<Contact> lista1;

  TextEditingController _searchController = TextEditingController();
  bool cargando = true;
  bool hayBusqueda = false;
  bool buscar = false;

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

  Future<List<Contact>> cargarContactos() {
    listaContactos = contactProvider.listaContactos;
    return listaContactos;
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

  @override
  Widget build(BuildContext context) {
    bool hayBusqueda = _searchController.text.isNotEmpty;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white60,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(200.0), // here the desired height
            child:
                // buscar ? titulo() :
                busqueda()),
        body: FutureBuilder(
            future: cargarContactos(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (cargando) {
                  lista1 = List.generate(
                      snapshot.data.length, (i) => snapshot.data[i]);
                  cargando = false;
                }

                List<Widget> listaTarjetas = List.generate(
                    hayBusqueda
                        ? listaContactosFiltro.length
                        : snapshot.data.length,
                    (i) => tarjetaContacto2(
                        context,
                        hayBusqueda
                            ? listaContactosFiltro[i]
                            : snapshot.data[i]));
                return cargando
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: listaTarjetas.length,
                        itemBuilder: (context, index) {
                          Widget contacto = listaTarjetas[index];
                          return contacto;
                        });
              }
            }),

        //  bottomNavigationBar: BottonBarNavegador(),
      ),
    );
  }

  Widget encabezadoContactos() {
    return SliverAppBar(
      elevation: 2.0,
      // backgroundColor: Colors.teal[600],
      //expandedHeight: 100.0,

      floating: true,
      pinned: true,
      title: Text('C O N T A C T O S'),
      flexibleSpace: busqueda(),
    );
  }

  titulo() {
    return AppBar(
        backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          height: 220,
          width: 400,
          margin: EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [BotonRojoHeader(context), BotonHomeHeader(context)],
              ),
              Divider(
                height: 10,
              ),
              Container(
                height: 70,
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white, width: 0.5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Buscar Contacto',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    IconButton(
                        // padding: EdgeInsets.only(right: 10.0),
                        icon: Icon(
                          Icons.search,
                          size: 40.0,
                          color: Colors.white,
                        ),
                        tooltip: 'Busqueda',
                        onPressed: () {
                          setState(() {
                            buscar = false;
                          });
                        }),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget busqueda() {
    return AppBar(
      backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        margin: EdgeInsets.only(top: 10, left: 5.0, right: 5.0),
        height: 220.0,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [BotonRojoHeader(context), BotonHomeHeader(context)],
            ),
            Divider(
              height: 10,
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
