import 'package:flutter/material.dart';

import 'package:piproy/scr/models/api_tipos.dart';
import 'package:piproy/scr/pages/api_grupos.dart';
import 'package:piproy/scr/pages/conta_grupos.dart';
import 'package:piproy/scr/pages/contacts_por_grupo.dart';
import 'package:piproy/scr/pages/intstalacion_page.dart';
import 'package:piproy/scr/pages/opciones_page.dart';
import 'package:piproy/scr/pages/paletta_colores.dart';
import 'package:piproy/scr/pages/presentacion_page.dart';
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
        appBar: headerApp(
            context, 'Configuración', Text(''), 0.0, true, 'configurar'),

        // title: Text('Configuración'),

        body: ListView(children: [
          SizedBox(
            height: 20,
          ),
          Divider(
            height: 10,
            color: Colors.white38,
          ),
          ListTile(
            leading: Icon(
              Icons.groups,
              size: 40.0,
              color: Colors.white,
            ),
            title: Text('Contactos',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                )),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContactsGruposPage()));
            },
          ),
          Divider(
            height: 10,
            color: Colors.white38,
          ),
          ListTile(
            leading: Icon(
              Icons.app_registration,
              size: 40.0,
              color: Colors.white,
            ),
            title: Text('Aplicaciones',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ApiGruposPage()));
            },
          ),
          Divider(
            height: 10,
            color: Colors.white38,
          ),
          ListTile(
            leading: Icon(
              Icons.engineering,
              size: 40.0,
              color: Colors.white,
            ),
            title: Text('Habilitar o Deshabilitar Elementos',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OpcionesPage()));
            },
          ),
          Divider(
            height: 10,
            color: Colors.white38,
          ),
          ListTile(
              leading: Icon(
                Icons.contact_phone,
                size: 35.0,
                color: Colors.white,
              ),
              title: Text(
                'Agregar o eliminar contactos de emergencia',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              onTap: () {
                //Navigator.pop(context);
                // Navigator.pushNamed(context, 'emergiContactos');
                final String grupo = 'Emergencia';

                if (!apiProvider.contactgrupos.contains(grupo)) {
                  Provider.of<AplicacionesProvider>(context, listen: false)
                      .agregarGrupoContact(grupo);
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
          Divider(
            height: 10,
            color: Colors.white38,
          ),
          ListTile(
            leading: Icon(
              Icons.message,
              size: 40.0,
              color: Colors.white,
            ),
            title: Text('Redactar mensaje de emergencia',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                )),
            onTap: () {
              Navigator.pushNamed(context, 'emergiMensaje');
            },
          ),
          Divider(
            height: 10,
            color: Colors.white38,
          ),
          ListTile(
            leading: Icon(
              Icons.palette,
              size: 40.0,
              color: Colors.white,
            ),
            title: Text('Color de Viatlfon',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PaletaPage()));
            },
          ),
          Divider(
            height: 10,
            color: Colors.white38,
          ),
          Container(
            child: Center(
              child: ListTile(
                leading: Icon(
                  Icons.play_circle,
                  size: 40.0,
                  color: Colors.white,
                ),
                title: Text('Video Presentacion',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    )),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen()));
                },
              ),
            ),
          ),
          Divider(
            height: 10,
            color: Colors.white38,
          ),
          ListTile(
            leading: Icon(
              Icons.gavel_rounded,
              size: 40.0,
              color: Colors.white,
            ),
            title: Text('Simulación',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InstalacionPage()));
            },
          ),
        ]),
        // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        // floatingActionButton: BotonFlotante(pagina: 'configurar'),
      ),
    );
  }
}
