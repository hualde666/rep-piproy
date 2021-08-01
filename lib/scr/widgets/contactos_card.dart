import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/icon_conteiner.dart';

Widget tarjetaContacto2(BuildContext context, Contact contacto) {
  final String _nombre =
      contacto.displayName != null ? contacto.displayName : 'Sin Nombre';
  // final String _telefono1 = contacto.phones.elementAt(0).value;
  return GestureDetector(
    child: Container(
      height: 240.0,
      margin: EdgeInsets.symmetric(horizontal: 2.5, vertical: 2.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //_avatar(contacto),
          _nombreContacto(context, contacto),

          _botonesContactos(context, contacto),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border:
              Border.all(color: Theme.of(context).primaryColor, width: 3.0)),
    ),
    onTap: () {
      Navigator.pushNamed(context, 'editarContacto', arguments: contacto);
    },
  );
}

Widget _botonesContactos(BuildContext context, Contact contacto) {
  return Container(
    height: 100.0,
    margin: EdgeInsets.only(bottom: 2.0, right: 15.0),
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 75,
          width: 75,
          // margin: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: Colors.black,
          ),
          child: conteinerIcon(
              context,
              Icon(Icons.call, size: 50.0, color: Colors.white),
              'llamada',
              contacto.phones.elementAt(0).value),
        ),
        Container(
          height: 75,
          width: 75,
          //   margin: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: Colors.black,
          ),
          child: conteinerIcon(
              context,
              Icon(Icons.message, size: 50.0, color: Colors.white),
              'mensaje',
              ''),
        ),
        Container(
          height: 75,
          width: 75,
          //    margin: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: Colors.black,
          ),
          child: conteinerIcon(
              context,
              Icon(
                Icons.call,
                size: 50.0,
                color: Colors.white,
              ),
              'whatsapp',
              contacto.phones.elementAt(0).value),
        ),
      ],
    ),
  );
}

Widget _nombreContacto(BuildContext context, Contact contacto) {
  return Container(
      height: 120,
      width: double.infinity,
      //margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      decoration: BoxDecoration(
          color: Colors.amber[600], //Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10.0)),
      //border: Border.all(color: Colors.green)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _avatar(context, contacto),
          Container(
            height: 100.0,
            width: 245.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    contacto.displayName,
                    //overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 25.0,
                    ),
                  ),
                ),
                Text(
                  contacto.phones.elementAt(0).value,
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
        ],
      ));
}

Widget _avatar(BuildContext context, Contact contacto) {
  if (contacto.avatar.isEmpty) {
    return Container(
      height: 90.0,
      child: CircleAvatar(
        child: Text(
          contacto.initials(),
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).primaryColor),
        ),
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        maxRadius: 50.0,
      ),
    );
  } else {
    return Container(
      height: 90.0,
      child: CircleAvatar(
        maxRadius: 50.0,
        backgroundImage: MemoryImage(contacto.avatar),
      ),
    );
  }
}
