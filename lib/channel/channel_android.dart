import 'dart:async';
import 'package:flutter/services.dart';

class AndroidChannel {
  final MethodChannel _methodChannel =
      MethodChannel("app.piproy.channel/hualdemirene@gmail.com");

  Future<void> pedirVersion() async {
    try {
      final result = await _methodChannel.invokeMethod("version");
      print('Respuesta : $result');
    } catch (e) {
      print('ERROR: $e');
    }
  }

  Future<void> listaApis() async {
    print('Entre a listaApis');
    try {
      final result = await _methodChannel.invokeMethod("aplicaciones");
      print('Respuesta : $result');
      return result;
    } catch (e) {
      print('ERROR: $e');
    }
  }

  Future<int> nivelBateria() async {
    try {
      final result = await _methodChannel.invokeMethod("bateria");

      return result;
    } catch (e) {
      print('ERROR: $e');
      return e;
    }
  }

  // Future<bool> cargandoBateria() async {
  //   try {
  //     final result = await _methodChannel.invokeMethod("cargando");

  //     return result;
  //   } catch (e) {
  //     print('ERROR: $e');
  //     return e;
  //   }
  // }

  Future<void> mandarSms(String phone, String mensaje) async {
    try {
      var parametros = {'phone': phone, 'mensaje': mensaje};

      await _methodChannel.invokeMethod("mandarsms", parametros);
    } catch (e) {
      return e;
    }
  }
}
