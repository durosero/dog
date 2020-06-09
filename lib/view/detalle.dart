import 'dart:convert';
import 'dart:io';

import 'package:dogs/model/Dog.dart';
import 'package:dogs/provider/dog_provider.dart';
import 'package:dogs/util/global.dart';
import 'package:flutter/material.dart';

class Detalle extends StatefulWidget {
  @override
  _DetalleState createState() => _DetalleState();
}

class _DetalleState extends State<Detalle> {
  Dog perro = new Dog();
  final dogProvider = new DogProvider();

  TextEditingController txtName = new TextEditingController();
  TextEditingController txtAge = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //si se envian parametros los asiganamos al objeto perro
    if (ModalRoute.of(context).settings.arguments != null) {
      perro = ModalRoute.of(context).settings.arguments;
      txtName.text = perro.name;
      txtAge.text = perro.age.toString();
    }


    return Scaffold(
      appBar: AppBar(
        title: Text((perro?.id==null)?"Nuevo registro":"Editar registro"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                _crearInputs(),
                SizedBox(
                  height: 10,
                ),
                _crearBotones(context)
              ],
            ),
          ),
        ),
      ),
      
    );
  }

  Widget _crearInputs() {
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: "Nombre del perro"),
            controller: txtName,
            onChanged: (value) {
              perro.name = value;
            },
          ),
          TextField(
            decoration: InputDecoration(hintText: "Edad del perro"),
            controller: txtAge,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              print(value);
              perro.age = (int.parse(value) == null) ? 0 : int.parse(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _crearBotones(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              child: Text("Guardar"),
              onPressed: () => _guardarDog(context, perro),
              color: Colors.green,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: RaisedButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "lista");
              },
            ),
          )
        ],
      ),
    );
  }

  void _guardarDog(BuildContext context, Dog dog) async {
    int result = 0;

    if (dog.id == null) {
      result = await dogProvider.insertDog(dog);
    } else {
      result = await dogProvider.updateDog(dog);
    }

    if (result > 0) {
      showWebColoredToast("Registro guardado");
      Navigator.pushReplacementNamed(context, "lista");
    } else {
      showWebColoredToast("Error al guardar el registro $result");
    }
  }
}
