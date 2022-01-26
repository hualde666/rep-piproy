import 'package:flutter/material.dart';
import 'package:piproy/channel/channel_android.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EstadoProvider with ChangeNotifier {
  static final EstadoProvider _estadosProvider = EstadoProvider._internal();

  factory EstadoProvider() {
    return _estadosProvider;
  }
  EstadoProvider._internal() {
    cargarPrefPaleta();
    actulizarDatos();
    return;
  }
  AndroidChannel _androidChannel = AndroidChannel();
  Color _bateriaColor = Colors.green[900];
  Color _colorWifi = Colors.red[900];
  //**************************** Actividad dispositivos************ */
  int _nivelBateria = 100;
  bool _cargandoBateria = false;
  bool _conexionWifi = false;
  bool _conexionDatos = false;
  bool _conexionGps = false;
  bool _linterna = false;
  //*************************** Flag de iconos horzontales activos */
  bool _iGoogle = true;
  bool _iContactos = true;
  bool _iAplicaciones = false;
  bool _iTelefono = false;
  bool _iBateria = false;
  bool _iWifi = false;
  bool _iLinea = false;
  bool _iGps = false;
  bool _iLinterna = false;
  bool _iReloj = false;
  bool _iMensaje = false;
  bool _menuHorizontal = false;
  //*************************** Opcines del detalle menu principal*/
  set iGoogle(bool estatus) {
    this._iGoogle = estatus;
    notifyListeners();
  }

  get iGoogle {
    return this._iGoogle;
  }

  set iContactos(bool estatus) {
    this._iContactos = estatus;
    notifyListeners();
  }

  get iContactos {
    return this._iContactos;
  }

  set iAplicaciones(bool estatus) {
    this._iAplicaciones = estatus;
    notifyListeners();
  }

  get iAplicaciones {
    return this._iAplicaciones;
  }

  //*************************** Color de la aplicacion ********** */
  String _paleta = "1";

  get paleta {
    return this._paleta;
  }

  set paleta(String nuevaPaleta) {
    this._paleta = nuevaPaleta;
    notifyListeners();
  }

  //************************** set y get  de iconos horizontales */
  set iTelefono(bool estatus) {
    this._iTelefono = estatus;
    if (estatus = true) {
      this._menuHorizontal = true;
    } else {
      onoffMenuHorizontal();
    }
    notifyListeners();
  }

  set iBateria(bool estatus) {
    this._iBateria = estatus;
    if (estatus = true) {
      this._menuHorizontal = true;
    } else {
      onoffMenuHorizontal();
    }
    notifyListeners();
  }

  set iWifi(bool estatus) {
    this._iWifi = estatus;
    if (estatus = true) {
      this._menuHorizontal = true;
    } else {
      onoffMenuHorizontal();
    }
    notifyListeners();
  }

  set iLinea(bool estatus) {
    this._iLinea = estatus;
    if (estatus = true) {
      this._menuHorizontal = true;
    } else {
      onoffMenuHorizontal();
    }
    notifyListeners();
  }

  set iGps(bool estatus) {
    this._iGps = estatus;
    if (estatus = true) {
      this._menuHorizontal = true;
    } else {
      onoffMenuHorizontal();
    }
    notifyListeners();
  }

  set iLinterna(bool estatus) {
    this._iLinterna = estatus;
    if (estatus = true) {
      this._menuHorizontal = true;
    } else {
      onoffMenuHorizontal();
    }
    notifyListeners();
  }

  set iReloj(bool estatus) {
    this._iReloj = estatus;
    if (estatus = true) {
      this._menuHorizontal = true;
    } else {
      onoffMenuHorizontal();
    }

    notifyListeners();
  }

  set iMensaje(bool estatus) {
    this._iMensaje = estatus;
    if (estatus = true) {
      this._menuHorizontal = true;
    } else {
      onoffMenuHorizontal();
    }

    notifyListeners();
  }

  onoffMenuHorizontal() {
    if (!_iBateria &&
        !_iGps &&
        !_iLinea &&
        !_iLinterna &&
        !_iMensaje &&
        !_iReloj &&
        !_iWifi) {
      this._menuHorizontal = false;
    }
  }

  get iTelefono {
    return this._iTelefono;
  }

  get iBateria {
    return this._iBateria;
  }

  get iWifi {
    return this._iWifi;
  }

  get iLinea {
    return this._iLinea;
  }

  get iGps {
    return this._iGps;
  }

  get iLinterna {
    return this._iLinterna;
  }

  get iReloj {
    return this._iReloj;
  }

  get iMensaje {
    return this._iMensaje;
  }

  get menuHorizontal {
    return this._menuHorizontal;
  }

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

  cargarPrefPaleta() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _paleta = prefs.getString('paleta');
    if (_paleta == null) {
      _paleta = "1";
    }
  }

  actulizarDatos() async {
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
