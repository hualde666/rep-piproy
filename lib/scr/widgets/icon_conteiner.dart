import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

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
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.green, width: 1.0)),
        margin: EdgeInsets.only(
          left: 15.0,
          top: 30.0,
        ),
        child: icon, // Icon(icon, size: 40.0, color: Colors.green),
      ),
    ),
    onTap: () => {funcionIcon(tarea, phone)},
  );
}

funcionIcon(String tarea, String phone) {
  print(tarea);
  switch (tarea) {
    case 'llamada':
      llamar(phone);
      break;
    case 'linterna':
      break;
  }
}

llamar(String phone) async {
  bool res = await FlutterPhoneDirectCaller.callNumber(phone);
  print(res);
}
