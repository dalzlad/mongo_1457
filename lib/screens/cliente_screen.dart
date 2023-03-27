import 'package:flutter/material.dart';
import 'package:mongo_1457/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongodart;

class ClienteScreen extends StatefulWidget {
  const ClienteScreen({super.key});

  @override
  State<ClienteScreen> createState() => _ClienteScreenState();
}

class _ClienteScreenState extends State<ClienteScreen> {
  final nit = TextEditingController();

  final nombre = TextEditingController();

  final celular = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Registrar Producto'),
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(controller: nit),
            SizedBox(height: 10,),
            TextFormField(controller: nombre),
            SizedBox(height: 10,),
            TextFormField(controller: celular),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
              insertarProducto();
            }, child: const Text('Registrar'))
          ]),
        ),
        
    );
  }
}

Future<void> insertarProducto() async{
  final id = mongodart.ObjectId();
  final datos = 
  await insertarProducto();
}