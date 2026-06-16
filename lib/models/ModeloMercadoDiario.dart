import 'package:proyecto_intermodular/models/ModeloJugador.dart';

class ModeloMercadoDiario {
  final int idLiga;
  final DateTime fechaActualizacion;
  final DateTime fechaProximoCambio;
  final List<Modelojugador> jugadores;

  ModeloMercadoDiario({
    required this.idLiga,
    required this.fechaActualizacion,
    required this.fechaProximoCambio,
    required this.jugadores,
  });

  // Calcular tiempo restante hasta próxima actualización
  Duration get tiempoRestante {
    final ahora = DateTime.now();
    final diferencia = fechaProximoCambio.difference(ahora);
    return diferencia.isNegative ? Duration.zero : diferencia;
  }

  // Formatear cuenta atrás
  String get cuentaAtrasFormato {
    final duration = tiempoRestante;
    final horas = duration.inHours;
    final minutos = duration.inMinutes.remainder(60);
    final segundos = duration.inSeconds.remainder(60);
    return '${horas.toString().padLeft(2, '0')}:${minutos.toString().padLeft(2, '0')}:${segundos.toString().padLeft(2, '0')}';
  }

 
}


