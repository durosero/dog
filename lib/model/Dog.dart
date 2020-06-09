import 'package:sqflite/sqflite.dart';

class Dog {
  int _id;
  String _name;
  int _age;
  Dog();
  //Dog(this.name, this.age);

  // Convierte en un Map. Las llaves deben corresponder con los nombres de las
  // columnas en la base de datos.
  Map<String, dynamic> toMap() {
    return {
     // 'id': this._id,
      'name': this._name,
      'age': this._age,
    };
  }

  String toString() {
    String data = "{ id:$_id,name:$_name,age:$_age }";
    return data;
  }

  int get id => _id;
  String get name => _name;
  int get age => _age;

  set id(int newid) {
    this._id = newid;
  }

  set name(String newname) {
    this._name = newname;
  }

  set age(int newage) {
    this._age = newage;
  }
}
