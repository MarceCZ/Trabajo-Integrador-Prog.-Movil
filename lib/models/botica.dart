class Botica {
  int id;
  String nombre;
  String logo;
  int cantidadProductos;

  // Constructor
  Botica({
    required this.id,
    required this.nombre,
    required this.logo,
    required this.cantidadProductos,
  });

  // Método toString
  @override
  String toString() {
    return 'Botica{id: $id, nombre: $nombre, logo: $logo, cantidadProductos: $cantidadProductos}';
  }

  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'logo': logo,
      'cantidad_productos': cantidadProductos,
    };
  }

  // Método fromMap
  static Botica fromMap(Map<String, dynamic> map) {
    return Botica(
      id: map['id'],
      nombre: map['nombre'],
      logo: map['logo'],
      cantidadProductos: map['cantidad_productos'],
    );
  }
}
