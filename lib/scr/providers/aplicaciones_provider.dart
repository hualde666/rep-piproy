import 'package:device_apps/device_apps.dart';

import 'package:flutter/material.dart';
import 'package:piproy/scr/providers/db_provider.dart';

class AplicacionesProvider with ChangeNotifier {
  static final AplicacionesProvider _aplicacionesProvider =
      AplicacionesProvider._internal();
  factory AplicacionesProvider() {
    return _aplicacionesProvider;
  }

  bool _cargando = true;
  String _tipoSeleccion = 'todas';
  List<Application> _listaApp;
  List<Application> _listaSeleccion;
  List<String> apitipos = [
    '+',
    'todas',

    // ApiTipos(Icons.headphones, 'audio'),
    // ApiTipos(Icons.video_camera_back, 'video'),
    // ApiTipos(Icons.paragliding_outlined, 'play'),
    // ApiTipos(Icons.ac_unit, 'undifined'),
  ];

  agregarApiTipos(String tipo) {
    // _tipoSeleccion = tipo;
    apitipos.add(tipo);
    categoryApi[tipo] = [];

    notifyListeners();
  }

  Map<String, List<Application>> categoryApi = {};

  bool get cargando => this._cargando;
  get tipoSeleccion => this._tipoSeleccion;

  set tipoSeleccion(String valor) {
    this._tipoSeleccion = valor;

    notifyListeners();
  }

  AplicacionesProvider._internal() {
    apitipos.forEach((item) {
      this.categoryApi[item] = [];
    });
    getListaApp();
    this._cargando = false;
    final lista = DbTiposAplicaciones.db.getAllRegistros();
    if (lista != null) {
      //for(var i=0; i < lista.le ){}

    }
  }

  get listaApp {
    return this._listaApp;
  }

  get listaSeleccion {
    return this._listaSeleccion;
  }

  modiApiListaPorTipo(Application api) {
    if (!this.categoryApi[_tipoSeleccion].contains(api)) {
      this.categoryApi[_tipoSeleccion].add(api);
    } else {
      this.categoryApi[_tipoSeleccion].remove(api);
    }

    notifyListeners();
  }

  eliminar(Application api) {
    this.categoryApi[_tipoSeleccion].remove(api);
    notifyListeners();
  }

  obtenerListaSeleccion(String tipo) async {
    String tipo = this._tipoSeleccion;

    return this.categoryApi[tipo];
    // _listaSeleccion = categoryApi[tipo];
  }

  getListaApp() async {
    //List<Application> resp = [];

    final resp = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: true,
        onlyAppsWithLaunchIntent: true);

    resp.sort((a, b) {
      return a.appName.toLowerCase().compareTo(b.appName.toLowerCase());
    });

// genero lista por categorias

    this.categoryApi['todas'].addAll(resp);
  }

  cargarCategorias() async {
    final db_categorias = await DbTiposAplicaciones.db.getAllRegistros();
  }
}
