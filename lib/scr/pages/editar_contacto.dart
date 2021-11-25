import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';

import 'package:piproy/scr/ui/input_decoration.dart';
import 'package:piproy/scr/widgets/header_app.dart';

class EditarContacto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Contact _contact = ModalRoute.of(context).settings.arguments;
    final Contact _contactViejo = _contact;
    return SafeArea(
      child: Scaffold(
        appBar: headerApp(context, 'Contacto', Text(''), 0.0),
        backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
        body: FormContacto(_contact),
        resizeToAvoidBottomInset: false,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BotonFlotante(pagina: 'editarContacto'),
            FloatingActionButton.extended(
              heroTag: "guardar",
              icon: Icon(
                Icons.save,
                size: 40,
                color: Colors.white,
              ),
              label: Text(
                'guardar',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              backgroundColor: Color.fromRGBO(249, 75, 11, 1),
              onPressed: () {
                _guardarContacto(_contact);
                if (_contactViejo.displayName != _contact.displayName) {
                  //******* cambio en las lista el nombre */
                  // Provider.of<AplicacionesProvider>(context, listen: false)
                  //     .modificarContacto(
                  //         _contactViejo.displayName, _contact.displayName);

                  // // cambio en la BD
                  // DbTiposAplicaciones.db.modificarNombre(
                  //     _contactViejo.displayName, _contact.displayName);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future _guardarContacto(Contact contacto) async {
  final resp = await Permission.contacts.request();

  if (resp == PermissionStatus.granted) {
    //await ContactsService.updateContact(contacto);
  }
  return;
}

class FormContacto extends StatelessWidget {
  FormContacto(this.contact);
  final Contact contact;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
            autovalidateMode:
                AutovalidateMode.onUserInteraction, // validacion campo a campo
            child: Column(
              children: [
                TextFormField(
                  initialValue: this.contact.givenName,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.words,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                  decoration: InputDecorations.authInputDecoration(
                      labelText: 'Nombre:'),
                  onChanged: (value) => this.contact.givenName = value,
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autocorrect: false,
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                  textAlign: TextAlign.center,
                  initialValue: this.contact.familyName,
                  decoration: InputDecorations.authInputDecoration(
                      labelText: 'Apellido:'),
                  onChanged: (value) => this.contact.familyName = value,
                ),
              ],
            )));
  }
}
