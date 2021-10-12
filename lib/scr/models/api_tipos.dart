import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class ApiTipos {
  final int id;
  final String tipo;
  final String nombreApi;
  ApiTipos(this.id, this.tipo, this.nombreApi);

  Map<String, dynamic> toJson() =>
      {"id": id, "tipo": tipo, "nombreApi": nombreApi};
}
