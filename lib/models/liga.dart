import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloPuja.dart';
import 'package:proyecto_intermodular/models/user.dart';

class Liga {
  int id_liga;
  int cod_invitacion;
  Usuario propietario;
  String nombreLiga;
  String fase = "Fase de Grupos: Jornada 1";
  bool hayClausulazos = false;
  List<Usuario> participantes = [];
  final int capDeParticipantes;
  List<Modelojugador> mercado = [
    Modelojugador(
      id_jugador: 1,
      nombre: "Nikola Vasijl",
      pais: "images/logoBosnia.png",
      valor_clausula: 14000000,
      valor_venta: 4000000,
      posicion: "POR",
    ),
    Modelojugador(
      id_jugador: 2,
      nombre: "Martin Zlomislic",
      pais: "images/logoBosnia.png",
      valor_clausula: 8000000,
      valor_venta: 1000000,
      posicion: "POR",
    ),
    Modelojugador(
      id_jugador: 3,
      nombre: "Sead Kolasinac",
      pais: "images/logoBosnia.png",
      valor_clausula: 18000000,
      valor_venta: 6000000,
      posicion: "DEF",
    ),
    Modelojugador(
      id_jugador: 4,
      nombre: "Tarik Muharemovic",
      pais: "images/logoBosnia.png",
      valor_clausula: 40000000,
      valor_venta: 20000000,
      posicion: "DEF",
    ),
    Modelojugador(
      id_jugador: 5,
      nombre: "Amar Dedic",
      pais: "images/logoBosnia.png",
      valor_clausula: 38000000,
      valor_venta: 18000000,
      posicion: "DEF",
    ),
    Modelojugador(
      id_jugador: 6,
      nombre: "Nikola Katic",
      pais: "images/logoBosnia.png",
      valor_clausula: 8000000,
      valor_venta: 2000000,
      posicion: "DEF",
    ),
    Modelojugador(
      id_jugador: 7,
      nombre: "Benjamin Tahirovic",
      pais: "images/logoBosnia.png",
      valor_clausula: 12000000,
      valor_venta: 4000000,
      posicion: "CEN",
    ),
    Modelojugador(
      id_jugador: 8,
      nombre: "Amar Memic",
      pais: "images/logoBosnia.png",
      valor_clausula: 12000000,
      valor_venta: 4000000,
      posicion: "CEN",
    ),
    Modelojugador(
      id_jugador: 9,
      nombre: "Amir Hadziahmetovic",
      pais: "images/logoBosnia.png",
      valor_clausula: 12000000,
      valor_venta: 4000000,
      posicion: "CEN",
    ),
    Modelojugador(
      id_jugador: 10,
      nombre: "Ermedin Demirovic",
      pais: "images/logoBosnia.png",
      valor_clausula: 42000000,
      valor_venta: 22000000,
      posicion: "DEL",
    ),
    Modelojugador(
      id_jugador: 11,
      nombre: "Haris Tabakovic",
      pais: "images/logoBosnia.png",
      valor_clausula: 11000000,
      valor_venta: 3000000,
      posicion: "DEL",
    ),
    Modelojugador(
      id_jugador: 12,
      nombre: "Edin Dzeko",
      pais: "images/logoBosnia.png",
      valor_clausula: 10000000,
      valor_venta: 2000000,
      posicion: "DEL",
    ),
  ];

  Liga({
    required this.id_liga,
    required this.cod_invitacion,
    required this.propietario,
    required this.nombreLiga,
    required this.capDeParticipantes,
    required this.hayClausulazos
  });

  void insertarPropietario() {
    participantes.add(propietario);
  }

  int getId_liga() {
    return id_liga;
  }

  int getCod_invitacion() {
    return cod_invitacion;
  }

  Usuario getPropietario() {
    return propietario;
  }

  String getNombreLiga() {
    return nombreLiga;
  }

  List<Usuario> getParticipantes() {
    return participantes;
  }

  List<Modelojugador> getMercado() {
    return mercado;
  }

  void setId_Liga(int id_liga) {
    this.id_liga = id_liga;
  }

  void setCod_invitacion(int cod_invitacion) {
    this.cod_invitacion = cod_invitacion;
  }

  void setPropietario(Usuario propietario) {
    this.propietario = propietario;
  }

  void setNombreLiga(String nombreLiga) {
    this.nombreLiga = nombreLiga;
  }

  void setParticipantes(List<Usuario> participantes) {
    this.participantes = participantes;
  }

  void setMercado(List<Modelojugador> mercado) {
    this.mercado = mercado;
  }

  void avanzarFase(int jornada) {
    if (jornada == 2) {
      fase = "Fase de Grupos: Jornada 2";
    }
    if (jornada == 3) {
      fase = "Fase de Grupos: Jornada 3";
    }
    if (jornada == 4) {
      fase = "Dieciseisavos";
    }
    if (jornada == 5) {
      fase = "Octavos de final";
    }
    if (jornada == 6) {
      fase = "Cuartos de Final";
    }
    if (jornada == 7) {
      fase = "Semifinal";
    }
    if (jornada == 8) {
      fase = "Final";
    }
  }

  void comprobarSubastas() {
    for (var jugador in mercado) {
      if (DateTime.now().isAfter(jugador.fechaFinSubasta)) {
        resolverSubasta(jugador);
      }
    }
  }

  void resolverSubasta(Modelojugador jugador) {
    if (jugador.pujas.isEmpty) {
      if (jugador.idPropietario != 0) {
        for (var puja in jugador.pujas) {
          for (var participante in participantes) {
            if (participante.usuario_ligas.contains(puja.usuario)) {
              if (participantes.indexOf(participante) ==
                  jugador.idPropietario) {
                puja.usuario.equipo.suplentes.add(jugador);
              }
            }
          }
        }
      }
    } else {
      Puja mejorPuja = jugador.pujas.reduce(
        (a, b) => a.cantidad > b.cantidad ? a : b,
      );

      // Dar jugador al ganador
      mejorPuja.usuario.equipo.suplentes.add(jugador);

      // devolver dinero a los perdedores
      for (var puja in jugador.pujas) {
        if (puja.usuario != mejorPuja.usuario) {
          puja.usuario.sumarSaldo(puja.cantidad);
        }
      }
    }

    // Limpiar pujas
    jugador.pujas.clear();
  }

  void actualizarClasificacion() {
    participantes.sort((a, b) {
      final datosA = a.usuario_ligas.where((ligaUsuario) => ligaUsuario.ligaPerteneciente.nombreLiga == nombreLiga).toList();
      final datosB = b.usuario_ligas.where((ligaUsuario) => ligaUsuario.ligaPerteneciente.nombreLiga == nombreLiga).toList();
      final puntosA = datosA.isNotEmpty ? datosA.first.puntos : 0;
      final puntosB = datosB.isNotEmpty ? datosB.first.puntos : 0;
      return puntosB.compareTo(puntosA);
    });
  }
}
