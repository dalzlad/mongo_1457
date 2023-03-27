//import 'dart:developer';

import 'dart:async';

import 'package:mongo_1457/context.dart';
import 'package:mongo_1457/models/producto.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static late Db db;
  static late DbCollection coleccion;

  static connect() async {
    db = await Db.create(mongoUrl);
    await db.open();
    //inspect(db);
    var status = db.serverStatus();
    //print(status);
    coleccion = db.collection(collectionName);
    /*await coleccion.insertOne({
      "codigo": 77,
      "nombre": 'Aceite de Oliva',
      "precio": 23000
    });*/
  }

  //Inserción
  static insert(ProductosDb producto) async {
      await coleccion.insertOne(producto.toMap());
  }


  //Listar
  static Future<List<Map<String, dynamic>>> Listar() async {
    try {
      final productos = await coleccion.find().toList();
      print(productos);
      return productos;
    } catch (e) {
      //print(e);
      return Future.value(e as FutureOr<List<Map<String, dynamic>>>?);
    }
  }


  static Future<String> update(ProductosDb producto) async {
    try{
    var result = await coleccion.updateOne(where.eq('_id', producto.id), 
    modify.set('precio', producto.precio));
    if(result.isSuccess){
      print('Registro modificado');
      return('Registro modificado');
    }
    else{
      print('Se presentaron problemas en la modificación');
      return('Se presentaron problemas en la modificación');
    }
    }catch(e){
      print(e.toString());
      return(e.toString());
    }
  }
  

}