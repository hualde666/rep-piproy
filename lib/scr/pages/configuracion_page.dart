import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';
import 'package:piproy/scr/widgets/header_app.dart';

class ConfiguracionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: headerApp(context, 'Configuración', Text(''), 0.0),

        // title: Text('Configuración'),

        body: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            ListTile(
                leading: Icon(Icons.contact_phone,
                    size: 35.0, color: Theme.of(context).primaryColor),
                title: Text('Agregar o eliminar contactos de emergencia'),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.pushNamed(context, 'emergiContactos');
                }),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.message,
                size: 40.0,
                color: Theme.of(context).primaryColor,
              ),
              title: Text('Redactar mensaje de emergencia'),
              onTap: () {
                Navigator.pushNamed(context, 'emergiMensaje');
              },
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: BotonFlotante(pagina: 'configurar'),
      ),
    );
  }
}
