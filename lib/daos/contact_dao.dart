
import 'package:movil3431/entities/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {

  Future<Database> openDB() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'contacts.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, phoneNumber TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> guardarContacto(Contact contact) async {
    final db = await openDB();
    final contactDB = {
      "name": contact.name,
      "email": contact.email,
      "phoneNumber": contact.phoneNumber,
    };
    await db.insert('contacts', contactDB);
    print('Contacto guardado');
  }

  Future<List<Contact>> getAll() async {
    final db = await openDB();
    final data = await db.query("contacts");

    return data.map((e) => Contact(
        name: e["name"] as String,
        email: e["email"] as String,
        phoneNumber: e["phoneNumber"] as String
    )).toList();
  }

  Future<Contact?> getContactByEmail(String email) async {
    final db = await openDB();
    final data = await db.query(
        "contacts",
        where: "email = ?",
        whereArgs: [email]
    );

    if (data.isEmpty) return null;
    final e = data.first;
    return Contact(
      name: e["name"] as String,
      email: e["email"] as String,
      phoneNumber: e["phoneNumber"] as String
    );

  }

}