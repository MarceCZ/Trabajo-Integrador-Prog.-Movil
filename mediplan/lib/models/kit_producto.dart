import 'dart:convert';

class KitProducto {
  int id;
  String nombre;
  String marca;
  String imagen;
  double subTotal;
  int cantidadProducto;
  String botica;
  int idKit;
  bool receta;

  // Constructor
  KitProducto({
    required this.id,
    required this.nombre,
    required this.marca,
    required this.imagen,
    required this.subTotal,
    required this.cantidadProducto,
    required this.botica,
    required this.idKit,
    required this.receta,
  });

  // Método toString
  @override
  String toString() {
    return 'KitProducto{id: $id, nombre: $nombre, marca: $marca, imagen: $imagen, sub_total: $subTotal, cantidad_productos: $cantidadProducto, botica: $botica, id_kit: $idKit, receta: $receta}';
  }

  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'marca': marca,
      'imagen': imagen,
      'sub_total': subTotal,
      'cantidad_productos': cantidadProducto,
      'botica': botica,
      'id_kit': idKit,
      'receta': receta,
    };
  }

  // Método fromMap
  static KitProducto fromMap(Map<String, dynamic> map) {
    return KitProducto(
      id: map['id'],
      nombre: map['nombre'],
      marca: map['marca'],
      imagen: map['imagen'],
      subTotal: map['sub_total'],
      cantidadProducto: map['cantidad_productos'],
      botica: map['botica'],
      idKit: map['id_kit'],
      receta: map['receta'],
    );
  }

  
  static KitProducto fromMapService(Map<String, dynamic> map) {
    return KitProducto(
      id: map['producto_id'],
      nombre: map['producto_nombre'],
      marca: map['marca'],
      imagen: map['producto_imagen'],
      subTotal: map['subtotal'],
      cantidadProducto: map['cantidad'],
      botica: map['botica_nombre'],
      idKit: map['kit_id'],
      receta: _convertToBool(map['receta_imagen']),
    );
  }

  // Método auxiliar para convertir el valor de receta_imagen a bool
  static bool _convertToBool(dynamic value) {
    if (value is bool) {
      return value;
    } else if (value is int) {
      return value == 1;  // Si es 1, lo consideramos como true, de lo contrario false
    } else {
      return false;  // Por defecto si no es un valor esperado
    }
  }
}
