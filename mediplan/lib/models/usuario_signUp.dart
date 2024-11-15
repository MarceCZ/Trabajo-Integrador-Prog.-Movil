class UsuarioSignUp {
  String nombres;
  String apellidos;
  String correo;
  String celular;
  String fechaNacimiento;
  String contrasena;
  String? altura;
  String? peso;
  String? sexo;
  String? condicionesMedicas;
  String? alergias;
  String? otros;

  UsuarioSignUp({
    required this.nombres,
    required this.apellidos,
    required this.correo,
    required this.celular,
    required this.fechaNacimiento,
    required this.contrasena,
    this.altura,
    this.peso,
    this.sexo,
    this.condicionesMedicas,
    this.alergias,
    this.otros,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombres': nombres,
      'apellidos': apellidos,
      'correo': correo,
      'celular': celular,
      'fechaNacimiento': fechaNacimiento,
      'contrasena': contrasena,
      'altura': altura,
      'peso': peso,
      'sexo': sexo,
      'condiciones_medicas': condicionesMedicas,
      'alergias': alergias,
      'otros': otros,
    };
  }
}
