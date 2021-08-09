import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:piproy/scr/funciones/abrir_whatsapp.dart';

Widget conteinerIcon(
    BuildContext context, Icon icon, String tarea, String phone) {
  return GestureDetector(
      child: Tooltip(
        message: tarea,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient:
              const LinearGradient(colors: <Color>[Colors.amber, Colors.green]),
        ),
        height: 50,
        padding: const EdgeInsets.all(4.0),
        preferBelow: false,
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
        showDuration: const Duration(seconds: 2),
        waitDuration: const Duration(seconds: 1),
        child: Center(
          child: Container(
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
                color: (tarea == 'whatsapp')
                    ? Colors.green
                    : Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(80),
                border: Border.all(color: Colors.white, width: 2.0)),
            // margin: EdgeInsets.only(
            //   left: 15.0,
            //   //   top: 30.0,
            // ),

            child: icon,
          ),
        ),
      ),
      //icon, // Icon(icon, size: 40.0, color: Colors.green),
      onTap: () => {funcionIcon(context, tarea, phone)});
}

funcionIcon(BuildContext context, String tarea, String phone) {
  print(tarea);
  switch (tarea) {
    case 'llamada':
      llamar(phone);
      break;
    case 'linterna':
      break;
    case 'whatsapp':
      abrirWhatsapp(phone, '');
      break;
    case 'configurar':
      Navigator.pushNamed(context, 'configurar');
      break;
  }
}

llamar(String phone) async {
  bool res = await FlutterPhoneDirectCaller.callNumber(phone);
  print(res);
}
