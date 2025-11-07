
import 'package:flutter/material.dart';
import 'package:movil3431/daos/contact_dao.dart';
import 'package:movil3431/entities/contact.dart';
import 'package:movil3431/services/contact_service.dart';
import 'package:movil3431/ui/pages/create_contact_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  List<Contact> contacts = [];

  Future<void> loadContacts() async {
    // final contactService = ContactService();
    // contacts = await contactService.getAllContacts();

    final contactDao = ContactDao();
    contacts = await contactDao.getAll();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateContactPage()),
            );
          },
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: loadContacts,
          child: ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(contact.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(contact.email),
                      Text(contact.phoneNumber),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}