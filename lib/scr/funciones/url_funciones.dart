import 'package:url_launcher/url_launcher.dart';

abrirWhatsapp(String phone, String mensaje) async {
  // FlutterOpenWhatsapp.sendSingleMessage(phone, mensaje);
  var whatsappURl = "whatsapp://send?phone=" + phone + "";
  if (await canLaunch(whatsappURl)) {
    await launch(whatsappURl);
  } else {
    throw 'Could not launch ';
  }
}

llamar(String telefono) async {
  String url = 'tel:' + telefono;

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

mensaje(String phone) async {
  String url = 'sms:' + phone;

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

abrirGoogle() async {
  // FlutterOpenWhatsapp.sendSingleMessage(phone, mensaje);

  if (await canLaunch('https://www.google.com/search?')) {
    await launch('https://www.google.com/search?');
  } else {
    throw 'Could not launch ';
  }
}
