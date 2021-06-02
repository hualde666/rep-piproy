import 'package:flutter/material.dart';

import 'package:piproy/scr/widgets/elemntos.dart';
import 'package:piproy/scr/widgets/encabezado.dart';

class BotonRojoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: CustomScrollView(slivers: <Widget>[
      encabezadoApp('E M E R G E N C I A'),
      SliverList(
          delegate: SliverChildListDelegate([
        SizedBox(height: 50.0),
        elementos(
            context,
            Text('EMERGENCIA',
                style: TextStyle(color: Colors.white, fontSize: 35.0)),
            Colors.red,
            ''),
        SizedBox(height: 20.0),
        elementos(
            context,
            Text('Cancelar',
                style: TextStyle(color: Colors.white, fontSize: 35.0)),
            Colors.green,
            '')
      ]))
    ]
                //  bottomNavigationBar: bottonBarNavegador(context),

                )));
  }
}

//    Scaffold(
//     // appBar: AppBar(
//     //   backgroundColor: Colors.red[900],
//     //   textTheme: TextTheme(
//     //       headline1: TextStyle(color: Colors.white, fontSize: 30.0)),
//     //   title: Text('LLAMADA DE EMERGENCIA'),
//     // ),
//     body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           BotonRojo('emergencia'),
//           SizedBox(
//             height: 50.0,
//           ),
//           BotonCancelar(),
//         ],
//       ),
//     ),
//     floatingActionButton: Icon(
//       Icons.edit,
//       size: 30.0,
//       color: Colors.red,
//     ),
//   );
// }
// }
