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

  actulizarDatos() async {
    AndroidChannel _androidChannel = AndroidChannel();
    final bateria = await _androidChannel.nivelBateria();
    final _cargando = await _androidChannel.cargandoBateria();
    final _wifi = await _androidChannel.conectadoWifi();
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
      if (_wifi) {
        _colorWifi = Colors.green[900];
      } else {
        _colorWifi = Colors.red[900];
      }
      _conexionWifi = _wifi;
      notifyListeners();
    }
  }
}
