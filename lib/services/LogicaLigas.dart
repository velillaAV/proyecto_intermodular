import 'dart:convert';

import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloLigaEspecial.dart';
import 'package:proyecto_intermodular/models/ModeloPredicciones.dart';
import 'package:proyecto_intermodular/services/ServicioMercadoDiario.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/liga.dart';
import '../models/user.dart';

class Logicaligas {
  static final List<Liga> _listaLigas = [];
  static final List<Liga> _listaLigasNormales = [];
  static final List<Modeloligaespecial> _listaLigasEspeciales = [];

  static Future<bool> existeLigaNombre(String nombre) async {
    final mSupaBase = Supabase.instance.client;

    final liga = await mSupaBase.from('ligas').select().eq('nombre', nombre);

    if (liga.isEmpty) {
      return false;
    }

    return true;
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
      edad: response.first['edad'] as int,
      lugarNacimiento: response.first['lugarNacimiento'],
      fotoRuta: response.first['fotoruta'],
      isAdmin: response.first['isadmin'] as bool,
    );

    final liga = await mSupaBase
        .from('ligas')
        .select()
        .eq('nombre', nombre)
        .single();

    Liga ligali = Liga(
      id_liga: liga['id_liga'],
      cod_invitacion: liga['cod_invitacion'],
      propietario: propietarioUs,
      nombreLiga: liga['nombre'],
      capDeParticipantes: liga['cap_participantes'],
      hayClausulazos: false,
    );

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
      edad: response.first['edad'] as int,
      lugarNacimiento: response.first['lugarNacimiento'],
      fotoRuta: response.first['fotoruta'],
      isAdmin: response.first['isadmin'] as bool,
    );

    final liga = await mSupaBase
        .from('ligas')
        .select()
        .eq('cod_invitacion', codigo);

    Liga ligali = Liga(
      id_liga: liga.first['id_liga'],
      cod_invitacion: liga.first['cod_invitacion'] as int,
      propietario: propietarioUs,
      nombreLiga: liga.first['nombre'],
      capDeParticipantes: liga.first['cap_participantes'] as int,
      hayClausulazos: false,
    );

    // Añadir a listas locales para cache
    _listaLigas.add(ligali);
    _listaLigasNormales.add(ligali);
    return ligali;
  }

  static Future<void> cargarLigasDesdeBackend() async {
    final mSupaBase = Supabase.instance.client;

    try {
      var ligasJson = await mSupaBase.from('ligas').select();

      _listaLigas.clear();
      _listaLigasNormales.clear();
      _listaLigasEspeciales.clear();

      for (var jsonLiga in ligasJson) {
        if (jsonLiga.isEmpty) {
          print('No hay liga');
          continue;
        } else {
          //Cuando la Liga es normal seguimos unos pasos
          if (jsonLiga['tipo'] == 'normal') {
            int idpropietario = jsonLiga['propietario_id'] as int;
            int idliga = jsonLiga['id_liga'] as int;

            final response = await mSupaBase
                .from('usuarios')
                .select()
                .eq('id', idpropietario)
                .single();
            Usuario propietarioUs = Usuario(
              id_usuario: idpropietario,
              nombre: response['nombre'],
              contrasena: response['contrasena'],
              genero: response['genero'],
              edad: response['edad'] as int,
              lugarNacimiento: response['lugarnacimiento'],
              fotoRuta: ' ',
              isAdmin: response['isadmin'] as bool,
            );

            // 3. Mapeo del objeto Liga
            Liga liga = Liga(
              id_liga: idliga,
              cod_invitacion: jsonLiga['cod_invitacion'] as int,
              nombreLiga: jsonLiga['nombre'],
              capDeParticipantes: jsonLiga['cap_de_participantes'] as int,
              propietario: propietarioUs,
              hayClausulazos: false,
            );

            liga.mercado = await ServicioMercadoDiario().obtenerMercadoHoy(
              liga.id_liga,
            );

            var participantesJson = await mSupaBase
                .from('liga_participantes')
                .select()
                .eq('id_liga', idliga);
            for (var participanteJson in participantesJson) {
              int idUsuario = participanteJson['id_usuario'] as int;
              final usuarioJson = await mSupaBase
                  .from('usuarios')
                  .select()
                  .eq('id', idUsuario)
                  .single();
              Usuario participante = Usuario(
                id_usuario: idUsuario,
                nombre: usuarioJson['nombre'],
                contrasena: usuarioJson['contrasena'],
                genero: usuarioJson['genero'],
                edad: usuarioJson['edad'] as int,
                lugarNacimiento: usuarioJson['lugarnacimiento'],
                fotoRuta: '',
                isAdmin: usuarioJson['isadmin'] as bool,
              );

              liga.participantes.add(participante);
              participante.unirLiga();
              participante.usuario_ligas.last.ligaPerteneciente = liga;

              List<Modelojugador> equipo = [];
              List<Modelojugador> alineacion = [];
              List<Modelopredicciones> predicciones = [];
              List<int> listaIDS = (participanteJson['equipo'] as List<dynamic>)
                  .map((numero) => int.tryParse(numero.toString()) ?? 0)
                  .toList();

              List<int> listaIDSAli =
                  (participanteJson['alineacion'] as List<dynamic>)
                      .map((numero) => int.tryParse(numero.toString()) ?? 0)
                      .toList();

              List<int> listaIDSPre =
                  (participanteJson['predicciones'] as List<dynamic>)
                      .map((numero) => int.tryParse(numero.toString()) ?? 0)
                      .toList();
              for (int id_jugador in listaIDS) {
                if (id_jugador != 0) {
                  final jugadorJSON = await mSupaBase
                      .from('jugadores')
                      .select()
                      .eq('id_jugador', id_jugador)
                      .single();
                  Modelojugador jugador = Modelojugador(
                    id_jugador: id_jugador,
                    nombre: jugadorJSON['nombre'],
                    pais: jugadorJSON['pais'],
                    valor_clausula: (jugadorJSON['valor_clausula'] as int)
                        .toDouble(),
                    valor_venta: (jugadorJSON['valor_clausula'] as int)
                        .toDouble(),
                    posicion: jugadorJSON['posicion'],
                  );
                  equipo.add(jugador);
                }
              }

              for (int id_jugador in listaIDSAli) {
                if (id_jugador != 0) {
                  final jugadorJSON = await mSupaBase
                      .from('jugadores')
                      .select()
                      .eq('id_jugador', id_jugador)
                      .single();
                  Modelojugador jugador = Modelojugador(
                    id_jugador: id_jugador,
                    nombre: jugadorJSON['nombre'],
                    pais: jugadorJSON['pais'],
                    valor_clausula: (jugadorJSON['valor_clausula'] as int)
                        .toDouble(),
                    valor_venta: (jugadorJSON['valor_clausula'] as int)
                        .toDouble(),
                    posicion: jugadorJSON['posicion'],
                  );
                  alineacion.add(jugador);
                }
              }

              for (int id_prediccion in listaIDSPre) {
                if (id_prediccion != 0) {
                  final prediccionJSON = await mSupaBase
                      .from('prediccion')
                      .select()
                      .eq('id_prediccion', id_prediccion)
                      .single();
                  Modelopredicciones prediccion = Modelopredicciones(
                    id_prediccion: id_prediccion,
                    equipoLocal: prediccionJSON['equipo_local'],
                    equipoVisitante: prediccionJSON['equipo_visitante'],
                    fase: prediccionJSON['fase'],
                    golesLocal: prediccionJSON['goles_local'],
                    golesVisitante: prediccionJSON['goles_visitante'],
                  );
                  predicciones.add(prediccion);
                }
              }

              participante.usuario_ligas.last.equipo.equipo = equipo;
              participante.usuario_ligas.last.equipo.suplentes = equipo;
              participante.usuario_ligas.last.alineacion = alineacion;
              participante.usuario_ligas.last.predicciones = predicciones;
            }
            _listaLigasNormales.add(liga);
            _listaLigas.add(liga);

            //Cuando la Liga es especial seguimos otros pasos
          } else if (jsonLiga['tipo'] == 'especial') {
            int idpropietario = jsonLiga['propietario_id'] as int;
            int idliga = jsonLiga['id_liga'] as int;

            final response = await mSupaBase
                .from('usuarios')
                .select()
                .eq('id', idpropietario)
                .single();
            Usuario propietarioUs = Usuario(
              id_usuario: idpropietario,
              nombre: response['nombre'],
              contrasena: response['contrasena'],
              genero: response['genero'],
              edad: response['edad'] as int,
              lugarNacimiento: response['lugarnacimiento'],
              fotoRuta: ' ',
              isAdmin: response['isadmin'] as bool,
            );

            Liga liga = Liga(
              id_liga: idliga,
              cod_invitacion: jsonLiga['cod_invitacion'] as int,
              nombreLiga: jsonLiga['nombre'],
              capDeParticipantes: jsonLiga['cap_de_participantes'] as int,
              propietario: propietarioUs,
              hayClausulazos: false,
            );

            Modeloligaespecial ligaEspecial = Modeloligaespecial(
              id_liga: liga.id_liga,
              cod_invitacion: liga.cod_invitacion,
              propietario: liga.propietario,
              nombreLiga: liga.nombreLiga,
              capDeParticipantes: liga.capDeParticipantes,
              hayClausulazos: liga.hayClausulazos,
            );
            var participantesJson = await mSupaBase
                .from('liga_participantes')
                .select()
                .eq('id_liga', idliga);
            for (var participanteJson in participantesJson) {
              int idUsuario = participanteJson['id_usuario'] as int;
              final usuarioJson = await mSupaBase
                  .from('usuarios')
                  .select()
                  .eq('id', idUsuario)
                  .single();
              Usuario participante = Usuario(
                id_usuario: idUsuario,
                nombre: usuarioJson['nombre'],
                contrasena: usuarioJson['contrasena'],
                genero: usuarioJson['genero'],
                edad: usuarioJson['edad'] as int,
                lugarNacimiento: usuarioJson['lugarnacimiento'],
                fotoRuta: '',
                isAdmin: usuarioJson['isadmin'] as bool,
              );
              ligaEspecial.participantes.add(participante);
              participante.unirLiga();
              participante.usuario_ligas.last.ligaPerteneciente = ligaEspecial;

              List<Modelojugador> equipo = [];
              List<Modelojugador> alineacion = [];
              List<Modelopredicciones> predicciones = [];
              List<int> listaIDS = (participanteJson['equipo'] as List<dynamic>)
                  .map((numero) => int.tryParse(numero.toString()) ?? 0)
                  .toList();

              List<int> listaIDSAli =
                  (participanteJson['alineacion'] as List<dynamic>)
                      .map((numero) => int.tryParse(numero.toString()) ?? 0)
                      .toList();

              List<int> listaIDSPre =
                  (participanteJson['predicciones'] as List<dynamic>)
                      .map((numero) => int.tryParse(numero.toString()) ?? 0)
                      .toList();
              for (int id_jugador in listaIDS) {
                if (id_jugador != 0) {
                  final jugadorJSON = await mSupaBase
                      .from('jugadores')
                      .select()
                      .eq('id_jugador', id_jugador)
                      .single();
                  Modelojugador jugador = Modelojugador(
                    id_jugador: id_jugador,
                    nombre: jugadorJSON['nombre'],
                    pais: jugadorJSON['pais'],
                    valor_clausula: (jugadorJSON['valor_clausula'] as int)
                        .toDouble(),
                    valor_venta: (jugadorJSON['valor_clausula'] as int)
                        .toDouble(),
                    posicion: jugadorJSON['posicion'],
                  );

                  equipo.add(jugador);
                }
              }

              for (int id_jugador in listaIDSAli) {
                if (id_jugador != 0) {
                  final jugadorJSON = await mSupaBase
                      .from('jugadores')
                      .select()
                      .eq('id_jugador', id_jugador)
                      .single();
                  Modelojugador jugador = Modelojugador(
                    id_jugador: id_jugador,
                    nombre: jugadorJSON['nombre'],
                    pais: jugadorJSON['pais'],
                    valor_clausula: (jugadorJSON['valor_clausula'] as int)
                        .toDouble(),
                    valor_venta: (jugadorJSON['valor_clausula'] as int)
                        .toDouble(),
                    posicion: jugadorJSON['posicion'],
                  );

                  alineacion.add(jugador);
                }
              }

              for (int id_prediccion in listaIDSPre) {
                if (id_prediccion != 0) {
                  final prediccionJSON = await mSupaBase
                      .from('prediccion')
                      .select()
                      .eq('id_prediccion', id_prediccion)
                      .single();
                  Modelopredicciones prediccion = Modelopredicciones(
                    id_prediccion: id_prediccion,
                    equipoLocal: prediccionJSON['equipo_local'],
                    equipoVisitante: prediccionJSON['equipo_visitante'],
                    fase: prediccionJSON['fase'],
                    golesLocal: prediccionJSON['goles_local'],
                    golesVisitante: prediccionJSON['goles_visitante'],
                  );
                  predicciones.add(prediccion);
                }
              }
              final seleccionesJson = await mSupaBase
                  .from('liga_especial')
                  .select()
                  .eq('id_liga', liga.id_liga)
                  .single();
              List<int> listaUsuarios =
                  (seleccionesJson['selecciones'] as List<dynamic>)
                      .map((numero) => int.tryParse(numero.toString()) ?? 0)
                      .toList();
              int contador = 0;
              for (int usuario in listaUsuarios) {
                if (usuario != 0) {
                  ligaEspecial.listaSelecciones
                      .elementAt(contador)
                      .usuario = participante.usuario_ligas
                      .where(
                        (usuario) =>
                            usuario.ligaPerteneciente.id_liga ==
                            ligaEspecial.id_liga,
                      )
                      .single;
                }
                contador++;
              }

              participante.usuario_ligas.last.equipo.equipo = equipo;
              participante.usuario_ligas.last.equipo.suplentes = equipo;
              participante.usuario_ligas.last.alineacion = alineacion;
              participante.usuario_ligas.last.predicciones = predicciones;
            }

            _listaLigas.add(ligaEspecial);
            _listaLigasEspeciales.add(ligaEspecial);
          }
        }
      }
    } catch (e) {
      print('Error cargando ligas con Supabase: $e ');
    }
  }

  static Future<Map<String, dynamic>> crearLigaNormal(
    String nombre,
    Usuario propietario,
    int numParticipantes,
    bool clausulas,
  ) async {
    final mSupaBase = Supabase.instance.client;
    final codJson = await mSupaBase
        .from('ligas')
        .select()
        .count(CountOption.exact);
    final cod = codJson.count + 100;

    try {
      await mSupaBase.from('ligas').insert({
        'nombre': nombre,
        'cod_invitacion': cod,
        'propietario_id': propietario.id_usuario,
        'tipo': 'normal',
        'cap_de_participantes': numParticipantes,
        'fase': 'Fase de Grupos: Jornada 1',
        'clausulas': clausulas,
      });
    } catch (e) {
      print('Error al insertar la liga: $e');
    }
    final idligaJson = await mSupaBase
        .from('ligas')
        .select()
        .count(CountOption.exact);

    final int idLiga = idligaJson.count;

    final nuevaLiga = Liga(
      id_liga: idLiga,
      cod_invitacion: cod,
      propietario: propietario,
      nombreLiga: nombre.trim(),
      capDeParticipantes: numParticipantes,
      hayClausulazos: clausulas,
    );

    try {
      await mSupaBase.from('liga_participantes').insert({
        'id_liga': idLiga,
        'id_usuario': propietario.id_usuario,
        'puntos': 0,
        'saldo': 100000000,
      });
    } catch (e) {
      print('Error al insertar usuario en liga: $e');
    }

    _listaLigas.add(nuevaLiga);
    _listaLigasNormales.add(nuevaLiga);
    nuevaLiga.participantes.add(propietario);

    return {'success': true, 'liga': nuevaLiga};
  }

  static Future<Map<String, dynamic>> crearLigaEspecial(
    String nombre,
    Usuario propietario,
    int numParticipantes,
  ) async {
    final mSupaBase = Supabase.instance.client;
    final codJson = await mSupaBase
        .from('ligas')
        .select()
        .count(CountOption.exact);
    final cod = codJson.count + 100;

    try {
      await mSupaBase.from('ligas').insert({
        'nombre': nombre,
        'cod_invitacion': cod,
        'propietario_id': propietario.id_usuario,
        'tipo': 'especial',
        'cap_de_participantes': numParticipantes,
        'fase': 'Fase de Grupos: Jornada 1',
        'clausulas': false,
      });
    } catch (e) {
      print('Error al insertar la liga: $e');
    }
    final idligaJson = await mSupaBase
        .from('ligas')
        .select()
        .count(CountOption.exact);

    final int idLiga = idligaJson.count;
    try {
      await mSupaBase.from('liga_especial').insert({'id_liga': idLiga});
    } catch (e) {
      print('Error al insertar la liga especial: $e');
    }
    final nuevaLiga = Modeloligaespecial(
      id_liga: idLiga,
      cod_invitacion: cod,
      propietario: propietario,
      nombreLiga: nombre.trim(),
      capDeParticipantes: numParticipantes,
      hayClausulazos: false,
    );

    _listaLigas.add(nuevaLiga);
    _listaLigasEspeciales.add(nuevaLiga);

    return {'success': true, 'liga': nuevaLiga};
  }

  static Future<bool> unirUsuarioALiga(String nombre, Usuario usuario) async {
    final mSupaBase = Supabase.instance.client;
    final liga = await buscarLigaPorNombre(nombre);
    if (liga == null) {
      return false;
    }
    final yaEsParticipante = liga.participantes.any(
      (participante) => participante.getNombre() == usuario.getNombre(),
    );
    if (!yaEsParticipante) {
      liga.participantes.add(usuario);
      try {
        await mSupaBase.from('liga_participantes').insert({
          'id_liga': liga.id_liga,
          'id_usuario': usuario.id_usuario,
          'puntos': 0,
          'saldo': 100000000,
        });
      } catch (e) {
        print('Error al insertar usuario en liga: $e');
      }
      return true;
    }
    return false;
  }

  static List<Liga> getLigasByParticipante(int id_usuario) {
    List<Liga> ligas = [];
    for (var liga in _listaLigas) {
      if (liga.participantes.any((part) => part.id_usuario == id_usuario)) {
        ligas.add(liga);
      }
    }

    return ligas;
  }
}
