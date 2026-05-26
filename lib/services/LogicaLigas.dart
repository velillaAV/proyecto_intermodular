import 'package:proyecto_intermodular/models/ModeloLigaEspecial.dart';
import 'package:proyecto_intermodular/services/backend_config.dart';

import '../models/liga.dart';
import '../models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Logicaligas {
  static const String baseUrl = backendBaseUrl;

  static final List<Liga> _listaLigas = [];
  static final List<Liga> _listaLigasNormales = [];
  static final List<Liga> _listaLigasEspeciales = [];

  static bool existeLigaNombre(String nombre) {
    return buscarLigaPorNombre(nombre) != null;
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

  static Future<void> cargarLigasDesdeBackend([int? usuarioId]) async {
    final uri = usuarioId != null
        ? Uri.parse('$baseUrl/ligas/usuario/$usuarioId')
        : Uri.parse('$baseUrl/ligas');
    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _listaLigas.clear();
        _listaLigasNormales.clear();
        _listaLigasEspeciales.clear();
        for (var jsonLiga in data) {
          if (jsonLiga['tipo'] == 'especial') {
            // Crear Modeloligaespecial si lo necesitas
          } else {
            User propietario = User(
              id_usuario: jsonLiga['propietario_id'],
              nombre: 'Desconocido',
              contrasena: '',
              genero: '',
              edad: 0,
              lugarNacimiento: '',
              fotoRuta: null,
              isAdmin: false,
            );
            Liga liga = Liga(
              id_liga: jsonLiga['id_liga'],
              cod_invitacion: jsonLiga['cod_invitacion'],
              propietario: propietario,
              nombreLiga: jsonLiga['nombre'],
              capDeParticipantes: jsonLiga['cap_participantes'] ?? jsonLiga['cap_de_participantes'] ?? 0,
              hayClausulazos: false,
            );
            _listaLigas.add(liga);
            _listaLigasNormales.add(liga);
          }
        }
      } else {
        print('Error cargando ligas: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error cargando ligas desde backend: $e');
    }
  }

  static Future<bool> unirUsuarioALigaBackend(Liga liga, User usuario) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ligas/${liga.id_liga}/unirse'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id_usuario': usuario.id_usuario,
      }),
    );

    return response.statusCode == 200;
  }

  static Future<Map<String, dynamic>> crearLigaNormal(String nombre, User propietario, int numParticipantes, bool clausulas) async {
    final cod = _listaLigas.length + 100;
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/ligas'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'nombre': nombre.trim(),
              'cod_invitacion': cod,
              'propietario_id': propietario.id_usuario,
              'tipo': 'normal',
              'cap_de_participantes': numParticipantes,
              'fase': 'Fase de Grupos: Jornada 1'
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        final nuevaLiga = Liga(
          id_liga: data['id_liga'] != null ? (data['id_liga'] as num).toInt() : _listaLigas.length + 1,
          cod_invitacion: cod,
          propietario: propietario,
          nombreLiga: nombre.trim(),
          capDeParticipantes: numParticipantes,
          hayClausulazos: clausulas,
        );
        nuevaLiga.insertarPropietario();
        _listaLigas.add(nuevaLiga);
        _listaLigasNormales.add(nuevaLiga);
        return {'success': true, 'liga': nuevaLiga};
      } else {
        final body = response.body;
        print('Error creando liga: ${response.statusCode} ${body}');
        return {'success': false, 'status': response.statusCode, 'error': body};
      }
    } catch (e) {
      print('Error enviando liga al backend: $e');
      return {'success': false, 'error': e.toString()};
    }
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
