import 'dart:convert';

class Kit {
  int id;
  String tipo;
  DateTime fechaInicio;
  DateTime fechaFin;
  double total;
  String metodoPago;
  DateTime fechaEntrega;
  String estado;
  String departamento;
  String distrito;
  String direccion;
  String otro;
  int idUsuario;

  // Constructor
  Kit({
    required this.id,
    required this.tipo,
    required this.fechaInicio,
    required this.fechaFin,
    required this.total,
    required this.metodoPago,
    required this.fechaEntrega,
    required this.estado,
    required this.departamento,
    required this.distrito,
    required this.direccion,
    this.otro = '',
    required this.idUsuario,
  });

  // Método toString
  @override
  String toString() {
    return 'Kit{id: $id, tipo: $tipo, fechaInicio: $fechaInicio, fechaFin: $fechaFin, total: $total, metodoPago: $metodoPago, fechaEntrega: $fechaEntrega, estado: $estado, departamento: $departamento, distrito: $distrito, direccion: $direccion, otro: $otro, idUsuario: $idUsuario}';
  }

  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipo': tipo,
      'fecha_inicio': fechaInicio.toIso8601String(),
      'fecha_fin': fechaFin.toIso8601String(),
      'total': total,
      'metodo_pago': metodoPago,
      'fecha_entrega': fechaEntrega.toIso8601String(),
      'estado': estado,
      'departamento': departamento,
      'distrito': distrito,
      'direccion': direccion,
      'otro': otro,
      'idUsuario': 1,
    };
  }

  // Método fromMap
  static Kit fromMap(Map<String, dynamic> map) {
    return Kit(
      id: map['id'],
      tipo: map['tipo'],
      fechaInicio: DateTime.parse(map['fecha_inicio']),
      fechaFin: DateTime.parse(map['fecha_fin']),
      total: map['total'],
      metodoPago: map['metodo_pago'],
      fechaEntrega: DateTime.parse(map['fecha_entrega']),
      estado: map['estado'],
      departamento: map['departamento'],
      distrito: map['distrito'],
      direccion: map['direccion'],
      otro: map['otro'],
      idUsuario: map['idUsuario'],
    );
  }
}
