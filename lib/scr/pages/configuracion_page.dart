import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';
import 'package:piproy/scr/models/api_tipos.dart';
import 'package:piproy/scr/pages/contacts_por_grupo.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

class ConfiguracionPage extends StatelessWidget {
  final apiProvider = new AplicacionesProvider();

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
                  // Navigator.pushNamed(context, 'emergiContactos');
                  final String grupo = 'Emergencia';

                  if (!apiProvider.contactgrupos.contains(grupo)) {
                    Provider.of<AplicacionesProvider>(context, listen: false)
                        .agregarContactGrupo(grupo);
                    final nuevo =
                        new ApiTipos(grupo: grupo, nombre: "", tipo: "2");
                    DbTiposAplicaciones.db.nuevoTipo(nuevo);
                  }
                  Provider.of<AplicacionesProvider>(context, listen: false)
                      .tipoSeleccion = grupo;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactsPorGrupoPage()));
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
