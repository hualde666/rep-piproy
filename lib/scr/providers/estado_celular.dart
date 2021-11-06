import 'package:flutter/material.dart';
import 'package:piproy/channel/channel_android.dart';

class EstadoProvider with ChangeNotifier {
  static final EstadoProvider _estadosProvider = EstadoProvider._internal();

  factory EstadoProvider() {
    return _estadosProvider;
  }
  EstadoProvider._internal() {
    actulizarDatos();
    return;
  }
  Color _bateriaColor = Colors.green[900];
  Color _colorWifi = Colors.red[900];
  int _nivelBateria = 100;
  bool _cargandoBateria = false;
  bool _conexionWifi = false;
  bool _conexionDatos = false;
  bool _conexionGps = false;
  bool _linterna = false;
  get linterna {
    return this._linterna;
  }

  set swichLinterna(bool onoff) {
    this._linterna = onoff;
    notifyListeners();
  }

  set swichWifi(bool onoff) {
    this._conexionWifi = onoff;
    notifyListeners();
  }

  get nivelBateria {
    return this._nivelBateria;
  }

  get bateriaColor {
    return this._bateriaColor;
  }

  get wifiColor {
    return this._colorWifi;
  }

  get cargandoBateria {
    return this._cargandoBateria;
  }

  get conexionWifi {
    return this._conexionWifi;
  }

  get conexionDatos {
    return this._conexionDatos;
  }

  get conexionGps {
    return this._conexionGps;
  }

  actulizarDatos() async {
    AndroidChannel _androidChannel = AndroidChannel();
    final bateria = await _androidChannel.nivelBateria();
    final _cargando = await _androidChannel.cargandoBateria();
    final _wifi = await _androidChannel.conectadoWifi();
    final _gps = await _androidChannel.conectadoGps();
    final _datos = await _androidChannel.conectadoDatos();
    if (bateria != _nivelBateria) {
      _nivelBateria = bateria;
      if (bateria > 50) {
        _bateriaColor = Colors.green[900];
      } else {
        if (bateria > 20) {
          _bateriaColor = Colors.yellow[900];
        } else {
          _bateriaColor = Colors.red[900];
        }
      }
      notifyListeners();
    }
    if (_cargandoBateria != _cargando) {
      _cargandoBateria = _cargando;
      notifyListeners();
    }
    if (_conexionWifi != _wifi) {
      _conexionWifi = _wifi;
      notifyListeners();
    }
    if (_conexionGps != _gps) {
      _conexionGps = _gps;
      notifyListeners();
    }
    if (_conexionDatos != _datos) {
      _conexionDatos = _datos;
      notifyListeners();
    }
  }
}
