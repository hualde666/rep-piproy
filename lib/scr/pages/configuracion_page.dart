import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';
import 'package:piproy/scr/definicion/thema_colores.dart';
import 'package:piproy/scr/models/api_tipos.dart';
import 'package:piproy/scr/pages/contacts_por_grupo.dart';
import 'package:piproy/scr/pages/presentacion_page.dart';
import 'package:piproy/scr/providers/aplicaciones_provider.dart';
import 'package:piproy/scr/providers/db_provider.dart';
import 'package:piproy/scr/providers/estado_celular.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            SizedBox(
              height: 20,
            ),
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
            SizedBox(
              height: 20,
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
                seleccionColor(context);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 10,
              color: Colors.white38,
            ),
            ListTile(
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
            SizedBox(
              height: 20,
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
              onTap: () {},
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: BotonFlotante(pagina: 'configurar'),
      ),
    );
  }

  Future seleccionColor(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return seleccionForm(context);
        });
  }

  AlertDialog seleccionForm(BuildContext context) {
    final TextEditingController _tipoControle = TextEditingController();
    final celProvider = Provider.of<EstadoProvider>(context);
    String paletaVieja = celProvider.paleta;
    return AlertDialog(
      content: Form(
        child: Container(
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('Seleccione un color:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                      )),
                  Text('1.- ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  Text('2.- ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  Text('3.- ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.words,
                style: TextStyle(
                  fontSize: 25,
                ),
                controller: _tipoControle,
                validator: (valor) {
                  // validar que no exite ya
                  List opciones = ['1', '2', '3', '4'];

                  return opciones.contains(_tipoControle.value.text)
                      ? null
                      : "dato invalido";
                },
                decoration: InputDecoration(hintText: " 1, 2 , 3 o 4"),
              )
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        ElevatedButton(
            onPressed: () {
              List<String> opciones = ['1', '2', '3', '4'];
              String paletaNueva = _tipoControle.value.text;
              if (opciones.contains(paletaNueva)) {
                if (paletaNueva != paletaVieja) {
                  Provider.of<EstadoProvider>(context, listen: false).paleta =
                      paletaNueva;
                  guardarPreferencia(paletaNueva);
                  themaApi(paletaNueva);
                }
              }

              Navigator.of(context).pop();
            },
            child: Text(
              'Si',
            )),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'No',
            )),
      ],
    );
  }

  guardarPreferencia(String paletaNueva) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('paleta', paletaNueva);
  }
}
