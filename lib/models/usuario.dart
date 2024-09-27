
class Usuario {
  int idUsuario;
  String correo;

  Usuario({required this.idUsuario, required this.correo});

  @override
  String toString() {
    return 'Usuario{idUsuario: $idUsuario, correo: $correo}';
  }

  Map<String, dynamic> toJson() {
    return {
      'idUsuario': idUsuario,
      'correo': correo,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      idUsuario: map['idUsuario'],
      correo: map['correo'],
    );
  }
}