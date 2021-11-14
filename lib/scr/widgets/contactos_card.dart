import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/icon_conteiner.dart';

class TarjetaContacto2 extends StatefulWidget {
  TarjetaContacto2(this.context, this.contacto);
  final BuildContext context;
  final Contact contacto;
  @override
  _TarjetaContacto2 createState() => _TarjetaContacto2();
}

class _TarjetaContacto2 extends State<TarjetaContacto2> {
  bool oneTap;

  @override
  void initState() {
    super.initState();
    oneTap = false;
  }

  @override
  Widget build(BuildContext context) {
    return oneTap
        ? GestureDetector(
            child: Container(
              height: 225,
              margin: EdgeInsets.symmetric(horizontal: 2.5, vertical: 2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //_avatar(contacto),
                  SizedBox(
                    height: 10,
                  ),
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
              height: 100,
              margin: EdgeInsets.symmetric(horizontal: 2.5, vertical: 2.0),
              child:
                  //_avatar(contacto),
                  _nombreContacto(context, widget.contacto),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.white)),
              // borderRadius: BorderRadius.circular(35.0),
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
  print('');
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
              'discado',
              contacto),
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
              contacto),
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
              Icon(Icons.message_rounded, size: 50.0, color: Colors.white),
              'mensajeC',
              contacto),
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
                Icons.edit,
                size: 50.0,
                color: Colors.white,
              ),
              'editar',
              contacto),
        ),
        Text(
          'Editar',
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
              'video',
              null),
        ),
        Text(
          ' Video',
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
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      //border: Border.all()),
      //.fromRGBO(55, 57, 84, 1.0),
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 2),
      child:
          // _avatar(context, contacto),

          Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              contacto.displayName,
              overflow: TextOverflow.ellipsis,
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
