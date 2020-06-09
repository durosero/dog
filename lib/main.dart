import 'package:dogs/view/detalle.dart';
import 'package:dogs/view/listar.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
     // home: Listar(),
      initialRoute: "lista",
      routes: {
        'lista': (context) => Listar(),
        'detalle': (context) => Detalle(),
      },
    );
  }
}