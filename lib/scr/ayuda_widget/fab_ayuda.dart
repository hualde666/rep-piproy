import 'package:flutter/material.dart';

class BotonFlotante extends StatelessWidget {
  const BotonFlotante({
    @required this.pagina,
    Key key,
  }) : super(key: key);
  final String pagina;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
      icon: Icon(
        Icons.help,
        color: Colors.white,
        size: 40,
      ),
      label: Text('ayuda', style: TextStyle(fontSize: 15, color: Colors.white)),
      onPressed: () {
        Navigator.pushNamed(context, 'ayuda', arguments: pagina);
      },
    );
  }
}
