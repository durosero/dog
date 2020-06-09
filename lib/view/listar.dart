import 'package:dogs/model/Dog.dart';
import 'package:dogs/provider/dog_provider.dart';
import 'package:dogs/util/global.dart';
import 'package:flutter/material.dart';

class Listar extends StatefulWidget {
  @override
  _ListarState createState() => _ListarState();
}

class _ListarState extends State<Listar> {
  final dogProvider = new DogProvider();

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "detalle");
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Lista de Dogs'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _cargarDatos,
          )
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: dogProvider.dogs(),
          builder: (BuildContext context, AsyncSnapshot<List<Dog>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _listaProductos(snapshot.data);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  void _cargarDatos() {
    //volvemos a dibujar
    setState(() {});
  }

  Widget _listaProductos(List<Dog> listaDogs) {
    return ListView.builder(
      itemCount: listaDogs.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext contex, int index) {
        return Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.red,
            child: Center(
              child: Text("Eliminar"),
            ),
          ),
          child: ListTile(
            subtitle: Text(listaDogs[index].age.toString() + " años"),
            title: Text(listaDogs[index].name),
            trailing: Text(listaDogs[index].id.toString()),
            onTap: () {
              Navigator.pushNamed(context, "detalle",
                  arguments: listaDogs[index]);
            },
          ),
          onDismissed: (direccion) {
            _eliminarProducto(listaDogs[index]);
          },
        );
      },
    );
  }

  void _eliminarProducto(Dog dog) async {
    int result = await dogProvider.deleteDog(dog);

    if (result > 0) {
      showWebColoredToast("Registro eliminado");
    } else {
      showWebColoredToast("Error al eliminar el registro");
      _cargarDatos();
    }
  }
}
