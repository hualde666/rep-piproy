import 'package:flutter/material.dart';
import 'package:piproy/scr/widgets/header_app.dart';

class AgregaBotonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: headerApp(
              context, 'Crea Opcion', Text(''), 0.0, true, 'AgregaBoton'),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 100,
                    margin:
                        EdgeInsets.symmetric(vertical: 1.5, horizontal: 3.0),
                    alignment: Alignment.center,
                    child: Text('Categorias',
                        style: TextStyle(color: Colors.white, fontSize: 35.0)),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 100,
                    margin:
                        EdgeInsets.symmetric(vertical: 1.5, horizontal: 3.0),
                    alignment: Alignment.center,
                    child: Text('Aplicacion',
                        style: TextStyle(color: Colors.white, fontSize: 35.0)),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.white)),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
