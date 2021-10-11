import 'package:flutter/material.dart';

import 'package:device_apps/device_apps.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

class ApiListaPage extends StatefulWidget {
  @override
  State<ApiListaPage> createState() => _ApiListaPageState();
}

class _ApiListaPageState extends State<ApiListaPage> {
  // Future<List<Application>> getListaApis() async {
  //   return aplicacionesProvider.listaApp;
  // }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<AplicacionesProvider>(context);
    List<Application> listaApi = apiProvider.categoryApi['todas'];

    return Scaffold(
        appBar: headerApp(context, 'Aplicaciones', Text(''), 0.0),
        body: ListView.builder(
            itemCount: listaApi.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (listaApi[index].appName != "") {
                    listaApi[index].openApp();
                    print(listaApi[index].appName);
                  }
                },
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    children: [
                      Divider(
                        height: 10,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Image.memory(
                        (listaApi[index] as ApplicationWithIcon).icon,
                        width: 100,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        listaApi[index].appName,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
