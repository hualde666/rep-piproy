import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/icon_conteiner.dart';

Widget tarjetaContacto(BuildContext context, Contact contacto) {
  final String _nombre =
      contacto.displayName != null ? contacto.displayName : 'Sin Nombre';
  // final String _telefono = contacto.phones.elementAt(0).value;
  return GestureDetector(
    child: Container(
      height: 400.0,
      //color: Colors.white38,
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // _avatar(contacto),
          _nombreContacto(_nombre),
          SizedBox(
            height: 150.0,
          ),

          _botonesContactos(),
        ],
      ),
      decoration: BoxDecoration(
          image: contacto.avatar.isEmpty
              ? null
              : DecorationImage(
                  image: MemoryImage(contacto.avatar), fit: BoxFit.cover),
          color: Colors.white38,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.green, width: 5.0)),
    ),
    onTap: () {
      Navigator.pop(context);
      // Navigator.pushNamed(context, '');
    },
  );
}

Widget _botonesContactos() {
  return Container(
    height: 100.0,
    margin: EdgeInsets.only(bottom: 10.0, right: 15.0),
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        conteinerIcon(
            Icon(Icons.message, size: 40.0, color: Colors.white), 'mensaje'),
        conteinerIcon(Icon(Icons.video_call, size: 40.0, color: Colors.white),
            'video llamada'),
        conteinerIcon(
            Icon(Icons.call, size: 40.0, color: Colors.white), 'llamada'),
      ],
    ),
  );
}

Widget _nombreContacto(String nombre) {
  return Container(
      height: 100,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(55, 57, 84, 1.0),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.white)),
      child: Center(
          child: Text(nombre,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              ))));
}

// Widget _avatar(Contact contacto) {
//   if (contacto.avatar.isEmpty) {
//     return CircleAvatar(
//       child: Text(
//         contacto.initials(),
//         style: TextStyle(fontSize: 30.0),
//       ),
//       foregroundColor: Colors.black,
//       backgroundColor: Colors.green,
//       maxRadius: 50.0,
//     );
//   } else {
//     // return CircleAvatar(
    //   maxRadius: 50.0,
    //   backgroundImage: MemoryImage(contacto.avatar),
    // );
//   }
// }
