import 'package:device_apps/device_apps.dart';

import 'package:flutter/material.dart';
import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/models/api_tipos.dart';

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
  ];

  AplicacionesProvider._internal() {
    apitipos.forEach((item) {
      this.categoryApi[item] = [];
    });
    getListaApp();

    // cargarCategorias();
  }
  agregarApiTipos(String tipo) {
    apitipos.add(tipo);
    categoryApi[tipo] = [];
    // _tipoSeleccion = tipo;
    apitipos.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });

    notifyListeners();
  }

  Map<String, List<Application>> categoryApi = {};

  bool get cargando => this._cargando;
  get tipoSeleccion => this._tipoSeleccion;

  set tipoSeleccion(String valor) {
    this._tipoSeleccion = valor;

    notifyListeners();
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
      categoryApi[_tipoSeleccion].sort((a, b) {
        return a.appName.toLowerCase().compareTo(b.appName.toLowerCase());
      });
    } else {
      this.categoryApi[_tipoSeleccion].remove(api);
    }

    notifyListeners();
  }

  eliminar(Application api) {
    this.categoryApi[_tipoSeleccion].remove(api);
    notifyListeners();
  }

  obtenerListaSeleccion() async {
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

  eliminarTipos(String tipo) {
    apitipos.removeWhere((element) => element == tipo);
    categoryApi.remove(tipo = tipo);
    notifyListeners();
  }

  cargarCategorias() async {
    // obtengo lista de api por categorias
    final resp = await DbTiposAplicaciones.db.getAllRegistros();
    print(resp);
    if (this._cargando) {
      this._cargando = false;

      if (resp.isNotEmpty) {
        final resp2 = resp.map((s) => ApiTipos.fromJson(s)).toList();
        for (var i = 0; i < resp2.length; i++) {
          if (!apitipos.contains(resp2[i].tipo)) {
            apitipos.add(resp2[i].tipo);
            categoryApi[resp2[i].tipo] = [];
          }

          ////// encontrar Api con nombreApi
          ///
          final String nombreApi = resp2[i].nombreApi;
          if (nombreApi != "") {
            final Application api = this
                .categoryApi['todas']
                .firstWhere((element) => element.appName == nombreApi);
            if (api != null) {
              categoryApi[resp2[i].tipo].add(api);
            }
          }
        }

        // ordenor tipos de categoria alfabeticamente
        apitipos.sort((a, b) {
          return a.toLowerCase().compareTo(b.toLowerCase());
        });
        // ordenar  alfabeticamente todas las api por categoria
        for (var i = 0; i < apitipos.length; i++) {
          if (apitipos[i] != '+' && apitipos[i] != 'todas') {
            if (categoryApi[apitipos[i]].isNotEmpty) {
              categoryApi[apitipos[i]].sort((a, b) {
                return a.appName
                    .toLowerCase()
                    .compareTo(b.appName.toLowerCase());
              });
            }
          }
        }
        this._tipoSeleccion = apitipos[1];
      }
    }
    return categoryApi[this._tipoSeleccion];
  }
}
