import 'package:contacts_service/contacts_service.dart';
import 'package:device_apps/device_apps.dart';

import 'package:flutter/material.dart';
import 'package:piproy/scr/models/contactos_modelo.dart';
//import 'package:piproy/scr/pages/contact_seleccion.dart';
import 'package:piproy/scr/providers/contactos_provider.dart';

import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/models/api_tipos.dart';
import 'package:provider/provider.dart';

class AplicacionesProvider with ChangeNotifier {
  static final AplicacionesProvider _aplicacionesProvider =
      AplicacionesProvider._internal();
  factory AplicacionesProvider() {
    return _aplicacionesProvider;
  }

  bool _cargando = true;
  String _tipoSeleccion = '';

  List<Application> _listaApp;
  List<Application> _listaSeleccion;
  List<String> _apigrupos = [
    'Todas',
  ];
  Map<String, List<Application>> categoryApi = {};
  List<String> listaMenu = [];
  Map<String, List<ContactoDatos>> categoryContact = {};

  List<String> _contactgrupos = [
    'Todos',
  ];
  AplicacionesProvider._internal() {
    this.categoryApi['Todas'] = [];
    this.categoryContact['Todos'] = [];
    this.categoryContact['Emergencia'] = [];
    // cargarCategorias();
  }
//***********************************Widgets del menu principal */

  agregarApiGrupo(String grupo) {
    _apigrupos.add(grupo);
    categoryApi[grupo] = [];

    // _tipoSeleccion = tipo;
    _apigrupos.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });

    notifyListeners();
  }

  bool get cargando => this._cargando;
  get tipoSeleccion => this._tipoSeleccion;

  List<String> get apigrupos {
    final lista = _apigrupos;
    //*** devuelvo todos menos MPD */
    lista.remove('MPD');
    return lista;
  }

  List<String> get contactgrupos {
    final lista = _contactgrupos;
    //*** devuelvo todos menos MPD */
    lista.remove('MPD');
    return lista;
  }

  List<String> get apitiposMenu {
    final List<String> lista = [];
    lista.addAll(_apigrupos.where((element) => element == 'MPD'));
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

  obtenerListaSeleccion() async {
    String tipo = this._tipoSeleccion;

    return this.categoryApi[tipo];
    // _listaSeleccion = categoryApi[tipo];
  }

//*************************************** CONTACTOS */
//************************************************* */
  obtenerListaContactos() {
    String tipo = this._tipoSeleccion;

    return this.categoryContact[tipo];
    // _listaSeleccion = categoryApi[tipo];
  }

  //******************************* */
  // agrega grupo contacto
  agregarGrupoContact(String grupo) {
    _contactgrupos.add(grupo);
    categoryContact[grupo] = [];

    // _tipoSeleccion = tipo;
    _contactgrupos.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });

    notifyListeners();
  }

  //******************************* */
  // agrega grupo contacto
  cambiarGrupoContact(String grupo, String grupoNuevo) {
    _contactgrupos.add(grupoNuevo);
    categoryContact[grupoNuevo] = [];
    categoryContact[grupoNuevo].addAll(categoryContact[grupo]);
    categoryContact.remove(grupo);
    _contactgrupos.remove(grupo);
    _contactgrupos.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });
    // _tipoSeleccion = tipo;

    notifyListeners();
  }

  //******************************* */
  // agrega contacto a grupo
  agregarContacto(String grupo, ContactoDatos contacto) {
    categoryContact[grupo].add(contacto);
    categoryContact[grupo].sort((a, b) {
      return a.nombre.toLowerCase().compareTo(b.nombre.toLowerCase());
    });
    notifyListeners();
  }

  //******************************* */
  // elimina contacto de grupo
  eliminarContacto(String grupo, ContactoDatos contacto) {
    categoryContact[grupo].remove(contacto);

    notifyListeners();
  }

  // modificarContacto(String nombreviejo, String nombrenuevo) {
  //   for (var i = 0; i < _contactgrupos.length; i++) {
  //     String grupo = _contactgrupos[i];

  //     if (categoryContact[grupo].contains(nombreviejo)) {
  //       categoryContact[grupo].remove(nombreviejo);
  //       categoryContact[grupo].add(nombrenuevo);
  //       ordenerGrupoContacto(grupo);
  //     }
  //   }

  //   notifyListeners();
  // }

  ordenerGrupoContacto(String grupo) {
    if (categoryContact[grupo].isNotEmpty) {
      categoryContact[grupo].sort((a, b) {
        return a.nombre.toLowerCase().compareTo(b.nombre.toLowerCase());
      });
    }
  }

  //******************************* */
  // elimina de grupo contacto
  eliminarContactTipos(String grupo) {
    _contactgrupos.removeWhere((element) => element == grupo);
    categoryContact.remove(grupo = grupo);
    notifyListeners();
  }

  //*************************************** APLICACIONES */
  //**************************************************** */

  //******************************* */
  // agrega  y elimina app en grupo
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

  //******************************* */
  // elimina de grupo app
  eliminarTipos(String tipo) {
    _apigrupos.removeWhere((element) => element == tipo);
    categoryApi.remove(tipo = tipo);
    notifyListeners();
  }

  cambiarGrupoApi(String grupo, String grupoNuevo) {
    _apigrupos.add(grupoNuevo);
    categoryApi[grupoNuevo] = [];
    categoryApi[grupoNuevo].addAll(categoryApi[grupo]);
    categoryApi.remove(grupo);
    _apigrupos.remove(grupo);
    _apigrupos.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });
    // _tipoSeleccion = tipo;

    notifyListeners();
  }

  obtenerApi(String nombre) async {
    // Application api;
    if (nombre != '') {
      Application api = await DeviceApps.getApp(nombre, true);
      return api;
    }
  }

  obtenerListaApiGrupo(String grupo) async {
    if (grupo == 'Todas') {
      // ******* obtengo Todas las app del celular */
      if (categoryApi['Todas'].isEmpty) {
        final resp1 = await DeviceApps.getInstalledApplications(
            includeAppIcons: true,
            includeSystemApps: true,
            onlyAppsWithLaunchIntent: true);

        categoryApi['Todas'].addAll(resp1);
      }
    } else {
      if (categoryApi[grupo].isEmpty) {
        //*** obtengo lista de la BD tosas las apps del grupo */
        List<ApiTipos> lista =
            await DbTiposAplicaciones.db.obtenerAppsGrupo(grupo);
        for (var i = 0; i < lista.length; i++) {
          if (lista[i].nombre != '') {
            final api = await DeviceApps.getApp(lista[i].nombre, true);

            if (api != null) {
              if (!categoryApi[grupo].contains(api)) {
                categoryApi[grupo].add(api);
              }
            }
          }
        }
      }
    }

    if (categoryApi[grupo] != null) {
      categoryApi[grupo].sort((a, b) {
        return a.appName.toLowerCase().compareTo(b.appName.toLowerCase());
      });
      return categoryApi[grupo];
    }
  }
//******************** lista de contactos por gupos */

  obtenerListaContactosGrupo(BuildContext context, String grupo) async {
    final contactosProvaide = Provider.of<ContactosProvider>(context);

    if (categoryContact[grupo].isEmpty) {
      //*** obtengo lista de la BD tosas las apps del grupo */
      if (grupo == 'Todos') {
        List<Contact> lista = await contactosProvaide.getcontactos();
        List<ContactoDatos> lista2 = [];
        //categoryContact['Todos'] = [];
        for (var i = 0; i < lista.length; i++) {
          String _nombre = lista[i].displayName;
          String _telefono = "";
          String _whatsapp = "";
          if (lista[i].phones.isNotEmpty) {
            _telefono = lista[i].phones.elementAt(0).value;
            Item item = lista[i].phones.firstWhere(
                (element) => element.value.substring(0, 1) == '+',
                orElse: () => null);
            if (item != null) {
              _whatsapp = item.value;
            }
          }
          final _contacto = new ContactoDatos(
              nombre: _nombre, telefono: _telefono, whatsapptel: _whatsapp);
          // categoryContact['Todos'].add((_contacto));
          lista2.add(_contacto);
        }
        categoryContact['Todos'] = [];
        categoryContact['Todos'].addAll(lista2);
      } else {
        List<ApiTipos> lista =
            await DbTiposAplicaciones.db.obtenerAppsGrupo(grupo);
        if (lista != null) {
          for (var i = 0; i < lista.length; i++) {
            if (lista[i].nombre != '') {
              final contacto =
                  await contactosProvaide.obtenerContacto(lista[i].nombre);

              if (contacto != null) {
                if (!categoryContact[grupo].contains(contacto)) {
                  categoryContact[grupo].add(contacto);
                }
              }
            }
          }
        }
      }
    }

    if (categoryContact[grupo] != null) {
      categoryContact[grupo].sort((a, b) {
        return a.nombre.toLowerCase().compareTo(b.nombre.toLowerCase());
      });
      return categoryContact[grupo];
    }
    notifyListeners();
  }

  //******************************* */
  // agrega elemnto al menu principal
  agregarMenu(String tipo) {
    if (!listaMenu.contains(tipo)) {
      listaMenu.add(tipo);
      listaMenu.sort((a, b) {
        return a.toLowerCase().compareTo(b.toLowerCase());
      });
      notifyListeners();
    }
  }

  //******************************* */
  // elimina de elemento de menu principal

  eliminarTipoMP(String tipo) {
    listaMenu.remove(tipo);
    notifyListeners();
  }

  //******************************* */
  // elimina elemnto al menu principal
  eliminar(Application api) {
    this.categoryApi[_tipoSeleccion].remove(api);
    notifyListeners();
  }

  cargarCategorias() async {
    // obtengo lista de api por categorias

    if (this._cargando) {
      final resp = await DbTiposAplicaciones.db.getAllRegistros();

      if (resp.isNotEmpty) {
        final resp2 = resp.map((s) => ApiTipos.fromJson(s)).toList();
        this._cargando = false;
        ordenarListasMenu(resp2);
      }
    }
    return listaMenu;
  }

  ordenarListasMenu(List<ApiTipos> resp2) async {
    for (var i = 0; i < resp2.length; i++) {
      switch (resp2[i].grupo) {
        case 'MPA':
          {
            //contacto
            listaMenu.add('MPA' + resp2[i].nombre);
            break;
          }
        case 'MPB':
          {
            // app
            listaMenu.add('MPB' + resp2[i].nombre);
            break;
          }
        case 'MPC':
          {
            //grupo contacto
            listaMenu.add('MPC' + resp2[i].nombre);
            break;
          }
        case 'MPD':
          {
            // grupo app
            listaMenu.add('MPD' + resp2[i].nombre);
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
            }

            /// grupo de contactos
            if (resp2[i].tipo == "2") {
              if (!_contactgrupos.contains(resp2[i].grupo)) {
                _contactgrupos.add(resp2[i].grupo);
                categoryContact[resp2[i].grupo] = [];
              }
            }

            break;
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

      //**** ordenar los los grupos de contacto */
      for (var i = 0; i < _contactgrupos.length; i++) {
        String grupo = _contactgrupos[i];
        if (grupo != 'Todos') {
          if (categoryContact[grupo].isNotEmpty) {
            categoryContact[grupo].sort((a, b) {
              return a.nombre.toLowerCase().compareTo(b.nombre.toLowerCase());
            });
          }
        }
      }

      // ordenar  alfabeticamente Todas las api por categoria
      //
      // for (var i = 0; i < _apigrupos.length; i++) {
      //   if (categoryApi[_apigrupos[i]].isNotEmpty) {
      //     categoryApi[_apigrupos[i]].sort((a, b) {
      //       return a.appName.toLowerCase().compareTo(b.appName.toLowerCase());
      //     });
      //   }
      // }
    }
  }
}
