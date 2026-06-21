import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloMercadoDiario.dart';
import 'package:proyecto_intermodular/models/ModeloPuja.dart';
import 'package:proyecto_intermodular/models/user.dart';
import 'package:proyecto_intermodular/services/LogicaJugadores.dart';
import 'package:proyecto_intermodular/services/LogicaLigas.dart';
import 'package:proyecto_intermodular/services/ServicioMercadoDiario.dart';

class Liga {
  int id_liga;
  int cod_invitacion;
  Usuario propietario;
  String nombreLiga;
  String fase = "Fase de Grupos: Jornada 1";
  bool hayClausulazos = false;
  List<Usuario> participantes = [];
  final int capDeParticipantes;
   late ModeloMercadoDiario mercado;


  Liga({
    required this.id_liga,
    required this.cod_invitacion,
    required this.propietario,
    required this.nombreLiga,
    required this.capDeParticipantes,
    required this.hayClausulazos
  });

  

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

  ModeloMercadoDiario getMercado() {
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

  void setMercado(ModeloMercadoDiario mercado) {
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

  Future<void> comprobarSubastas() async {
    for (var jugador in mercado.jugadores) {
        int id_pujador = await ServicioMercadoDiario().resolverPuja(mercado.idMercado, jugador.id_jugador, id_liga, jugador.id_jugador);
        double cantidad_pujada = await ServicioMercadoDiario().getValorPuja(mercado.idMercado, jugador.id_jugador, id_liga);
        resolverSubasta(jugador, id_pujador, cantidad_pujada);
        await Logicaligas.guardarSaldo(cantidad_pujada, id_pujador, id_liga);

      
    }
  }

  void resolverSubasta(Modelojugador jugador, int id_usuario, double cantidad_pujada) {
    
          for (var participante in participantes) {
            if (participante.id_usuario == id_usuario) {
                for(final usuarioLiga in participante.usuario_ligas) {
                  if(usuarioLiga.ligaPerteneciente.id_liga == id_liga) {
                     usuarioLiga.equipo.suplentes.add(jugador);
                     
                  }
                }
               

            } else  {
              for(final usuarioLiga in participante.usuario_ligas) {
                  if(usuarioLiga.ligaPerteneciente.id_liga == id_liga) {
                     usuarioLiga.equipo.suplentes.add(jugador);
                     usuarioLiga.sumarSaldo(cantidad_pujada);
                  }
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
