import 'package:device_apps/device_apps.dart';

class AplicacionesProvider {
  static final AplicacionesProvider _aplicacionesProvider =
      AplicacionesProvider._internal();

  factory AplicacionesProvider() {
    return _aplicacionesProvider;
  }
  AplicacionesProvider._internal() {
    _listaApp = getListaApp();
  }
  Future<List<Application>> _listaApp;
  get listaApp {
    return _listaApp;
  }

// elimina id de la lista de id conctactos

  obtenerlistaApp() {
    return _listaApp;
  }

  Future<List<Application>> getListaApp() async {
    // List<Contact> _lista = [];
    final resp = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: true,
        onlyAppsWithLaunchIntent: true);
    resp.sort((a, b) {
      return a.appName.toLowerCase().compareTo(b.appName.toLowerCase());
    });
    return resp;
  }
}
