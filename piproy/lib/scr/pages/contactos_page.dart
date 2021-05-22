import 'package:flutter/material.dart';
import 'package:piproy/widgets/botton_bar.dart';
import 'package:piproy/widgets/tarjeta_contactos.dart';
import 'package:piproy/widgets/encabezado.dart';
import 'package:piproy/widgets/encabezado_icon.dart';

class ContactosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(200.0), // here the desired height
      //   child: _encabezadoApp(),
      // ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: _detalleContacto(context),
        ),
      ),
      bottomNavigationBar: bottonBarNavegador(context),
    );
  }

  List<Widget> _detalleContacto(BuildContext context) {
    return <Widget>[
      encabezadoApp(),
      SliverList(
        delegate: SliverChildListDelegate([
          encabezadoIcon(),
          SizedBox(height: 3.0),
          tarjetaContacto(
              context,
              Center(
                child: Text('C O N T A C T O',
                    style: TextStyle(color: Colors.white, fontSize: 35.0)),
              ),
              Colors.black,
              ''),
          SizedBox(height: 3.0),
          tarjetaContacto(
              context,
              Center(
                child: Text('C O N T A C T O',
                    style: TextStyle(color: Colors.white, fontSize: 35.0)),
              ),
              Colors.black,
              ''),
          SizedBox(height: 3.0),
          tarjetaContacto(
              context,
              Center(
                child: Text('C O N T A C T O',
                    style: TextStyle(color: Colors.white, fontSize: 35.0)),
              ),
              Colors.black,
              ''),
          SizedBox(height: 3.0),
          tarjetaContacto(
              context,
              Center(
                child: Text('C O N T A C T O',
                    style: TextStyle(color: Colors.white, fontSize: 35.0)),
              ),
              Colors.black,
              ''),
          SizedBox(height: 3.0),
          tarjetaContacto(
              context,
              Center(
                child: Text('C O N T A C T O',
                    style: TextStyle(color: Colors.white, fontSize: 35.0)),
              ),
              Colors.black,
              ''),
          SizedBox(height: 3.0),
          tarjetaContacto(
              context,
              Center(
                child: Text('C O N T A C T O',
                    style: TextStyle(color: Colors.white, fontSize: 35.0)),
              ),
              Colors.black,
              ''),
          SizedBox(height: 3.0),
          tarjetaContacto(
              context,
              Center(
                child: Text('C O N T A C T O',
                    style: TextStyle(color: Colors.white, fontSize: 35.0)),
              ),
              Colors.black,
              ''),
          SizedBox(height: 3.0),
        ]),
      )
    ];
  }
}
