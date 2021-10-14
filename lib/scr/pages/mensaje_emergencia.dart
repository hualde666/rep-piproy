import 'package:flutter/material.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';

import 'package:piproy/scr/widgets/header_app.dart';

import 'package:shared_preferences/shared_preferences.dart';

class EmergenciaMensaje extends StatefulWidget {
  @override
  _EmergenciaMensajeState createState() => _EmergenciaMensajeState();
}

class _EmergenciaMensajeState extends State<EmergenciaMensaje> {
  String _mensaje = "Necesito ayuda !!";
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    cargarPrefs();
    _textController = new TextEditingController(text: _mensaje);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  cargarPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _mensaje = prefs.getString('mensajeE');
    if (_mensaje == null) {
      _mensaje = "Necesito ayuda !!";
    }
    _textController = new TextEditingController(text: _mensaje);
    setState(() {});
  }

  guardarMensaje() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _mensaje = _textController.text;
    if (_mensaje.isEmpty) {
      _mensaje = "Necesito ayuda !!";
    }
    prefs.setString('mensajeE', _mensaje);
  }

  @override
  Widget build(BuildContext context) {
    //cargarPrefs();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: headerApp(
            context, 'Modificar Mensaje de Emergencia', Text(''), 0.0),
        body: Center(
          child: GestureDetector(
            onTap: () {
              final FocusScopeNode focus = FocusScope.of(context);
              if (!focus.hasPrimaryFocus && focus.hasFocus) {
                FocusManager.instance.primaryFocus.unfocus();
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    constraints: BoxConstraints(maxHeight: 300),
                    child: TextField(
                      onEditingComplete: () {
                        guardarMensaje();
                        final FocusScopeNode focus = FocusScope.of(context);
                        if (!focus.hasPrimaryFocus && focus.hasFocus) {
                          FocusManager.instance.primaryFocus.unfocus();
                        }
                      },
                      onTap: () {
                        guardarMensaje();
                        final FocusScopeNode focus = FocusScope.of(context);
                        if (!focus.hasPrimaryFocus && focus.hasFocus) {
                          FocusManager.instance.primaryFocus.unfocus();
                        }
                      },

                      style: TextStyle(fontSize: 25.0),
                      // autofocus: true,
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      controller: _textController,
                      decoration: InputDecoration(
                        // hintText: _mensaje,
                        labelText: 'Mensaje de Emergencia:',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Text(
                      'Redacte el mensaje que desea enviar a sus contactos de emergencia en caso de un incidente.',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: BotonFlotante(pagina: 'emergiMensaje'),
        // bottomNavigationBar: BottonBarNavegador(),
        // floatingActionButton: FloatingActionButton.extended(
        // icon: Icon(Icons.check_circle, color: Colors.white, size: 40),
        // backgroundColor: Color.fromRGBO(249, 75, 11, 1),
        // label: Text('guardar',
        //     style: TextStyle(fontSize: 20, color: Colors.white)),
        // tooltip: 'guardar',
        // heroTag: 'guardar',
        // onPressed: () {
        //   // *** actualizar mensaje***
        //   guardarMensaje();
        //   Navigator.pop(context);
        // })
      ),
    );
  }
}
