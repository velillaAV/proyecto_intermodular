import 'package:proyecto_intermodular/models/ModeloUsuario.dart';

class User {
  int? id_usuario;
  String nombre;
  String contrasena;
  String genero;
  int edad;
  String lugarNacimiento;
  String? fotoRuta;
  List<Modelousuario> usuario_ligas = [];
  


  bool isAdmin;
  bool isBlocked = false;
  User({
    this.id_usuario,
    required this.nombre,
    required this.contrasena,
    required this.genero,
    required this.edad,
    required this.lugarNacimiento,
    required this.fotoRuta,
    required this.isAdmin
  });

  String getNombre() {
    return nombre;
  }

  String getContrasena() {
    return contrasena;
  }

  String getGenero() {
    return genero;
  }

  int getEdad() {
    return edad;
  }

  String getLugarNacimiento() {
    return lugarNacimiento;
  }

  String? getFotoRuta() {
    return fotoRuta;
  }

  bool isAdminOrNo() {
    return isAdmin;
  }

  void setNombre(String nombre) {
    this.nombre = nombre;
  }

  void setContrasena(String contrasena) {
    this.contrasena = contrasena;
  }

  void setGenero(String genero) {
    this.genero = genero;
  }

  void setEdad(int edad) {
    this.edad = edad;
  }

  void setLugarNacimiento(String lugarNacimiento) {
    this.lugarNacimiento = lugarNacimiento;
  }

  void setFotoRuta(String? fotoRuta) {
    this.fotoRuta = fotoRuta; 
  }

  void blockear() {
    this.isBlocked = !isBlocked;
  }

  Modelousuario unirLiga() {
    Modelousuario nuevoEquipo = Modelousuario();
    usuario_ligas.add(nuevoEquipo);
    return nuevoEquipo;
  }

  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id_usuario: json['id_usuario'] ?? json['id'] ?? null,
      nombre: json['nombre'] ?? '',
      contrasena: json['contrasena'] ?? json['password'] ?? '',
      genero: json['genero'] ?? json['gender'] ?? '',
      edad: json['edad'] != null ? (json['edad'] as num).toInt() : 0,
      lugarNacimiento: json['lugarNacimiento'] ?? json['lugar_nacimiento'] ?? '',
      fotoRuta: json['fotoRuta'] ?? json['foto_ruta'] ?? null,
      isAdmin: json['isAdmin'] == true || json['is_admin'] == true,
    )..isBlocked = json['isBlocked'] == true || json['is_blocked'] == true;
  }

  Map<String, dynamic> toJson() {
    return {
      'id_usuario': id_usuario,
      'nombre': nombre,
      'contrasena': contrasena,
      'genero': genero,
      'edad': edad,
      'lugarNacimiento': lugarNacimiento,
      'fotoRuta': fotoRuta,
      'isAdmin': isAdmin,
      'isBlocked': isBlocked,
    };
  }
}
