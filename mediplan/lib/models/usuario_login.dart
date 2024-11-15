class UsuarioLogin {
  String correo;
  String contrasena;

  UsuarioLogin({
    required this.correo,
    required this.contrasena,
  });

  // Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'correo': correo,
      'contrasena': contrasena,
    };
  }

  factory UsuarioLogin.fromMap(Map<String, dynamic> map) {
    return UsuarioLogin(
      correo: map['correo'],
      contrasena: map['contrasena'],
    );
  }
}
