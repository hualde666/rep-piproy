import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferencias extends ChangeNotifier {
  static final Preferencias _instancia = new Preferencias._internal();
  factory Preferencias() {
    return _instancia;
  }
  Preferencias._internal() {
    //init();
  }

  SharedPreferences _pref;
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
  String _paleta = "1";

  init() async {
    //WidgetsFlutterBinding.ensureInitialized();
    this._pref = await SharedPreferences.getInstance();
    _paleta = _pref.getString('paleta') ?? '1';
    _iAplicaciones = _pref.getBool('aplicaciones') ?? false;
    _iGoogle = _pref.getBool('google') ?? false;
    _iContactos = _pref.getBool('contactos') ?? false;
    _iBateria = _pref.getBool('bateria') ?? false;
    _iGps = _pref.getBool('gps') ?? false;
    _iLinea = _pref.getBool('linea') ?? false;
    _iLinterna = _pref.getBool('linterna') ?? false;
    _iMensaje = _pref.getBool('mensaje') ?? false;
    _iReloj = _pref.getBool('reloj') ?? false;
    _iTelefono = _pref.getBool('telefono') ?? false;
    _iWifi = _pref.getBool('wifi') ?? false;

    if (!_iBateria &&
        !_iGps &&
        !_iLinea &&
        !_iLinterna &&
        !_iMensaje &&
        !_iReloj &&
        !_iWifi) {
      this._menuHorizontal = false;
    } else {
      this._menuHorizontal = true;
    }
  }

  String get paleta {
    return this._paleta;
  }

  set paleta(String nuevaPaleta) {
    _paleta = nuevaPaleta;

    _pref.setString('paleta', nuevaPaleta);
    notifyListeners();
  }

  set iGoogle(bool estatus) {
    this._iGoogle = estatus;
    _pref.setBool('google', estatus);

    notifyListeners();
  }

  get iGoogle {
    return this._iGoogle;
  }

  set iContactos(bool estatus) {
    this._iContactos = estatus;
    _pref.setBool('contactos', estatus);

    notifyListeners();
  }

  get iContactos {
    return this._iContactos;
  }

  set iAplicaciones(bool estatus) {
    this._iAplicaciones = estatus;
    _pref.setBool('aplicaciones', estatus);

    notifyListeners();
  }

  get iAplicaciones {
    return this._iAplicaciones;
  }

  set iTelefono(bool estatus) {
    this._iTelefono = estatus;
    _pref.setBool('telefono', estatus);

    onoffMenuHorizontal(estatus);

    notifyListeners();
  }

  set iBateria(bool estatus) {
    this._iBateria = estatus;
    _pref.setBool('bateria', estatus);

    onoffMenuHorizontal(estatus);

    notifyListeners();
  }

  set iWifi(bool estatus) {
    this._iWifi = estatus;
    _pref.setBool('wifi', estatus);

    onoffMenuHorizontal(estatus);

    notifyListeners();
  }

  set iLinea(bool estatus) {
    this._iLinea = estatus;
    _pref.setBool('linea', estatus);

    onoffMenuHorizontal(estatus);

    notifyListeners();
  }

  set iGps(bool estatus) {
    this._iGps = estatus;
    _pref.setBool('gps', estatus);

    onoffMenuHorizontal(estatus);

    notifyListeners();
  }

  set iLinterna(bool estatus) {
    this._iLinterna = estatus;
    _pref.setBool('linterna', estatus);

    onoffMenuHorizontal(estatus);

    notifyListeners();
  }

  set iReloj(bool estatus) {
    this._iReloj = estatus;
    _pref.setBool('reloj', estatus);

    onoffMenuHorizontal(estatus);

    notifyListeners();
  }

  set iMensaje(bool estatus) {
    this._iMensaje = estatus;
    _pref.setBool('mensaje', estatus);

    onoffMenuHorizontal(estatus);

    notifyListeners();
  }

  onoffMenuHorizontal(bool estatus) {
    if (estatus = true) {
      this._menuHorizontal = true;
    } else {
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
}
