import 'dart:async';
import 'package:flutter/services.dart';

class AndroidChannel {
  static final AndroidChannel _canal = AndroidChannel._internal();

  factory AndroidChannel() {
    return _canal;
  }
  MethodChannel _methodChannel;

  AndroidChannel._internal() {
    _methodChannel = MethodChannel("app.piproy.channel/hualdemirene@gmail.com");
  }

  Future<void> pedirVersion() async {
    try {
      final result = await _methodChannel.invokeMethod("version");
      print('Respuesta : $result');
    } catch (e) {
      print('ERROR: $e');
    }
  }

  // Future<void> listaApis() async {
  //   print('Entre a listaApis');
  //   try {
  //     final result = await _methodChannel.invokeMethod("aplicaciones");
  //     print('Respuesta : $result');
  //     return result;
  //   } catch (e) {
  //     print('ERROR: $e');
  //   }
  // }

  Future<int> nivelBateria() async {
    try {
      final result = await _methodChannel.invokeMethod("bateria");

      return result;
    } catch (e) {
      print('ERROR: $e');
      return e;
    }
  }

  Future<bool> cargandoBateria() async {
    try {
      final result = await _methodChannel.invokeMethod("cargando");

      return result;
    } catch (e) {
      print('ERROR: $e');
      return e;
    }
  }

  Future<bool> conectadoWifi() async {
    try {
      final result = await _methodChannel.invokeMethod("wifi");

      return result;
    } catch (e) {
      print('ERROR: $e');
      return false;
    }
  }

  Future<bool> swichWifi(bool on) async {
    try {
      final result = await _methodChannel.invokeMethod("onoffwifi");

      return result;
    } catch (e) {
      print('ERROR: $e');
      return false;
    }
  }

  Future<bool> swichGps(bool on) async {
    try {
      final result = await _methodChannel.invokeMethod("onoffgps");

      return result;
    } catch (e) {
      print('ERROR: $e');
      return false;
    }
  }

  Future<bool> conectadoGps() async {
    try {
      final result = await _methodChannel.invokeMethod("gps");

      return result;
    } catch (e) {
      print('ERROR: $e');
      return false;
    }
  }

  Future<bool> conectadoDatos() async {
    try {
      final result = await _methodChannel.invokeMethod("datos");

      return result;
    } catch (e) {
      print('ERROR: $e');
      return false;
    }
  }

  Future<bool> onoffLinterna(bool prender) async {
    try {
      var parametros = {'prender': prender};
      final result = await _methodChannel.invokeMethod("linterna", parametros);

      return result;
    } catch (e) {
      print('ERROR: $e');
      return false;
    }
  }

  Future<void> mandarSms(String phone, String mensaje) async {
    try {
      var parametros = {'phone': phone, 'mensaje': mensaje};

      await _methodChannel.invokeMethod("mandarsms", parametros);
    } catch (e) {
      return e;
    }
  }
}
