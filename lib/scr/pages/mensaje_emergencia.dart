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
        title: Text('Mensaje de Emergencia'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            style: TextStyle(fontSize: 25.0),
            autofocus: true,
            maxLines: null,
            keyboardType: TextInputType.text,
            controller: _textController,
            decoration: InputDecoration(
              hintText: _mensaje,
              labelText: 'Mensaje de Emergencia:',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          tooltip: 'guardar',
          heroTag: 'guardar',
          onPressed: () {
            // *** actualizar mensaje***
            guardarMensaje();
            Navigator.pop(context);
          }),
    );
  }
}
