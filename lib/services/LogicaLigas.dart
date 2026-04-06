import '../models/liga.dart';
import '../models/user.dart';

class Logicaligas {
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

  static bool existeLigaNombre(String nombre) {
    return buscarLigaPorNombre(nombre) != null;
  }

  static Liga crearLigaNormal(String nombre, User propietario) {
    final nuevaLiga = Liga(
      id_liga: _listaLigas.length + 1,
      cod_invitacion: _listaLigas.length + 100,
      propietario: propietario,
      nombreLiga: nombre.trim(),
    );
    nuevaLiga.insertarPropietario();
    _listaLigas.add(nuevaLiga);
    _listaLigasNormales.add(nuevaLiga);
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
    }
    return true;
  }
}
