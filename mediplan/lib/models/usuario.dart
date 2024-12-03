class Usuario {
  int idUsuario;
  String correo;
  String contrasena;
  DateTime? fechaNacimiento; // Ahora es opcional
  String? nombres; // Ahora es opcional
  String? apellidos; // Ahora es opcional
  double? altura; // Ahora es opcional
  double? peso; // Ahora es opcional
  String? sexo; // Ahora es opcional
  String? condicionesMedicas; // Ahora es opcional
  String? alergias; // Ahora es opcional
  String? celular; // Ahora es opcional
  String? otros; // Ahora es opcional

  // Constructor con parámetros opcionales
  Usuario({
    required this.idUsuario,
    required this.correo,
    required this.contrasena,
    this.fechaNacimiento,
    this.nombres,
    this.apellidos,
    this.altura,
    this.peso,
    this.sexo,
    this.condicionesMedicas,
    this.alergias,
    this.celular,
    this.otros,
  });

  @override
  String toString() {
    return 'Usuario{idUsuario: $idUsuario, correo: $correo, contrasena: $contrasena, fechaNacimiento: $fechaNacimiento, nombres: $nombres, apellidos: $apellidos, altura: $altura, peso: $peso, sexo: $sexo, condicionesMedicas: $condicionesMedicas, alergias: $alergias, celular: $celular, otros: $otros}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': idUsuario,//idUsuario a id
      'correo': correo,
      'contrasena': contrasena,
      'fecha_nacimiento': fechaNacimiento //fechaNacimiento a fecha_nacimiento
          ?.toIso8601String(), // Convertir a string para JSON si no es nulo
      'nombres': nombres,
      'apellidos': apellidos,
      'altura': altura,
      'peso': peso,
      'sexo': sexo,
      'condiciones_medicas': condicionesMedicas,//condicionesMedicas a condiciones_medicas
      'alergias': alergias,
      'celular': celular != null ? int.tryParse(celular!) : null,
      'otros': otros,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      idUsuario: map['id'],//idUsuario a id
      correo: map['correo'],
      contrasena: map['contrasena'],
      fechaNacimiento: map['fecha_nacimiento'] != null
          ? DateTime.parse(map['fecha_nacimiento']) // fechaNacimiento a fecha_nacimiento
          : null, // Convertir a DateTime solo si no es nulo
      nombres: map['nombres'],
      apellidos: map['apellidos'],
      altura: map['altura'],
      peso: map['peso'],
      sexo: map['sexo'],
      condicionesMedicas: map['condiciones_medicas'], //condicionesMedicas a condiciones_medicas
      alergias: map['alergias'],
      celular: map['celular']?.toString(),
      otros: map['otros'],
    );
  }
}
