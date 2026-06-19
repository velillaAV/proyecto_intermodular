import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_intermodular/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  // REGISTRO
  static Future<Map<String, dynamic>?> registerUser(
    String nombre,
    String contrasena,
    String genero,
    int edad,
    String lugarNacimiento,
    String? fotoRuta,
  ) async {
    final mSupaBase = Supabase.instance.client;

    try {
      await mSupaBase.from('usuarios').insert({
        'nombre': nombre,
        'contrasena': contrasena,
        'genero': genero,
        'edad': edad,
        'lugarnacimiento': lugarNacimiento,
        'fotoruta': '',
        'isadmin': false,
        'isblocked': false,
      });
      print('¡Registro insertado con éxito!');
      final response = await mSupaBase
          .from('usuarios')
          .select()
          .eq('nombre', nombre)
          .eq('contrasena', contrasena);

          print(response);

      // Si la lista no está vacía, devuelve el primer registro como Map
      if (response.isNotEmpty) {
        return response.first;
      }
    } catch (e) {
      print('Error al insertar el registro: $e');
    }
  }

  // LOGIN
  static Future<Map<String, dynamic>?> login(
    String nombre,
    String contrasena,
  ) async {
    try {
      final mSupaBase = Supabase.instance.client;

      // Ejecuta la consulta en Supabase
      final response = await mSupaBase
          .from('usuarios')
          .select()
          .eq('nombre', nombre)
          .eq('contrasena', contrasena);

          print(response);

      // Si la lista no está vacía, devuelve el primer registro como Map
      if (response.isNotEmpty) {
        return response.first;
      }
    } catch (e) {
      print('Error en login: $e');
    }

    // Devuelve null si no se encontró el usuario o hubo un error
    return null;
  }

  // OBTENER USUARIOS
  static Future<List<dynamic>> getUsuarios() async {
    final mSupaBase = Supabase.instance.client;
    final response = await mSupaBase.from('usuarios').select();
    return response
        .map(
          (json) => Usuario(
            nombre: json['nombre'],
            contrasena: json['contrasena'],
            genero: json['genero'],
            edad: (json['edad'] as num).toInt(),
            lugarNacimiento: json['lugarNacimiento'],
            fotoRuta: json['nonbre'],
            isAdmin: json['isadmin'] as bool,
          ),
        )
        .toList();
  }
}
