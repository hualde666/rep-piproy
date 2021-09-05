import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/encabezado_icon.dart';

encabezadoApp(BuildContext context, String titulo) {
  return AppBar(
    elevation: 6.0,
    flexibleSpace: encabezadoIcon(context),
  );
}
