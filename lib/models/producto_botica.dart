import 'dart:convert';

class ProductoBotica {
  int id;
  String nombre;
  String marca;
  double precio;
  String descripcion;
  String contraindicaciones;
  String advertencias;
  String imagen;
  String presentacion;
  int stock;
  bool requiereReceta;
  int idBotica;
  String botica;

  // Constructor
  ProductoBotica({
    required this.id,
    required this.nombre,
    required this.marca,
    required this.precio,
    required this.descripcion,
    required this.contraindicaciones,
    required this.advertencias,
    required this.imagen,
    required this.presentacion,
    required this.stock,
    required this.requiereReceta,
    required this.idBotica,
    required this.botica,
  });

  // Método toString
  @override
  String toString() {
    return 'Producto{id: $id, nombre: $nombre, marca: $marca, precio: $precio, descripcion: $descripcion, '
        'contraindicaciones: $contraindicaciones, advertencias: $advertencias, imagen: $imagen, '
        'presentacion: $presentacion, stock: $stock, requiereReceta: $requiereReceta, '
        'idBotica: $idBotica, botica: $botica}';
  }

  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'marca': marca,
      'precio': precio,
      'descripcion': descripcion,
      'contraindicaciones': contraindicaciones,
      'advertencias': advertencias,
      'imagen': imagen,
      'presentacion': presentacion,
      'stock': stock,
      'requiere_receta': requiereReceta,
      'id_botica': idBotica,
      'botica': botica,
    };
  }

  // Método fromMap
  static ProductoBotica fromMap(Map<String, dynamic> map) {
    return ProductoBotica(
      id: map['id'],
      nombre: map['nombre'],
      marca: map['marca'],
      precio: map['precio'],
      descripcion: map['descripcion'],
      contraindicaciones: map['contraindicaciones'],
      advertencias: map['advertencias'],
      imagen: map['imagen'],
      presentacion: map['presentacion'],
      stock: map['stock'],
      requiereReceta: map['requiere_receta'],
      idBotica: map['id_botica'],
      botica: map['botica'],
    );
  }
}
