import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/tres_botones_header.dart';

Widget headerApp(BuildContext context, String titulo, Widget otroWidget,
    double alto, bool conrojo, String pagina) {
  double width = MediaQuery.of(context).size.width;
  double altoHeader = 200;
  if (width <= 320) {
    altoHeader = 170;
  }

  return PreferredSize(
    preferredSize: Size.fromHeight(altoHeader + alto),
    child: Container(
      //width: double.infinity,

      child: Column(
        children: [
          tresBotonesHeader(context, conrojo, pagina),
          SizedBox(
            height: 1,
          ),
          Container(
            child: Text(titulo,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 25)),
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
