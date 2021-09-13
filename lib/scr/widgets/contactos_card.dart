import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/icon_conteiner.dart';

class TarjetaContacto2 extends StatefulWidget {
  TarjetaContacto2(this.context, this.contacto);
  BuildContext context;
  Contact contacto;
  @override
  _TarjetaContacto2 createState() => _TarjetaContacto2();
}

class _TarjetaContacto2 extends State<TarjetaContacto2> {
  bool oneTap;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    oneTap = false;
  }

  @override
  Widget build(BuildContext context) {
    return oneTap
        ? GestureDetector(
            child: Container(
              height: 225,
              margin: EdgeInsets.symmetric(horizontal: 2.5, vertical: 2.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //_avatar(contacto),
                  _nombreContacto(context, widget.contacto),

                  _botonesContactos(context, widget.contacto),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3.0)),
            ),
            onTap: () {
              oneTap = !oneTap;
              setState(() {});
              // Navigator.pushNamed(context, 'editarContacto', arguments: contacto);
            },
          )
        : GestureDetector(
            child: Container(
              height: 96,
              margin: EdgeInsets.symmetric(horizontal: 2.5, vertical: 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //_avatar(contacto),
                  _nombreContacto(context, widget.contacto),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3.0)),
            ),
            onTap: () {
              oneTap = !oneTap;
              setState(() {});
              // Navigator.pushNamed(context, 'editarContacto', arguments: contacto);
            },
          );
  }
}

Widget _botonesContactos(BuildContext context, Contact contacto) {
  final List<Widget> _listaWidget = [
    Column(
      children: [
        Container(
          height: 75,
          width: 75,
          margin: EdgeInsets.only(top: 10),
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
        Text(
          'Llamar',
          style: TextStyle(fontSize: 15),
        )
      ],
    ),
    SizedBox(
      width: 10,
    ),
    Column(
      children: [
        Container(
          height: 75,
          width: 75,
          margin: EdgeInsets.only(top: 10),
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
        Text(
          'Mensajes',
          style: TextStyle(fontSize: 15),
        )
      ],
    ),
    SizedBox(
      width: 10,
    ),
    Column(
      children: [
        Container(
          height: 75,
          width: 75,
          margin: EdgeInsets.only(top: 10),
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
        //  Divider(),
        Text(
          'Whatsapp',
          style: TextStyle(fontSize: 15),
        )
      ],
    ),
    SizedBox(
      width: 10,
    ),
    Column(
      children: [
        Container(
          height: 75,
          width: 75,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: Colors.black,
          ),
          child: conteinerIcon(
              context,
              Icon(Icons.video_call, size: 50.0, color: Colors.white),
              'mensaje',
              ''),
        ),
        Text(
          ' Video',
          style: TextStyle(fontSize: 15),
        )
      ],
    ),
    SizedBox(
      width: 10,
    ),
    Column(
      children: [
        Container(
          height: 75,
          width: 75,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: Colors.black,
          ),
          child: conteinerIcon(
              context,
              Icon(
                Icons.edit,
                size: 50.0,
                color: Colors.white,
              ),
              'whatsapp',
              contacto.phones.elementAt(0).value),
        ),
        Text(
          'Editar',
          style: TextStyle(fontSize: 15),
        )
      ],
    ),
  ];

  return Container(
    height: 115.0,
    margin: EdgeInsets.only(bottom: 2.0, left: 5.0),
    width: double.infinity,
    child: ListView.builder(
      controller: PageController(viewportFraction: 0.1),
      scrollDirection: Axis.horizontal,
      itemCount: _listaWidget.length,
      itemBuilder: (context, i) => _listaWidget[i],
    ),
  );
}

Widget _nombreContacto(BuildContext context, Contact contacto) {
  return Container(
      height: 90,
      color: Color.fromRGBO(55, 57, 84, 1.0),
      width: double.infinity,
      //margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      // decoration: BoxDecoration(
      //     color:
      //         Color.fromRGBO(55, 57, 84, 1.0), //Theme.of(context).primaryColor,
      //     borderRadius: BorderRadius.circular(10.0)),
      //border: Border.all(color: Colors.green)),
      child:
          // _avatar(context, contacto),

          Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              contacto.displayName,
              //overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              ),
            ),
          ),
          // Text(
          //   contacto.phones.elementAt(0).value,
          //   style: TextStyle(
          //     fontSize: 15,
          //     color: Colors.white,
          //   ),
          // )
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
