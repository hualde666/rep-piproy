import 'package:flutter/material.dart';
import 'package:piproy/scr/funciones/url_funciones.dart';
import 'package:piproy/scr/widgets/header_app.dart';

class Discado extends StatefulWidget {
  @override
  State<Discado> createState() => _DiscadoState();
}

class _DiscadoState extends State<Discado> {
  final myController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Colors.white38, width: 1)),
              height: 80,
              child: Center(
                child: Text(
                  myController.text,
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 5,
              ),
              height: 320,
              child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  // childAspectRatio: 1.1,
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
                        if (numero.length > 1) {
                          myController.text =
                              numero.substring(0, numero.length - 1);
                        } else {
                          myController.text = '';
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
                          size: 50,
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
                setState(() {});
                print(myController.text);
              },
              child: Container(
                height: 10,
                width: 10,
                child: Center(
                  child: Text(
                    teclado[index],
                    style: TextStyle(fontSize: 60, color: Colors.white),
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
