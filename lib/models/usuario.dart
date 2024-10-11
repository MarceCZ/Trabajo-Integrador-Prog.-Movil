class Usuario {
  int idUsuario;
  String correo;
  DateTime? fechaNacimiento; // Ahora es opcional
  String? nombres;            // Ahora es opcional
  String? apellidos;          // Ahora es opcional
  double? altura;             // Ahora es opcional
  double? peso;               // Ahora es opcional
  String? sexo;               // Ahora es opcional
  String? condicionesMedicas;  // Ahora es opcional
  String? alergias;           // Ahora es opcional
  String? celular;            // Ahora es opcional
  String? otros;              // Ahora es opcional

  // Constructor con parámetros opcionales
  Usuario({
    required this.idUsuario,
    required this.correo,
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
    return 'Usuario{idUsuario: $idUsuario, correo: $correo, fechaNacimiento: $fechaNacimiento, nombres: $nombres, apellidos: $apellidos, altura: $altura, peso: $peso, sexo: $sexo, condicionesMedicas: $condicionesMedicas, alergias: $alergias, celular: $celular, otros: $otros}';
  }

  Map<String, dynamic> toJson() {
    return {
      'idUsuario': idUsuario,
      'correo': correo,
      'fechaNacimiento': fechaNacimiento?.toIso8601String(), // Convertir a string para JSON si no es nulo
      'nombres': nombres,
      'apellidos': apellidos,
      'altura': altura,
      'peso': peso,
      'sexo': sexo,
      'condicionesMedicas': condicionesMedicas,
      'alergias': alergias,
      'celular': celular,
      'otros': otros,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      idUsuario: map['idUsuario'],
      correo: map['correo'],
      fechaNacimiento: map['fechaNacimiento'] != null ? DateTime.parse(map['fechaNacimiento']) : null, // Convertir a DateTime solo si no es nulo
      nombres: map['nombres'],
      apellidos: map['apellidos'],
      altura: map['altura'],
      peso: map['peso'],
      sexo: map['sexo'],
      condicionesMedicas: map['condicionesMedicas'],
      alergias: map['alergias'],
      celular: map['celular'],
      otros: map['otros'],
    );
  }
}
