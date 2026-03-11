import '../models/liga.dart';

class Logicaligas {
  static final List<Liga> _listaLigas = [];
  static final List<Liga> _listaLigasNormales = [];
  static final List<Liga>_listaLigasEspeciales = [];

  void _anadirLigaNormal(Liga liga){
    _listaLigas.add(liga);
    _listaLigasNormales.add(liga);
  }

  void _anadirLigaEspecial(Liga liga){
    _listaLigas.add(liga);
    _listaLigasEspeciales.add(liga);
  }

  static List<Liga> getLigas(){
    return _listaLigas;
  }

  static List<Liga> getLigasNormales(){
    return _listaLigasNormales;
  }

  static List<Liga> getLigasEspeciales(){
    return _listaLigasEspeciales;
  }
}
