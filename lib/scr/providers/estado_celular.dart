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
  int _nivelBateria = 100;
  bool _cargandoBateria = false;

  get nivelBateria {
    return this._nivelBateria;
  }

  get bateriaColor {
    return this._bateriaColor;
  }

  get cargandoBateria {
    return this._cargandoBateria;
  }

  actulizarDatos() async {
    AndroidChannel _androidChannel = AndroidChannel();
    final bateria = await _androidChannel.nivelBateria();
    final _cargando = await _androidChannel.cargandoBateria();
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
    } else {
      if (_cargandoBateria != _cargando) {
        _cargandoBateria = _cargando;
        notifyListeners();
      }
    }
  }
}
