import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'dart:async';
import 'package:proyecto_intermodular/models/ModeloMercadoDiario.dart';
import 'package:proyecto_intermodular/services/ServicioMercadoDiario.dart';

class WidgetMercadoDiario extends StatefulWidget {
  final int idLiga;
  final String nombreLiga;

  const WidgetMercadoDiario({
    Key? key,
    required this.idLiga,
    required this.nombreLiga,
  }) : super(key: key);

  @override
  State<WidgetMercadoDiario> createState() => _WidgetMercadoDiarioState();
}

class _WidgetMercadoDiarioState extends State<WidgetMercadoDiario> {
  late ServicioMercadoDiario servicio;
  ModeloMercadoDiario? mercado;
  bool cargando = true;
  String? error;
  late Timer timerCuentaAtras;
  String cuentaAtras = '00:00:00';

  @override
  void initState() {
    super.initState();
    servicio = ServicioMercadoDiario();
    cargarMercado();
    
    // Iniciar timer para actualizar cuenta atrás cada segundo
    timerCuentaAtras = Timer.periodic(Duration(seconds: 1), (_) {
      if (mercado != null && mounted) {
        setState(() {
          cuentaAtras = mercado!.cuentaAtrasFormato;
        });
      }
    });
  }

  @override
  void dispose() {
    timerCuentaAtras.cancel();
    super.dispose();
  }

  Future<void> cargarMercado() async {
    try {
      setState(() {
        cargando = true;
        error = null;
      });
      
      final nuevoMercado = await servicio.obtenerMercadoHoy(widget.idLiga);
      
      if (mounted) {
        setState(() {
          mercado = nuevoMercado;
          cuentaAtras = nuevoMercado.cuentaAtrasFormato;
          cargando = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          error = e.toString();
          cargando = false;
        });
      }
    }
  }
  String cambiarRutaImagen(String rutaImagen) {
    String rutaNueva = 'https://ymdpeykhonejkkxncdig.supabase.co/storage/v1/object/public/$rutaImagen';
    return rutaNueva;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mercado - ${widget.nombreLiga}'),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header con cuenta atrás
            Container(
              color: Colors.deepPurple,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Próxima actualización en:',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    cuentaAtras,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Courier',
                    ),
                  ),
                ],
              ),
            ),

            // Contenido principal
            if (cargando)
              Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(),
              )
            else if (error != null)
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 60),
                    SizedBox(height: 16),
                    Text(
                      'Error: $error',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: cargarMercado,
                      child: Text('Reintentar'),
                    ),
                  ],
                ),
              )
            else if (mercado != null)
              Padding(
                padding: EdgeInsets.all(10),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: mercado!.jugadores.length,
                  itemBuilder: (context, index) {
                    final jugador = mercado!.jugadores[index];
                    return _construirTarjetaJugador(jugador);
                  },
                ),
              )
            else
              Padding(
                padding: EdgeInsets.all(20),
                child: Text('No hay datos disponibles'),
              ),

            // Botón para refrescar
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton.icon(
                onPressed: cargarMercado,
                icon: Icon(Icons.refresh),
                label: Text('Actualizar Mercado'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirTarjetaJugador(Modelojugador jugador) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Imagen del jugador
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Image.network(
               cambiarRutaImagen(jugador.pais),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Información del jugador
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jugador.nombre,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        jugador.posicion,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cl: \$${(jugador.valor_clausula / 1000000).toStringAsFixed(1)}M',
                        style: TextStyle(fontSize: 9, color: Colors.grey[700]),
                      ),
                      Text(
                        'Ve: \$${(jugador.valor_venta / 1000000).toStringAsFixed(1)}M',
                        style: TextStyle(fontSize: 9, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
