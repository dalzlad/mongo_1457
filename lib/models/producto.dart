// To parse this JSON data, do
//
//     final productosDb = productosDbFromMap(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

class ProductosDb {
    ProductosDb({
        required this.id,
        required this.codigo,
        required this.nombre,
        required this.precio,
    });

    ObjectId id;
    final int codigo;
    final String nombre;
    final int precio;

    factory ProductosDb.fromJson(String str) => ProductosDb.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProductosDb.fromMap(Map<String, dynamic> json) => ProductosDb(
        id: json["_id"],
        codigo: json["codigo"],
        nombre: json["nombre"],
        precio: json["precio"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "codigo": codigo,
        "nombre": nombre,
        "precio": precio,
    };
}
