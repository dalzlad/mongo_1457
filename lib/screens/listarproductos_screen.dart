import 'package:flutter/material.dart';
import 'package:mongo_1457/mongodb.dart';
import 'package:mongo_1457/models/producto.dart';
import 'package:mongo_dart/mongo_dart.dart' as MongoDart;

class ListarProductosScreen extends StatefulWidget {
  const ListarProductosScreen({super.key});

  @override
  State<ListarProductosScreen> createState() => _ListarProductosScreenState();
}

class _ListarProductosScreenState extends State<ListarProductosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Productos'),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 2, 149, 39),
      ),
        body: FutureBuilder(
        future: MongoDatabase.Listar(),
        builder: (context, snapshot) {
           if (snapshot.hasData) {
              return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                    var imagen = "${snapshot.data?[index]['codigo']}"".jpg";
                    final producto = ProductosDb(id: snapshot.data?[index]['_id'], 
                    codigo: snapshot.data?[index]['codigo'], 
                    nombre: snapshot.data?[index]['nombre'], 
                    precio: snapshot.data?[index]['precio']);
                    return Column(
                            children:[
                              ListTile(
                                leading: Image.asset('lib/assets/img/${imagen}'),
                                title:Text("${snapshot.data?[index]['nombre']}"),
                                subtitle: Text("${snapshot.data?[index]['precio']}"),
                                trailing: Icon(Icons.edit),  
                                onTap: () {
                                  Navigator.push(context, 
                                  MaterialPageRoute(builder: (context) => 
                                  Editar(producto)
                                  ,)  );
                                },   
                                
                                ),
                            ],
                          );
                    }
              );
           }
           else if (snapshot.hasError) {
                return Text("${snapshot.error}");
           }

           return const CircularProgressIndicator();
        }
        ),

         bottomNavigationBar: BottomNavigationBar(
         items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
      ),
    );
  }
}

class Editar extends StatelessWidget {
  final ProductosDb producto;

  Editar(this.producto, {super.key});
  
  final codigo = TextEditingController();

  final nombre = TextEditingController();

  final precio = TextEditingController();

  @override
  Widget build(BuildContext context) {
  codigo.text = producto.codigo.toString();
  nombre.text = producto.nombre.toString();
  precio.text = producto.precio.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Producto'),
        elevation: 0,
      ),

      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(controller: codigo),
            const SizedBox(height:10),
            TextFormField(controller: nombre,),
            const SizedBox(height:10),
            TextFormField(controller: precio,),
            const SizedBox(height:10),
            
             ElevatedButton(onPressed: () { 
              final dato = ProductosDb(id: producto.id, 
              codigo: int.parse(codigo.text), 
              nombre: nombre.text, 
              precio: int.parse(precio.text));
              MongoDatabase.update(dato);
              Navigator.pop(context);
                          //setState(() {});
              }, child: const Text('Guardar'),) 

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