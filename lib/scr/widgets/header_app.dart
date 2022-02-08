import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/tres_botones_header.dart';

Widget headerApp(BuildContext context, String titulo, Widget otroWidget,
    double alto, bool conrojo, String pagina) {
  return PreferredSize(
    preferredSize: Size.fromHeight(185.0 + alto),
    child: Container(
      width: double.infinity,
      child: Column(
        children: [
          tresBotonesHeader(context, conrojo, pagina),
          SizedBox(
            height: 1,
          ),
          Container(
            child: Text(titulo,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 25)),
          ),
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
