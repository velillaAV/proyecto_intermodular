import 'package:proyecto_intermodular/models/ModeloOferta.dart';
import 'package:proyecto_intermodular/models/ModeloPuja.dart';

class Modelojugador {
  final int id_jugador;
  final String nombre;
  String posicion;
  final String pais;
  int idPropietario = 0;
  int puntos = 0;
  bool isIcono = false;
  double valor_venta;
  double valor_clausula;
  List<int> puntos_fase = [];
  List<Puja> pujas = [];
  List<Oferta> oferta = [];
  DateTime fechaFinSubasta = DateTime.now().add(Duration(minutes: 1));

  Modelojugador({
    required this.id_jugador,
    required this.nombre,
    required this.pais,
    required this.valor_clausula,
    required this.valor_venta,
    required this.posicion,
  });
 
  void aumentarClausula(double suma) {
    valor_clausula += suma;
  }

  void definirValorVenta(double venta) {
    valor_venta += venta;
  }

  void setIcono() {
    if(posicion == "PORL") {
      isIcono = true;
      posicion = "POR";
    } else if(posicion == "DEFL")  {
      isIcono = true;
      posicion = "DEF";
    } else if(posicion == "CENL") {
      isIcono = true;
      posicion = "CEN";
    } else if(posicion == "DELL") {
      isIcono = true;
      posicion = "DEL";
    }
  }
  Map<String, dynamic> toJson() {
    return {
      'id_jugador': id_jugador,
      'nombre': nombre,
      'pais': pais,
      'valor_clausula': valor_clausula,
      'valor_venta': valor_venta,
      'posicion': posicion,
    };
  }
 
}
