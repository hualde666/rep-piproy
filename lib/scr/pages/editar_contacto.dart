import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

import 'package:piproy/scr/ayuda_widget/fab_ayuda.dart';

import 'package:piproy/scr/providers/contactos_provider.dart';

import 'package:piproy/scr/ui/input_decoration.dart';
import 'package:piproy/scr/widgets/header_app.dart';
import 'package:provider/provider.dart';

class EditarContacto extends StatefulWidget {
  @override
  State<EditarContacto> createState() => _EditarContactoState();
}

class _EditarContactoState extends State<EditarContacto> {
  @override
  Widget build(BuildContext context) {
    final contactosProvider = Provider.of<ContactosProvider>(context);
    final Contact contacto = contactosProvider.contacto;

    return SafeArea(
      child: Scaffold(
        appBar: headerApp(
            context, 'Contacto', Text(''), 0.0, true, 'EditarContacto'),
        backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
        body: formContacto(context, contacto),
        resizeToAvoidBottomInset: false,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BotonFlotante(pagina: 'editarContacto'),
            FloatingActionButton.extended(
                heroTag: "guardar",
                icon: Icon(
                  Icons.save,
                ),
                label: Text(
                  'guardar',
                ),
                backgroundColor: Color.fromRGBO(249, 75, 11, 1),
                onPressed: () {
                  // final String nuevodisplay = contacto.
                  //   _guardarContacto(contacto);

                  //   // ******* cambio en las lista el nombre */
                  //   String nuevoDisplay =
                  //       contacto.givenName + " " + contacto.familyName;
                  //   Provider.of<AplicacionesProvider>(context, listen: false)
                  //       .modificarContacto(_contactViejo, nuevoDisplay);

                  //   // cambio en la BD
                  //   DbTiposAplicaciones.db
                  //       .modificarNombre(_contactViejo, nuevoDisplay);
                  //   Provider.of<ContactosProvider>(context, listen: false)
                  //       .contacto = contacto;
                  //   Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}

// Future _guardarContacto(Contact contacto) async {
//   final resp = await Permission.contacts.request();

//   if (resp == PermissionStatus.granted) {
//     // no me funciona updtateContact por tanto:
//     // lo borro ****
//     await ContactsService.deleteContact(contacto);
//     // y lo agrego ***

//     contacto.identifier = "";
//     await ContactsService.addContact(contacto);
//   }
//   return;
// }

Widget formContacto(BuildContext context, Contact contact) {
  return Container(
      child: Form(
          autovalidateMode:
              AutovalidateMode.onUserInteraction, // validacion campo a campo
          child: Column(
            children: [
              TextFormField(
                  initialValue: contact.givenName,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.words,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                  decoration: InputDecorations.authInputDecoration(
                      labelText: 'Nombre:'),
                  onChanged: (value) => {
                        contact.givenName = value,
                      }),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                  autocorrect: false,
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                  textAlign: TextAlign.center,
                  initialValue: contact.familyName,
                  decoration: InputDecorations.authInputDecoration(
                      labelText: 'Apellido:'),
                  onChanged: (value) => {
                        contact.familyName = value,
                      }),
            ],
          )));
}
