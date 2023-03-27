import 'package:flutter/material.dart';
import 'package:mongo_1457/models/producto.dart';
import 'package:mongo_1457/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as MongoDart;

class ProductoScreen extends StatefulWidget {
 
  const ProductoScreen({super.key});
  
  @override
  State<ProductoScreen> createState() => _ProductoScreenState();
}

class _ProductoScreenState extends State<ProductoScreen> {
  final codigo = TextEditingController();
  final nombre = TextEditingController();
  final precio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Producto'),
        elevation: 0,
      ),

      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(controller: codigo,),
            const SizedBox(height:10),
            TextFormField(controller: nombre,),
            const SizedBox(height:10),
            TextFormField(controller: precio,),
            const SizedBox(height:10),
            ElevatedButton(onPressed: () {
              insertarProducto(int.parse(codigo.text), nombre.text, int.parse(precio.text));
            }, child: const Text('Registrar'))
          ],
        ),
      ),

    );
  }
}

Future<void> insertarProducto(codigo, nombre, precio) async{
    final id = MongoDart.ObjectId();
    final datos = ProductosDb(id:id, codigo: codigo, nombre:nombre, precio:precio);
    //print(datos.toJson());
    await MongoDatabase.insert(datos);
    
}