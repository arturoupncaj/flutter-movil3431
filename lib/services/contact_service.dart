import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movil3431/entities/contact.dart';

class ContactService {
  Future<List<Contact>> getAllContacts() async {

    // con await retorna lo qe esta dentro del Future
    final response = await http.get(Uri.parse('https://68b5a32ae5dc090291afbd0d.mockapi.io/contacts'));

    if (response.statusCode != 200) {
      throw Exception("No se pudieron obtener los datos");
    }

    // si los datos son correctos
    final List<dynamic> data = jsonDecode(response.body);
    final List<Contact> contacts = [];

    for(var item in data) {
      Contact contact = Contact(
        name: item['name'],
        email: item['email'],
        phoneNumber: item['phoneNumber'],
      );

      contacts.add(contact);

    }

    return contacts;

  }

}