import 'package:flutter/material.dart';
import 'package:piproy/widgets/botonrojo.dart';
import 'package:piproy/widgets/pila_tiempo_clima.dart';

class Home2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          _encabezadoApp(),
          SliverList(
            delegate: SliverChildListDelegate([
              Pila_Timpo_Clima(),
              SizedBox(height: 3.0),
              _elementos(BotonRojo('home')),
              SizedBox(height: 3.0),
              _elementos(
                Center(
                    child: Text('Contactos',
                        style: TextStyle(color: Colors.white, fontSize: 35.0))),
              ),
              SizedBox(height: 3.0),
              _elementos(
                Center(
                    child: Text('Aplicacion',
                        style: TextStyle(color: Colors.white, fontSize: 35.0))),
              ),
              SizedBox(height: 3.0),
              _elementos(
                Center(
                    child: Text('ELEMENTO',
                        style: TextStyle(color: Colors.white, fontSize: 35.0))),
              ),
              SizedBox(height: 3.0),
              _elementos(
                Center(
                    child: Text('ELEMENTO',
                        style: TextStyle(color: Colors.white, fontSize: 35.0))),
              ),
            ]),
          )
        ],
      ),
    ));
  }

  _encabezadoApp() {
    return SliverAppBar(
      elevation: 2.0,
      // backgroundColor: Colors.teal[600],
      expandedHeight: 60.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        //background: Pila_Timpo_Clima(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.battery_std,
              color: Colors.white,
              size: 30.0,
            ),
            Icon(
              Icons.cloud_circle,
              color: Colors.white,
              size: 30.0,
            ),
            Icon(
              Icons.flash_on,
              color: Colors.white,
              size: 30.0,
            ),
          ],
        ),
        centerTitle: true,
      ),
    );
  }

  _elementos(Widget widget) {
    return Container(
      height: 200.0, child: widget,
      //color: Colors.teal[600]
    );
  }
}
