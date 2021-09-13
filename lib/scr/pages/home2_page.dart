import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/elemntos.dart';
import 'package:piproy/scr/widgets/encabezado2.dart';
import 'package:piproy/scr/widgets/pila_tiempo_clima.dart';

class Home2Page extends StatelessWidget {
  //final contactosProvider = new ContactosProvider();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(220.0),
          child: AppBar(
              //       //title: Center(child: Text('Proyecto PI')),
              //       // automaticallyImplyLeading: false, // hides leading widget
              flexibleSpace: encabezadoApp2(context, 'Proyecto PI')),
        ),
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: _detalle(context),
        ),
        // bottomNavigationBar: BottonBarNavegador(),
      ),
    );
  }

  List<Widget> _detalle(BuildContext context) {
    return <Widget>[
      // encabezadoApp2(context, 'Proyecto PI'),
      SliverList(
        delegate: SliverChildListDelegate([
          SizedBox(height: 5.0),
          elementos(
              context, PilaTimpoClima(), Theme.of(context).primaryColor, ''),
          // elementos(
          //     context,
          //     Text('EMERGENCIA',
          //         style: TextStyle(color: Colors.white, fontSize: 35.0)),
          //     Color.fromRGBO(150, 0, 0, 1.0),
          //     'botonRojo'),
          elementos(
              context,
              Text('Contactos',
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              Theme.of(context).primaryColor,
              'contactos'),
          elementos(
              context,
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.amber,
              ),
              Theme.of(context).primaryColor,
              ''),
          elementos(
              context,
              Text('ELEMENTO',
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              Theme.of(context).primaryColor,
              ''),
          elementos(
              context,
              Text('ELEMENTO',
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              Theme.of(context).primaryColor,
              ''),
        ]),
      )
    ];
  }
}
