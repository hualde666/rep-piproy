import 'package:flutter/material.dart';

import 'package:device_apps/device_apps.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/widgets/header_app.dart';

class ApiListaPage extends StatefulWidget {
  @override
  State<ApiListaPage> createState() => _ApiListaPageState();
}

class _ApiListaPageState extends State<ApiListaPage> {
  final aplicacionesProvider = new AplicacionesProvider();
  List<Application> listaApi;

  Future<List<Application>> getListaApis() async {
    return aplicacionesProvider.listaApp;
  }

  @override
  Widget build(BuildContext context) {
    List<Application> listaApi;

    return Scaffold(
      appBar: headerApp(context, 'Aplicaciones', Text(''), 0.0),
      body: FutureBuilder(
          future: getListaApis(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              listaApi =
                  List.generate(snapshot.data.length, (i) => snapshot.data[i]);
              return ListView.builder(
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
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
