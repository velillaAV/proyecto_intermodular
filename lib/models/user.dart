import 'package:proyecto_intermodular/models/ModeloUsuario.dart';

class User {
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

  
}
