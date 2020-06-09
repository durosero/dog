import 'dart:convert';

import 'package:dogs/config/database.dart';
import 'package:dogs/model/Dog.dart';
import 'package:sqflite/sqflite.dart';

class DogProvider extends DatabaseHelper{
  
//INSERTAR
  // A continuación, define la función para insertar dogs en la base de datos
Future<int> insertDog(Dog dog) async {
  // Obtiene una referencia de la base de datos
      Database db = await this.database;
  // Inserta el Dog en la tabla correcta. También puede especificar el
  // `conflictAlgorithm` para usar en caso de que el mismo Dog se inserte dos veces.
  // En este caso, reemplaza cualquier dato anterior.
  var  result =await db.insert(
    'dogs',
    dog.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  return result;
}

//LISTAR
// Un método que recupera todos los dogs de la tabla dogs
Future<List<Dog>> dogs() async {
  // Obtiene una referencia de la base de datos
  final Database db = await this.database;

  // Consulta la tabla por todos los Dogs.
  final List<Map<String, dynamic>> maps = await db.query('dogs');
  
    print(json.encode(maps)); // para visualizar el resultado en la consola

  // Convierte List<Map<String, dynamic> en List<Dog>.
  return List.generate(maps.length, (i) {
    Dog dog = new Dog();
    dog.id = maps[i]['id'];
    dog.name =  maps[i]['name'];
    dog.age = maps[i]['age'];
    return dog;
  });
}


//ACTUALIZAR
Future<int> updateDog(Dog dog) async {
  // Obtiene una referencia de la base de datos
  final Database db = await this.database;
  // Actualiza el Dog dado
   var result = await db.update(
    'dogs',
    dog.toMap(),
    // Aseguúrate de que solo actualizarás el Dog con el id coincidente
     where: "id = ?",
    // Pasa el id Dog a través de whereArg para prevenir SQL injection
    whereArgs: [dog.id],
  );
  return result;
}

//ELIMINAR
Future<int> deleteDog(Dog dog) async {
  // Obtiene una referencia de la base de datos
  final Database  db = await this.database;

  // Elimina el Dog de la base de datos
 var result = await db.delete(
    'dogs',
    // Utiliza la cláusula `where` para eliminar un dog específico
    where: "id = ?",
    // Pasa el id Dog a través de whereArg para prevenir SQL injection
    whereArgs: [dog.id],
  );
  return result;
}




}