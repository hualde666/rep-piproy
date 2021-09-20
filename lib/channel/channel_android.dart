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

  Future<void> nivelBateria() async {
    try {
      final result = await _methodChannel.invokeMethod("bateria");
      print('Nivel de Bateria: $result');
    } catch (e) {
      print('ERROR: $e');
    }
  }

  Future<void> mandarSms(String phone, String mensaje) async {
    String _result = "mandado";
    try {
      var parametros = {'phone': phone, 'mensaje': mensaje};

      final _result =
          await _methodChannel.invokeMethod("mandarsms", parametros);
    } catch (e) {
      _result = "no mandado";
      return e;
    }
  }
}
