import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/encabezado_icon.dart';

encabezadoApp(String titulo) {
  return SliverAppBar(
    elevation: 5.0,
    // backgroundColor: Colors.teal[600],
    expandedHeight: 150.0,
    floating: true,
    pinned: true,
    title: Column(
      children: [
        Center(child: Text(titulo)),
        SizedBox(
          height: 5.0,
        ),
        Divider(
          color: Colors.green,
          height: 1.0,
        ),
      ],
    ),
    flexibleSpace: encabezadoIcon(),
  );
}
