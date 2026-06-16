import 'package:proyecto_intermodular/models/ModeloLigaEspecial.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/liga.dart';
import '../models/user.dart';
import '../models/ModeloUsuario.dart';
import '../services/LogicaUsuarios.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Logicaligas {
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
    final mSupaBase = Supabase.instance.client;
    int id_propietario;
    final nombreTrim = nombre.trim().toLowerCase();
    final coincidencias = _listaLigas.where(
      (liga) => liga.nombreLiga.trim().toLowerCase() == nombreTrim,
    );
    if (coincidencias.isNotEmpty) return coincidencias.first;

    // No está en caché; preguntar al backend
    final propietario = await mSupaBase
        .from('ligas')
        .select('propietario_id')
        .eq('nombre', nombre);

    id_propietario = propietario.first as int;
    final response = await mSupaBase
        .from('usuarios')
        .select()
        .eq('id', id_propietario);
    Usuario propietarioUs = Usuario(
      nombre: response.first['nombre'],
      contrasena: response.first['contrasena'],
      genero: response.first['genero'],
      edad: (response.first['edad'] as num).toInt(),
      lugarNacimiento: response.first['lugarNacimiento'],
      fotoRuta: response.first['nonbre'],
      isAdmin: response.first['isadmin'] as bool,
    );

    final liga = await mSupaBase.from('ligas').select().eq('nombre', nombre);

    Liga ligali = Liga(
      id_liga: liga.first['id_liga'],
      cod_invitacion: liga.first['cod_invitacion'],
      propietario: propietarioUs,
      nombreLiga: liga.first['nombre'],
      capDeParticipantes: liga.first['cap_participantes'] ?? 1,
      hayClausulazos: false,
    );

    // Añadir a listas locales para cache
    _listaLigas.add(ligali);
    _listaLigasNormales.add(ligali);
    return ligali;
  }

  /// Buscar liga por código de invitación (pregunta al backend si es necesario)
  static Future<Liga?> buscarLigaPorCodigo(int codigo) async {
    // Primero buscar en caché
    final mSupaBase = Supabase.instance.client;
    int id_propietario;
    final coincidencias = _listaLigas.where((l) => l.cod_invitacion == codigo);
    if (coincidencias.isNotEmpty) return coincidencias.first;

    // Obtener todas las ligas y buscar código
    // No está en caché; preguntar al backend
    final propietario = await mSupaBase
        .from('ligas')
        .select('propietario_id')
        .eq('cod_invitacion', codigo);

    id_propietario = propietario.first as int;
    final response = await mSupaBase
        .from('usuarios')
        .select()
        .eq('id', id_propietario);
    Usuario propietarioUs = Usuario(
      nombre: response.first['nombre'],
      contrasena: response.first['contrasena'],
      genero: response.first['genero'],
      edad: (response.first['edad'] as num).toInt(),
      lugarNacimiento: response.first['lugarNacimiento'],
      fotoRuta: response.first['nonbre'],
      isAdmin: response.first['isadmin'] as bool,
    );

    final liga = await mSupaBase.from('ligas').select().eq('cod_invitacion', codigo);

    Liga ligali = Liga(
      id_liga: liga.first['id_liga'],
      cod_invitacion: liga.first['cod_invitacion'],
      propietario: propietarioUs,
      nombreLiga: liga.first['nombre'],
      capDeParticipantes: liga.first['cap_participantes'] ?? 1,
      hayClausulazos: false,
    );

    // Añadir a listas locales para cache
    _listaLigas.add(ligali);
    _listaLigasNormales.add(ligali);
    return ligali;
  }

  static Future<void> cargarLigasDesdeBackend([int? usuarioId]) async {
  final mSupaBase = Supabase.instance.client;

  try {
    var query = mSupaBase.from('ligas').select('*, liga_participantes(*)');

    if (usuarioId != null) {
      query = query.eq('liga_participantes.id_usuario', usuarioId);
    }

    final data = await query.withConverter((data) => data);

    _listaLigas.clear();
    _listaLigasNormales.clear();
    _listaLigasEspeciales.clear();

    for (var jsonLiga in data) {
      
       final response = await mSupaBase
        .from('usuarios')
        .select()
        .eq('id', usuarioId!);

    Usuario propietarioUs = Usuario(
      nombre: response.first['nombre'],
      contrasena: response.first['contrasena'],
      genero: response.first['genero'],
      edad: (response.first['edad'] as num).toInt(),
      lugarNacimiento: response.first['lugarNacimiento'],
      fotoRuta: response.first['nonbre'],
      isAdmin: response.first['isadmin'] as bool,
    );
      // 5. Mapeo del objeto Liga
      Liga liga = Liga(
        id_liga: jsonLiga['id_liga'],
        cod_invitacion: jsonLiga['cod_invitacion'],
        nombreLiga: jsonLiga['nombre'],
        capDeParticipantes: jsonLiga['cap_participantes'] ?? 0,
        propietario: propietarioUs,
        hayClausulazos: false,
      );

      final List<dynamic> participantesJson = jsonLiga['liga_participantes'] ?? [];
      for (var userJson in participantesJson) {
        final participante = (userJson['id_usuario'] == Logicausuario.getUsuarioActual().id_usuario)
            ? Logicausuario.getUsuarioActual()
            : Usuario.fromJson(userJson);

        if (!participante.usuario_ligas.any((u) => u.ligaPerteneciente.id_liga == liga.id_liga)) {
          participante.usuario_ligas.add(Modelousuario()..ligaPerteneciente = liga);
        }
        liga.participantes.add(participante);
      } 
      
      _listaLigas.add(liga);

    if (jsonLiga['tipo'] == 'especial') {
        _listaLigasEspeciales.add(liga); 
      }else {
         _listaLigasNormales.add(liga);
      }
     
     
    }
  } catch (e) {
    print('Error cargando ligas con Supabase');
  }
}

  static Future<bool> unirUsuarioALigaBackend(
    Liga liga,
    Usuario usuario,
  ) async {
    final mSupaBase = Supabase.instance.client;
    await mSupaBase.from('liga_participantes').insert({
      'id_liga':liga.id_liga,
      'id_usuario':usuario.id_usuario
  });


    return true;
  }

  static Future<Map<String, dynamic>> crearLigaNormal(
  String nombre,
  Usuario propietario,
  int numParticipantes,
  bool clausulas,
) async {
  print('no llega tru?');
  final supabase = Supabase.instance.client;
  

  final cod = _listaLigas.length + 100;


    final response = await supabase.from('ligas').insert({
      'nombre': nombre,
      'cod_invitacion': cod,
      'propietario_id': propietario.id_usuario,
      'tipo': 'normal',
      'cap_de_participantes': numParticipantes,
      'fase': 'Fase de Grupos: Jornada 1',
      'clausulazos': clausulas, 
    });

    final nuevaLiga = Liga(
      id_liga: response['id_liga'] as int,
      cod_invitacion: cod,
      propietario: propietario,
      nombreLiga: nombre.trim(),
      capDeParticipantes: numParticipantes,
      hayClausulazos: clausulas,
    );

    // Lógica de estado local
    nuevaLiga.insertarPropietario();
    _listaLigas.add(nuevaLiga);
    _listaLigasNormales.add(nuevaLiga);

    return {'success': true, 'liga': nuevaLiga};

  
}
  static Future<Map<String, dynamic>> crearLigaEspecial(
    String nombre,
    Usuario propietario,
    int numParticipantes,
  ) async {
  final supabase = Supabase.instance.client;
  

  final cod = _listaLigas.length + 100;


    final response = await supabase.from('ligas').insert({
      'nombre': nombre,
      'cod_invitacion': cod,
      'propietario_id': propietario.id_usuario,
      'tipo': 'normal',
      'cap_de_participantes': numParticipantes,
      'fase': 'Fase de Grupos: Jornada 1',
      'clausulazos': false, 
    });

    final nuevaLiga = Liga(
      id_liga: response['id_liga'] as int,
      cod_invitacion: cod,
      propietario: propietario,
      nombreLiga: nombre.trim(),
      capDeParticipantes: numParticipantes,
      hayClausulazos: false,
    );

    nuevaLiga.insertarPropietario();
    _listaLigas.add(nuevaLiga);
    _listaLigasEspeciales.add(nuevaLiga);

    return {'success': true, 'liga': nuevaLiga};

  
}

  static Future<bool> unirUsuarioALiga(String nombre, Usuario usuario) async {
    final liga = await buscarLigaPorNombre(nombre);
    if (liga == null) {
      return false;
    }
    final yaEsParticipante = liga.participantes.any(
      (participante) => participante.getNombre() == usuario.getNombre(),
    );
    if (!yaEsParticipante) {
      liga.participantes.add(usuario);
      return true;
    }
    return false;
  }
}
