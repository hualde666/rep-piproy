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
    final List<Widget> teclado = botones(context, myController);
    return SafeArea(
      child: Scaffold(
        appBar: headerApp(context, 'Teléfon', Text(''), 0.0, true, 'Ayuda'),
        // backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 5,
              ),
              height: 270,
              child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.8,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  crossAxisCount: 3,
                  children: teclado),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Row(
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
                    onTap: () => llamar(myController.text),
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
            )
          ],
        ),
      ),
    );
  }

  String formatoNumero(String numero) {
    final expRegular = RegExp(r'[0-9]{3}-[0-9]{2}-[0-9]{2}-[0-9]{2}');
    //  r'/^[\(]?[\+]?(\d{2}|\d{3})[\)](\d{2}|\d{3})[\*\.\-\s]$?[\s]?((\d{6}|\d{8})|(\d{3}[\*\.\-\s]){3}|(\d{2}[\*\.\-\s]){4}|(\d{4}[\*\.\-\s]){2})|\d{8}|\d{10}|\d{12}$');
    final text = numero.replaceAllMapped(expRegular, (match) => null);
    print(text);
    return '';
  }

  List<Widget> botones(
      BuildContext context, TextEditingController myController) {
    List<String> teclado = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '*',
      '0',
      '#'
    ];
    return List.generate(
        teclado.length,
        (index) => GestureDetector(
              onTap: () {
                myController.text = myController.text + teclado[index];
                formatoNumero(myController.text);
                setState(() {});
                print(myController.text);
              },
              child: Container(
                //   height: 10,
                //   width: 10,
                child: Center(
                  child: Text(
                    teclado[index],
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.white38, width: 1)),
              ),
            ));
  }
}
