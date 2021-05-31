import 'package:flutter/material.dart';

encabezadoApp() {
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

    //     ],
    //   ),
    //   // centerTitle: true,
    // ),
  );
}
