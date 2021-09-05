import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

abrirWhatsapp(String phone, String mensaje) {
  FlutterOpenWhatsapp.sendSingleMessage(phone, mensaje);
}
