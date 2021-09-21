import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';
import 'package:piproy/scr/widgets/boton_exit.dart';

import 'package:piproy/scr/widgets/boton_rojo.dart';
import 'package:piproy/scr/widgets/elemntos.dart';

import 'package:piproy/scr/widgets/encabezado_icon.dart';
import 'package:piproy/scr/widgets/pila_tiempo_clima.dart';

class Home2Page extends StatefulWidget {
  //final contactosProvider = new ContactosProvider();

  @override
  State<Home2Page> createState() => _Home2PageState();
}

class _Home2PageState extends State<Home2Page> {
  ScrollController _scrollController = ScrollController();
  bool _topScroll;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _topScroll = true;
        });
      });
  }

  void scrollToTop() {
    _scrollController.jumpTo(0.0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(220.0),
          child: AppBar(flexibleSpace: encabezadoApp(context, 'Proyecto PI')),
        ),
        backgroundColor: Colors.white,
        body: CustomScrollView(
          controller: _scrollController,
          slivers: _detalle(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: BotonFlotante(pagina: 'home'),
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
          elementos(context, PilaTimpoClima(), 200, ''),
          elementos(
              context,
              Text('Contactos',
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              100,
              'contactos'),
          elementos(
              context,
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.amber,
              ),
              100,
              ''),
          elementos(
              context,
              Text('Whatsapp',
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              100,
              ''),
          elementos(
              context,
              Text('ELEMENTO',
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              100,
              ''),
          elementos(
              context,
              Text('Instagram',
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              100,
              ''),
          elementos(
              context,
              Text('ELEMENTO',
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              100,
              ''),
          elementos(
              context,
              Text('ELEMENTO',
                  style: TextStyle(color: Colors.white, fontSize: 35.0)),
              100,
              ''),
        ]),
      )
    ];
  }

  encabezadoApp(BuildContext context, String titulo) {
    return AppBar(
      //elevation: 1.0,
      automaticallyImplyLeading: true,
      flexibleSpace: Container(
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                botonExit(context),
                botonRojoHeader(context),
                GestureDetector(
                  onTap: () {
                    scrollToTop();
                    //            mScrollView.scrollBy(10, 10);
                  },
                  child: Container(
                    child: Image(
                        image: AssetImage('assets/boton_home.png'),
                        fit: BoxFit.cover),
                    height: 100,
                    width: 100,
                    //color: Colors.red),
                  ),
                )
              ], // Hora(context)],
            ),
            Divider(
              height: 2,
            ),
            encabezadoIcon(context),
          ],
        ),
        color: Color.fromRGBO(55, 57, 84, 1.0),
      ),
    );
  }
}

class BotonRojoHeader {}

Widget botonInicio() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      child:
          Image(image: AssetImage('assets/boton_home.png'), fit: BoxFit.cover),
      height: 100,
      width: 100,
      //color: Colors.red),
    ),
  );
}
