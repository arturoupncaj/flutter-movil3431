
import 'package:flutter/material.dart';
import 'package:movil3431/entities/contact.dart';

class HomePage extends StatelessWidget {

  final List<Contact> contacts = [
    Contact(name: 'Alice', email: 'alice@email.com', phoneNumber: '123-456-7890'),
    Contact(name: 'Bob', email: 'bobo@email.com', phoneNumber: '987-654-3210'),
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
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
    );
  }
}