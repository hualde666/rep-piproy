import 'package:flutter/material.dart';

// class BotonFlotante extends StatelessWidget {
//   const BotonFlotante({
//     @required this.pagina,
//     Key key,
//   }) : super(key: key);
//   final String pagina;
//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton.extended(
//       heroTag: pagina,
//       backgroundColor: Color.fromRGBO(0, 0, 0, 0.0),
//       icon: Icon(
//         Icons.help,
//         color: Colors.white,
//         size: 40,
//       ),
//       label: Text('ayuda', style: TextStyle(fontSize: 15, color: Colors.white)),
//       onPressed: () {
//         Navigator.pushNamed(context, 'ayuda', arguments: pagina);
//       },
//     );
//   }
// }
class BotonFlotante extends StatelessWidget {
  const BotonFlotante({
    @required this.pagina,
    Key key,
  }) : super(key: key);
  final String pagina;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 135,
        margin: EdgeInsets.only(left: 2),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.help,
              color: Colors.white,
              size: 40,
            ),
            Text(' ayuda', style: TextStyle(fontSize: 20, color: Colors.white)),
          ],
        ),
        //color: Color.fromRGBO(0, 0, 0, 0.0),
      ),
      onTap: () {
        Navigator.pushNamed(context, 'ayuda', arguments: pagina);
      },
    );
  }
}

class BotonAgregar extends StatelessWidget {
  const BotonAgregar({
    @required this.ruta,
    Key key,
  }) : super(key: key);
  final String ruta;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 135,
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(20.0),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(' agregar ',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            Icon(
              Icons.add_circle,
              color: Colors.white,
              size: 40,
            ),
          ],
        ),

        //  color: Color.fromRGBO(0, 0, 0, 0.0),
      ),
      onTap: () {
        Navigator.pushNamed(context, ruta);
      },
    );
  }
}
