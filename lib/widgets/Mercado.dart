import 'package:flutter/material.dart';
import 'dart:async';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/models/liga.dart';
import 'package:proyecto_intermodular/models/ModeloMercadoDiario.dart';
import 'package:proyecto_intermodular/services/ServicioMercadoDiario.dart';
import 'package:proyecto_intermodular/widgets/CardFutbolista3.dart';

class Mercado extends StatefulWidget {
  const Mercado({
    super.key,
    required this.usuario,
    required this.liga,
    required this.actualizar,
  });
  final Modelousuario usuario;
  final Liga liga;
  final void Function() actualizar;
  @override
  State<Mercado> createState() => _MercadoState();
}

class _MercadoState extends State<Mercado> {
  late ServicioMercadoDiario servicio;
  ModeloMercadoDiario? mercadoDiario;
  bool cargando = true;
  String? error;
  late Timer timerCuentaAtras;
  String cuentaAtras = '00:00:00';
  bool usarMercadoDiario = true;

  @override
  void initState() {
    super.initState();
    servicio = ServicioMercadoDiario();
    cargarMercadoDiario();
    
    // Iniciar timer para actualizar cuenta atrás cada segundo
    timerCuentaAtras = Timer.periodic(Duration(seconds: 1), (_) {
      if (mercadoDiario != null && mounted) {
        setState(() {
          cuentaAtras = mercadoDiario!.cuentaAtrasFormato;
        });
      }
    });
  }

  @override
  void dispose() {
    timerCuentaAtras.cancel();
    super.dispose();
  }

  Future<void> cargarMercadoDiario() async {
    try {
      setState(() {
        cargando = true;
        error = null;
      });
      
      final nuevoMercado = await servicio.obtenerMercadoHoy(widget.liga.id_liga);
      
      if (mounted) {
        setState(() {
          mercadoDiario = nuevoMercado;
          cuentaAtras = nuevoMercado.cuentaAtrasFormato;
          cargando = false;
          usarMercadoDiario = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          error = e.toString();
          cargando = false;
          usarMercadoDiario = false; // Usar mercado local si falla
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    for(var jugador in widget.liga.mercado) {
      jugador.setIcono();
    }
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('images/FondoMundial2026.jpg', fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: Container(color: Colors.white.withOpacity(0.75)),
        ),
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 18,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        widget.liga.fase,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        widget.liga.nombreLiga,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Cuenta atrás del mercado diario
              if (usarMercadoDiario && !cargando && mercadoDiario != null)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Próxima actualización:',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              cuentaAtras,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Courier',
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh, color: Colors.white),
                        onPressed: cargarMercadoDiario,
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 10),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: cargando && usarMercadoDiario
                      ? Center(child: CircularProgressIndicator())
                      : error != null && usarMercadoDiario
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error_outline, color: Colors.red, size: 60),
                                  SizedBox(height: 16),
                                  Text(
                                    'Error cargando mercado diario',
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Usando mercado local',
                                    style: TextStyle(color: Colors.orange, fontSize: 12),
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: cargarMercadoDiario,
                                    child: Text('Reintentar'),
                                  ),
                                ],
                              ),
                            )
                          : usarMercadoDiario && mercadoDiario != null
                              ? _construirMercadoDiario()
                              : _construirMercadoLocal(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _construirMercadoDiario() {
    if (mercadoDiario!.jugadores.isEmpty) {
      return Center(child: Text('No hay jugadores disponibles hoy'));
    }

    return ListView.builder(
      itemCount: mercadoDiario!.jugadores.length,
      itemBuilder: (context, index) {
        final jugador = mercadoDiario!.jugadores[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: Image.network(
              servicio.getUrlImagenJugador(jugador.foto),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[200],
                  child: Icon(Icons.image_not_supported),
                );
              },
            ),
            title: Text(jugador.nombre),
            subtitle: Text('${jugador.posicion} - ${jugador.pais}'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('\$${(jugador.valorClausula / 1000000).toStringAsFixed(1)}M',
                    style: TextStyle(fontSize: 12)),
                Text('\$${(jugador.valorVenta / 1000000).toStringAsFixed(1)}M',
                    style: TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _construirMercadoLocal() {
    return widget.liga.participantes.isEmpty
        ? const Center(child: Text('No hay futbolistas en el Mercado'))
        : ListView.builder(
            itemCount: widget.liga.mercado.length,
            itemBuilder: (context, index) {
              widget.actualizar();
              return CardFutbolista3(
                usuario: widget.usuario,
                jugador: widget.liga.mercado[index],
                actualizar: () {},
                liga: widget.liga,
              );
            },
          );
  }
}
      
