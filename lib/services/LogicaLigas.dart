import 'package:proyecto_intermodular/models/ModeloLigaEspecial.dart';
import 'package:proyecto_intermodular/services/backend_config.dart';

import '../models/liga.dart';
import '../models/user.dart';
import '../models/ModeloUsuario.dart';
import '../services/LogicaUsuarios.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Logicaligas {
  static const String baseUrl = backendBaseUrl;

  static final List<Liga> _listaLigas = [];
  static final List<Liga> _listaLigasNormales = [];
  static final List<Liga> _listaLigasEspeciales = [];

  static Future<bool> existeLigaNombre(String nombre) async {
    final liga = await buscarLigaPorNombre(nombre);
    return liga != null;
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

  static Future<Liga?> buscarLigaPorNombre(String nombre) async {
    final nombreTrim = nombre.trim().toLowerCase();
    final coincidencias = _listaLigas.where(
      (liga) => liga.nombreLiga.trim().toLowerCase() == nombreTrim,
    );
    if (coincidencias.isNotEmpty) return coincidencias.first;

    // No está en caché; preguntar al backend
    try {
      final uri = Uri.parse('$baseUrl/ligas/nombre/${Uri.encodeComponent(nombre.trim())}');
      final response = await http.get(uri).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final jsonLiga = json.decode(response.body);
        User propietario = User(
          id_usuario: jsonLiga['propietario_id'],
          nombre: jsonLiga['propietario_nombre'] ?? 'Desconocido',
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

        // Añadir a listas locales para cache
        _listaLigas.add(liga);
        _listaLigasNormales.add(liga);
        return liga;
      }
    } catch (e) {
      print('Error buscando liga por nombre en backend: $e');
    }
    return null;
  }

  /// Buscar liga por código de invitación (pregunta al backend si es necesario)
  static Future<Liga?> buscarLigaPorCodigo(int codigo) async {
    // Primero buscar en caché
    final coincidencias = _listaLigas.where((l) => l.cod_invitacion == codigo);
    if (coincidencias.isNotEmpty) return coincidencias.first;

    // Obtener todas las ligas y buscar código
    try {
      final uri = Uri.parse('$baseUrl/ligas');
      final response = await http.get(uri).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        for (var jsonLiga in data) {
          if ((jsonLiga['cod_invitacion'] ?? jsonLiga['cod']) == codigo) {
            User propietario = User(
              id_usuario: jsonLiga['propietario_id'],
              nombre: jsonLiga['propietario_nombre'] ?? 'Desconocido',
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
            return liga;
          }
        }
      }
    } catch (e) {
      print('Error buscando liga por codigo en backend: $e');
    }
    return null;
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

            // Usar participantes incluidos en la respuesta de ligas si existen
            if (jsonLiga['participantes'] != null && jsonLiga['participantes'] is List) {
              try {
                for (var userJson in (jsonLiga['participantes'] as List<dynamic>)) {
                  final participante = User.fromJson(userJson as Map<String, dynamic>);
                  liga.participantes.add(participante);
                }
              } catch (e) {
                // ignorar errores de parseo
              }
            } else {
              // Fallback: pedir participantes por separado
              try {
                final partesUri = Uri.parse('$baseUrl/ligas/${liga.id_liga}/participantes');
                final partResp = await http.get(partesUri).timeout(const Duration(seconds: 10));
                if (partResp.statusCode == 200) {
                  final lista = json.decode(partResp.body) as List<dynamic>;
                  for (var userJson in lista) {
                    try {
                      final participante = User.fromJson(userJson);
                      liga.participantes.add(participante);
                    } catch (_) {}
                  }
                }
              } catch (e) {
                // ignorar errores de participantes
              }
            }

            if (usuarioId != null && Logicausuario.getUsuarioActual().id_usuario == usuarioId) {
              final usuarioActual = Logicausuario.getUsuarioActual();
              // Asegurar que el usuario actual esté en la lista de participantes
              if (!liga.participantes.any((p) => p.id_usuario == usuarioActual.id_usuario)) {
                liga.participantes.add(usuarioActual);
              }

              Modelousuario? usuarioLigaExistente;
              for (final usuarioLiga in usuarioActual.usuario_ligas) {
                if (usuarioLiga.ligaPerteneciente.id_liga == liga.id_liga) {
                  usuarioLigaExistente = usuarioLiga;
                  break;
                }
              }

              if (usuarioLigaExistente != null) {
                usuarioLigaExistente.ligaPerteneciente = liga;
              } else {
                final usuarioLiga = Modelousuario()..ligaPerteneciente = liga;
                usuarioActual.usuario_ligas.add(usuarioLiga);
              }
            }

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

  static Future<bool> unirUsuarioALiga(String nombre, User usuario) async {
    final liga = await buscarLigaPorNombre(nombre);
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
