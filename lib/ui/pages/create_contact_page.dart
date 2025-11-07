

import 'package:flutter/material.dart';
import 'package:movil3431/daos/contact_dao.dart';
import 'package:movil3431/entities/contact.dart';

class CreateContactPage extends StatefulWidget {
  const CreateContactPage({super.key});

  @override
  State<CreateContactPage> createState() => _CreateContactPageState();
}

class _CreateContactPageState extends State<CreateContactPage> {

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  String? emailValidatorMessage;


  Future<void> createContactEnDataBase(context) async {

    final contact = Contact(
        name: nameController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
    );

    // isntanciar class encargada del acceso datps
    // llamar al metodo guardarContacto()

    // validar que el email no exista
    final contactDao = ContactDao();

    if(await contactDao.getContactByEmail(contact.email) != null) {
      emailValidatorMessage = "El email ya existe";
      setState(() {});
      return;
    }

    await contactDao.guardarContacto(contact);


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Se guardo correctamente'),
      ),
    );

    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Contacto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey, //  lo necesitamos para validar el formulario
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField( // cambio TextField por TextFormField
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombres',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Este campo es requerido";
                  }
                  if (value.length < 3) {
                    return "El nombre debe tener al menos 3 caracteres";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  errorText: emailValidatorMessage,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "El email es requerido";
                  }
                  final regexEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!regexEmail.hasMatch(value)) {
                    return "El email no tiene formado valido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Telefono',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  emailValidatorMessage = null;
                  setState(() {});
                  if (formKey.currentState!.validate()) {
                    // guardar en base de datos
                    await createContactEnDataBase(context);
                  }
                },
                child: const Text('Crear Contacto'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}