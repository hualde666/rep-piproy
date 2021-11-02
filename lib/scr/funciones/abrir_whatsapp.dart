import 'package:url_launcher/url_launcher.dart';

abrirWhatsapp(String phone, String mensaje) async {
  // FlutterOpenWhatsapp.sendSingleMessage(phone, mensaje);
  var whatsappURl_android = "whatsapp://send?phone=" + phone + "";
  if (await canLaunch(whatsappURl_android)) {
    await launch(whatsappURl_android);
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

mensaje() async {
  String url = 'sms:';

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
