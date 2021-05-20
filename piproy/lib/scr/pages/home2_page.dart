import 'package:flutter/material.dart';
import 'package:piproy/widgets/botonrojo.dart';
import 'package:piproy/widgets/pila_tiempo_clima.dart';

class Home2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(200.0), // here the desired height
      //   child: _encabezadoApp(),
      // ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: _detalle(),
        ),
      ),
      bottomNavigationBar: _bottonBarNavegador(context),
    );
  }

  List<Widget> _detalle() {
    return <Widget>[
      _encabezadoApp(),
      SliverList(
        delegate: SliverChildListDelegate([
          _encabezadoIcon(),
          _elementos(Pila_Timpo_Clima()),
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
    ];
  }

  _encabezadoApp() {
    return SliverAppBar(
      elevation: 2.0,
      // backgroundColor: Colors.teal[600],
      expandedHeight: 50.0,
      floating: false,
      pinned: true,
      title: Center(child: Text('Proyecto pi')),
      // actions: [_encabezadoIcon()],
      // flexibleSpace: FlexibleSpaceBar(
      //   //title: _encabezadoIcon(),
      //   //background: Pila_Timpo_Clima(),
      //   accion: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       Icon(
      //         Icons.battery_std,
      //         color: Colors.white,
      //         size: 30.0,
      //       ),
      //       Icon(
      //         Icons.cloud_circle,
      //         color: Colors.white,
      //         size: 30.0,
      //       ),
      //       Icon(
      //         Icons.flash_on,
      //         color: Colors.white,
      //         size: 30.0,
      //       ),
      //     ],
      //   ),
      //   // centerTitle: true,
      // ),
    );
  }

  Widget _elementos(Widget widget) {
    return Container(
      height: 200.0,
      child: widget,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.green)),
    );
  }

  Widget _bottonBarNavegador(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(),
        child: BottomNavigationBar(
          // backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
          // selectedItemColor: Colors.pink,
          // unselectedItemColor: Color.fromRGBO(166, 117, 152, 1.0),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 30.0), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.bubble_chart, size: 30.0), label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.supervised_user_circle,
                  size: 30.0,
                ),
                label: ''),
          ],
        ));
  }

  Widget _encabezadoIcon() {
    final List<Widget> _listaWidget = [
      _conteinerIcon(Icon(Icons.ac_unit, size: 40.0, color: Colors.green)),
      _conteinerIcon(Icon(Icons.chat, size: 40.0, color: Colors.green)),
      _conteinerIcon(Icon(Icons.mail, size: 40.0, color: Colors.green)),
      _conteinerIcon(
          Icon(Icons.access_alarms, size: 40.0, color: Colors.green)),
      _conteinerIcon(Icon(Icons.chat, size: 40.0, color: Colors.green)),
      _conteinerIcon(Icon(Icons.add_call, size: 40.0, color: Colors.green)),
    ];
    return Container(
      height: 70.0,
      width: 70.0,
      margin: EdgeInsets.all(10.0),
      child: ListView.builder(
          controller: PageController(viewportFraction: 0.2),
          scrollDirection: Axis.horizontal,
          itemCount: _listaWidget.length,
          itemBuilder: (context, i) => _listaWidget[i]),
    );
  }

  Widget _conteinerIcon(Icon icon) {
    return Container(
      width: 70.0,
      height: 70.0,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.green)),
      margin: EdgeInsets.only(left: 15.0),
      child: icon, // Icon(icon, size: 40.0, color: Colors.green),
    );
  }
}
