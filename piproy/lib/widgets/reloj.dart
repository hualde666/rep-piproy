import 'package:flutter/material.dart';
import 'package:piproy/scr/models/reloj_modelo.dart';

class Reloj extends StatelessWidget {
//************************** */

  @override
  Widget build(BuildContext context) {
    final RelojModel reloj = RelojModel();
    final _screenSize = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          width: _screenSize.width,
          child: Card(
            elevation: 10.0,
            color: Colors.teal[600],
            shadowColor: Colors.teal,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: [
                Text('${reloj.dias[reloj.diaweek - 1]} ',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text('${reloj.shora} : ${reloj.sminutos}  ${reloj.ampm}',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Text(
                  '${reloj.meses[reloj.mes - 1]} ${reloj.dia}',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
