import 'package:flutter/material.dart';

import 'package:piproy/scr/funciones/url_funciones.dart';
import 'package:piproy/scr/widgets/header_app.dart';

class Discado extends StatefulWidget {
  @override
  State<Discado> createState() => _DiscadoState();
}

class _DiscadoState extends State<Discado> {
  final myController = TextEditingController();
  String telefono = '';
  @override
  void initState() {
    myController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  final List<Widget> teclado = botones(context, myController);

    return SafeArea(
        child: Scaffold(
      appBar: headerApp(context, 'Teléfon', Text(''), 0.0, true, 'Ayuda'),
      // backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              //SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 1)),
              // height: 80,
              child: Center(
                child: Text(
                  myController.text,
                  style: TextStyle(
                      fontSize: 45,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            tecla(context, '1', myController),
            SizedBox(
              width: 8,
            ),
            tecla(context, '2', myController),
            SizedBox(
              width: 8,
            ),
            tecla(context, '3', myController)
          ]),
          SizedBox(
            height: 8,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            tecla(context, '4', myController),
            SizedBox(
              width: 8,
            ),
            tecla(context, '5', myController),
            SizedBox(
              width: 8,
            ),
            tecla(context, '6', myController)
          ]),
          SizedBox(
            height: 8,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            tecla(context, '7', myController),
            SizedBox(
              width: 8,
            ),
            tecla(context, '8', myController),
            SizedBox(
              width: 8,
            ),
            tecla(context, '9', myController)
          ]),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            tecla(context, '*', myController),
            SizedBox(
              width: 8,
            ),
            tecla(context, '0', myController),
            SizedBox(
              width: 8,
            ),
            tecla(context, '#', myController)
          ]),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (() => {
                      setState(() {
                        telefono = '';
                        myController.clear();
                      })
                    }),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25.0),
                      border: Border.all(color: Colors.white38, width: 1)),
                  child: Center(
                    child: Icon(
                      Icons.clear,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (myController.text.length > 8) {
                    llamar(myController.text);
                  }
                },
                child: Container(
                  height: 80,
                  width: 140,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 10, 185, 98),
                      borderRadius: BorderRadius.circular(25.0),
                      border: Border.all(color: Colors.white38, width: 1)),
                  child: Center(
                      child: Text(
                    'llamar',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  )),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    final String numero = myController.text;
                    telefono = myController.text;
                    if (numero.length > 1) {
                      myController.text =
                          numero.substring(0, numero.length - 1);
                      //   final x = formatoNumero(numero);
                    } else {
                      myController.text = '';
                      telefono = '';
                    }
                  });
                },
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(25.0),
                      border: Border.all(color: Colors.white38, width: 1)),
                  child: Center(
                    child: Icon(
                      Icons.backspace_outlined,
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    ));
  }

  Widget tecla(
      BuildContext context, String tecla, TextEditingController myController) {
    //final altura = (MediaQuery.of(context).size.height - 190) / 5.0;
    return GestureDetector(
        onTap: () {
          if (myController.text.length < 12) {
            myController.text = myController.text + tecla;
          }

          setState(() {});
          // print(myController.text);
        },
        child: Container(
          height: 70,
          width: 110,
          child: Center(
            child: Text(
              tecla,
              style: TextStyle(
                fontSize: 55,
              ),
            ),
          ),
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(20.0),
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 1)),
        ));
  }
}
