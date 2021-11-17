import 'package:contacts_service/contacts_service.dart';
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
  String _tipoSeleccion = 'Todas';
  List<Application> _listaApp;
  List<Application> _listaSeleccion;
  List<String> _apigrupos = [
    'Todas',
  ];
  Map<String, List<Application>> categoryApi = {};
  List<String> listaMenu = [];
  Map<String, List<String>> categoryContact = {};

  List<String> _contactgrupos = [
    'Todos',
  ];
  AplicacionesProvider._internal() {
    this.categoryApi['Todas'] = [];
    this.categoryContact['Todos'] = [];
  }
  agregarApiGrupo(String grupo) {
    _apigrupos.add(grupo);
    categoryApi[grupo] = [];

    // _tipoSeleccion = tipo;
    _apigrupos.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });

    notifyListeners();
  }

  agregarContactGrupo(String grupo) {
    _contactgrupos.add(grupo);
    categoryContact[grupo] = [];

    // _tipoSeleccion = tipo;
    _contactgrupos.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });

    notifyListeners();
  }

  bool get cargando => this._cargando;
  get tipoSeleccion => this._tipoSeleccion;

  List<String> get apigrupos {
    final lista = _apigrupos;
    //*** devuelvo todos menos MPC */
    lista.remove('MPC');
    return lista;
  }

  List<String> get contactgrupos {
    final lista = _contactgrupos;
    //*** devuelvo todos menos MPC */
    lista.remove('MPC');
    return lista;
  }

  List<String> get apitiposMenu {
    final List<String> lista = [];
    lista.addAll(_apigrupos.where((element) => element == 'MPC'));
    lista.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });
    return lista;
  }

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

  agregarMenu(String tipo) {
    listaMenu.add(tipo);
    listaMenu.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });
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

  obtenerListaContactos() async {
    String tipo = this._tipoSeleccion;

    return this.categoryContact[tipo];
    // _listaSeleccion = categoryApi[tipo];
  }

  agregarContacto(String grupo, Contact contacto) {
    categoryContact[grupo].add(contacto.displayName);
    notifyListeners();
  }

  eliminarContacto(String grupo, String nombre) {
    categoryContact[grupo].remove(nombre);
    notifyListeners();
  }

  // getListaApp() async {
  //   // AndroidChannel _androidChannel = AndroidChannel();
  //   //  final lista = await _androidChannel.listaApis();
  //   final resp = await DeviceApps.getInstalledApplications(
  //       includeAppIcons: true,
  //       includeSystemApps: true,
  //       onlyAppsWithLaunchIntent: true);
  //   if (resp.isNotEmpty) {
  //     categoryApi['Todas'].addAll(resp);
  //   }

  //   print('Salgo de getListApi+${categoryApi['Todas']}');
  // }

  eliminarTipos(String tipo) {
    _apigrupos.removeWhere((element) => element == tipo);
    categoryApi.remove(tipo = tipo);
    notifyListeners();
  }

  eliminarContactTipos(String grupo) {
    _contactgrupos.removeWhere((element) => element == grupo);
    categoryContact.remove(grupo = grupo);
    notifyListeners();
  }

  eliminarTipoMP(String tipo) {
    listaMenu.remove(tipo);
    notifyListeners();
  }

  Future<List<ApiTipos>> cargarCategorias() async {
    // obtengo lista de api por categorias

    if (this._cargando) {
      //******* obtengo Todas las app del celular */
      final resp1 = await DeviceApps.getInstalledApplications(
          includeAppIcons: true,
          includeSystemApps: true,
          onlyAppsWithLaunchIntent: true);
      if (resp1.isNotEmpty && categoryApi['Todas'].isEmpty) {
        categoryApi['Todas'].addAll(resp1);
      }

      //*******   obtener organizacion de apps y contactos */
      final resp = await DbTiposAplicaciones.db.getAllRegistros();
      print(
          '*******************************************************************************');
      print('lista de BD:');
      print(
          '*******************************************************************************');
      print(resp);
      print(
          '*******************************************************************************');

      if (resp.isNotEmpty) {
        final resp2 = resp.map((s) => ApiTipos.fromJson(s)).toList();
        this._cargando = false;
        return resp2;
      }
    }
    return [];
  }

  ordenarListasMenu(List<ApiTipos> resp2) {
    for (var i = 0; i < resp2.length; i++) {
      switch (resp2[i].grupo) {
        case 'MPC':
          {
            // grupo app
            listaMenu.add('MPC' + resp2[i].nombre);
            break;
          }
        case 'MPA':
          {
            // app
            listaMenu.add('MPA' + resp2[i].nombre);
            break;
          }
        case 'MPG':
          {
            //grupo contacto
            listaMenu.add('MPG' + resp2[i].nombre);
            break;
          }
        case 'MPF':
          {
            // contacto
            listaMenu.add('MPF' + resp2[i].nombre);
            break;
          }
        default:
          {
            // grupo de api
            if (resp2[i].tipo == "1") {
              if (!_apigrupos.contains(resp2[i].grupo)) {
                _apigrupos.add(resp2[i].grupo);
                categoryApi[resp2[i].grupo] = [];
              }

              final String nombreApi = resp2[i].nombre;
              if (nombreApi != "") {
                final Application api = this
                    .categoryApi['Todas']
                    .firstWhere((element) => element.appName == nombreApi);
                if (api != null) {
                  categoryApi[resp2[i].grupo].add(api);
                }
              }
            }

            /// grupo de contactos
            if (resp2[i].tipo == "2") {
              if (!_contactgrupos.contains(resp2[i].grupo)) {
                _contactgrupos.add(resp2[i].grupo);
                categoryContact[resp2[i].grupo] = [];
              }

              final String nombre = resp2[i].nombre;
              if (nombre != "") {
                categoryContact[resp2[i].grupo].add(nombre);
              }
            }

            break;
          }
      }
    }
    //ordenar el menu alfabeticament
    //

    listaMenu.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });
    // ordenor tipos de categoria alfabeticamente
    //
    _apigrupos.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });
    _contactgrupos.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });
    // ordenar  alfabeticamente Todas las api por categoria
    //
    for (var i = 0; i < _apigrupos.length; i++) {
      if (categoryApi[_apigrupos[i]].isNotEmpty) {
        categoryApi[_apigrupos[i]].sort((a, b) {
          return a.appName.toLowerCase().compareTo(b.appName.toLowerCase());
        });
      }
    }
  }
}
