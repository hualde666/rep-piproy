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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  border: Border.all(color: Colors.white38, width: 1)),
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
          // Container(
          //   margin: EdgeInsets.symmetric(
          //     horizontal: 5,
          //   ),
          //   height: 270,
          //   child: GridView.count(
          //       physics: NeverScrollableScrollPhysics(),
          //       childAspectRatio: 1.8,
          //       mainAxisSpacing: 5,
          //       crossAxisSpacing: 5,
          //       crossAxisCount: 3,
          //       children: teclado),
          // ),

          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            tecla(context, '1', myController),
            tecla(context, '2', myController),
            tecla(context, '3', myController)
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            tecla(context, '4', myController),
            tecla(context, '5', myController),
            tecla(context, '6', myController)
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            tecla(context, '7', myController),
            tecla(context, '8', myController),
            tecla(context, '9', myController)
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            tecla(context, '*', myController),
            tecla(context, '0', myController),
            tecla(context, '#', myController)
          ]),
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
                    style: TextStyle(fontSize: 30),
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
          myController.text = myController.text + tecla;

          setState(() {});
          // print(myController.text);
        },
        child: Container(
          height: 70,
          width: 110,
          child: Center(
            child: Text(
              tecla,
              style: TextStyle(fontSize: 55, color: Colors.white),
            ),
          ),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.white38, width: 1)),
        ));
  }
}
