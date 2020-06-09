import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

class DatabaseHelper {
  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Obtenga la ruta del directorio para Android e iOS para almacenar la base de datos.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'doggie_database.db';
    // await deleteDatabase(path);

    // Establece la versión. Esto ejecuta la función onCreate y proporciona una
    // ruta para realizar actualizacones y defradaciones en la base de datos.
    var dogDatabase =
        await openDatabase(path, version: 1, onCreate: (db, version) {
      // Cuando la base de datos se crea por primera vez, crea una tabla para almacenar dogs
      // Ejecuta la sentencia CREATE TABLE en la base de datos
      return db.execute(
        "CREATE TABLE dogs(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)",
      );
    });
    return dogDatabase;
  }
}
