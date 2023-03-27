// To parse this JSON data, do
//
//     final productosDb = productosDbFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

class ProductosDb {
    ProductosDb({
        required this.id,
        required this.nit,
        required this.nombre,
        required this.celular,
    });

    ObjectId id;
    final int nit;
    final String nombre;
    final String celular;

    factory ProductosDb.fromJson(String str) => ProductosDb.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProductosDb.fromMap(Map<String, dynamic> json) => ProductosDb(
        id: json["_id"],
        nit: json["nit"],
        nombre: json["nombre"],
        celular: json["celular"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "nit": nit,
        "nombre": nombre,
        "celular": celular,
    };
}
