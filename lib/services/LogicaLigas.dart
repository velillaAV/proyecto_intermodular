import 'package:proyecto_intermodular/models/ModeloLigaEspecial.dart';

import '../models/liga.dart';
import '../models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Logicaligas {
  // Cambia 'localhost' por tu IP para móvil, ej: '192.168.1.100'
  final String baseUrl = 'http://localhost:3000'; // Para móvil: 'http://TU_IP:3000'

  static final List<Liga> _listaLigas = [];
  static final List<Liga> _listaLigasNormales = [];
  static final List<Liga> _listaLigasEspeciales = [];

  void _anadirLigaNormal(Liga liga) {
    _listaLigas.add(liga);
    _listaLigasNormales.add(liga);
  }

  void _anadirLigaEspecial(Liga liga) {
    _listaLigas.add(liga);
    _listaLigasEspeciales.add(liga);
  }

  static List<Liga> getLigas() {
    return _listaLigas;
  }

  static List<Liga> getLigasNormales() {
    return _listaLigasNormales;
  }

  static List<Liga> getLigasEspeciales() {
    return _listaLigasEspeciales;
  }

  static Liga? buscarLigaPorNombre(String nombre) {
    final nombreTrim = nombre.trim().toLowerCase();
    final coincidencias = _listaLigas.where(
      (liga) => liga.nombreLiga.trim().toLowerCase() == nombreTrim,
    );
    return coincidencias.isEmpty ? null : coincidencias.first;
  }

  static Future<void> cargarLigasDesdeBackend() async {
    final response = await http.get(Uri.parse('$baseUrl/ligas'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      _listaLigas.clear();
      _listaLigasNormales.clear();
      _listaLigasEspeciales.clear();
      for (var jsonLiga in data) {
        // Crear liga desde JSON
        // Asumir que hay un fromJson o crear manualmente
        // Por simplicidad, crear Liga básica
        // Pero para especial, verificar tipo
        if (jsonLiga['tipo'] == 'especial') {
          // Crear Modeloligaespecial
        } else {
          Liga liga = Liga(
            id_liga: jsonLiga['id_liga'],
            cod_invitacion: jsonLiga['cod_invitacion'],
            propietario: null, // Necesitaría buscar usuario por id
            nombreLiga: jsonLiga['nombre'],
            capDeParticipantes: jsonLiga['cap_de_participantes'],
            hayClausulazos: false, // Asumir
          );
          _listaLigas.add(liga);
          _listaLigasNormales.add(liga);
        }
      }
    }
  }

  static Future<Liga> crearLigaNormal(String nombre, User propietario, int numParticipantes, bool clausulas) async {
    final nuevaLiga = Liga(
      id_liga: _listaLigas.length + 1,
      cod_invitacion: _listaLigas.length + 100,
      propietario: propietario,
      nombreLiga: nombre.trim(), capDeParticipantes: numParticipantes, hayClausulazos: clausulas,
    );
    nuevaLiga.insertarPropietario();
    _listaLigas.add(nuevaLiga);
    _listaLigasNormales.add(nuevaLiga);

    // Enviar al backend
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/ligas'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nombre': nombre.trim(),
          'cod_invitacion': nuevaLiga.cod_invitacion,
          'propietario_id': propietario.id_usuario,
          'tipo': 'normal',
          'cap_de_participantes': numParticipantes,
          'fase': 'Fase de Grupos: Jornada 1'
        }),
      );
      if (response.statusCode == 201) {
        // Actualizar id_liga con el del backend si es necesario
        var data = json.decode(response.body);
        nuevaLiga.id_liga = data['id_liga'];
      }
    } catch (e) {
      print('Error enviando liga al backend: $e');
    }

    return nuevaLiga;
  }

   static Modeloligaespecial crearLigaEspecial(String nombre, User propietario, int numParticipantes) {
    final nuevaLiga = Modeloligaespecial(
      id_liga: _listaLigas.length + 1,
      cod_invitacion: _listaLigas.length + 100,
      propietario: propietario,
      nombreLiga: nombre.trim(), capDeParticipantes: numParticipantes, hayClausulazos: false,
    );
    nuevaLiga.insertarPropietario();
    _listaLigas.add(nuevaLiga);
    _listaLigasEspeciales.add(nuevaLiga);
    return nuevaLiga;
  }

  static bool unirUsuarioALiga(String nombre, User usuario) {
    final liga = buscarLigaPorNombre(nombre);
    if (liga == null) {
      return false;
    }
    final yaEsParticipante = liga.participantes
        .any((participante) => participante.getNombre() == usuario.getNombre());
    if (!yaEsParticipante) {
      liga.participantes.add(usuario); 
      return true;
    }
    return false;
   
  }

  
}
