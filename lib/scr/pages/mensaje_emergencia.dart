import 'package:flutter/material.dart';

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
    prefs.setString('mensajeE', _mensaje);
  }

  @override
  Widget build(BuildContext context) {
    //cargarPrefs();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
          title: Text(
            'Modificar Mensaje de Emergencia',
            style: TextStyle(fontSize: 15),
          ),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'Redacte el mensaje que desea enviar a sus contactos de emergencia en caso de un incidente.',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  style: TextStyle(fontSize: 25.0),
                  // autofocus: true,
                  maxLines: null,
                  keyboardType: TextInputType.text,
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: _mensaje,
                    labelText: 'Mensaje de Emergencia:',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.check_circle, color: Colors.white, size: 40),
            backgroundColor: Color.fromRGBO(249, 75, 11, 1),
            label: Text('guardar',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            tooltip: 'guardar',
            heroTag: 'guardar',
            onPressed: () {
              // *** actualizar mensaje***
              guardarMensaje();
              Navigator.pop(context);
            }));
  }
}
