import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/tres_botones_header.dart';

Widget headerApp(BuildContext context, String titulo, Widget otroWidget,
    double alto, bool conrojo, String pagina) {
  return PreferredSize(
    preferredSize: Size.fromHeight(180.0 + alto),

    // here the desired height
    child: Container(
      //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      //padding: EdgeInsets.only(top: 5),
      // decoration: new BoxDecoration(
      //     gradient: LinearGradient(
      //         colors: [
      //       Theme.of(context).primaryColor,

      //       Colors.white,
      //       Theme.of(context).scaffoldBackgroundColor,
      //       // Colors.white,
      //       // Colors.orange,
      //       // Color.fromRGBO(55, 57, 84, 1.0)
      //     ],
      //         stops: [
      //       0.1,
      //       0.4,
      //       0.99
      //     ],
      //         begin: FractionalOffset.topCenter,
      //         end: FractionalOffset.bottomCenter)),
      //color: Color.fromRGBO(55, 57, 84, 1.0),
      height: 180 + alto,
      width: double.infinity,

      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          tresBotonesHeader(context, conrojo, pagina),
          SizedBox(
            height: 10,
          ),
          Text(titulo.toUpperCase(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 25)),
          alto > 0
              ? Column(
                  children: [
                    SizedBox(
                      height: 3,
                    ),
                    otroWidget,
                  ],
                )
              : SizedBox(),
        ],
      ),
    ),
  );
}
