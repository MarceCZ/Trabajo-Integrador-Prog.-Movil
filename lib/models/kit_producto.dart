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
}
