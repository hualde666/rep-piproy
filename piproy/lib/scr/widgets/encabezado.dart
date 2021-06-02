import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/encabezado_icon.dart';

encabezadoApp(String titulo) {
  return SliverAppBar(
    elevation: 2.0,
    // backgroundColor: Colors.teal[600],
    expandedHeight: 150.0,
    floating: false,
    pinned: true,
    title: Center(child: Text(titulo)),
    flexibleSpace: encabezadoIcon(),
  );
}
