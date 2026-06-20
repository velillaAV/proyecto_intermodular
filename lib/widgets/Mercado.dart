import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloPuja.dart';
import 'dart:async';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/models/liga.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';
import 'package:proyecto_intermodular/services/ServicioMercadoDiario.dart';

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
  bool cargando = true;
  String? error;
  late Timer timerCuentaAtras;
  String cuentaAtras = '00:00:00';
  bool usarMercadoDiario = true;

  @override
  void initState() {
    super.initState();
    servicio = ServicioMercadoDiario();
    comprobarDuracion();
    cargarMercadoDiario();

    // Iniciar timer para actualizar cuenta atrás cada segundo
    timerCuentaAtras = Timer.periodic(Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          cuentaAtras = widget.liga.mercado.cuentaAtrasFormato;
        });
      }
    });
  }

  @override
  void dispose() {
    timerCuentaAtras.cancel();
    super.dispose();
  }

  Future<void> _pujar(Modelojugador jugador) async {
    final snackBarValidadorValor = SnackBar(
      content: Text("Esa puja supera tu saldo"),
    );
    final snackBarValidadorValor2 = SnackBar(
      content: Text("Ese valor es menor que el definido del jugador"),
    );
    final snackBarConfirmador = SnackBar(
      content: Text("Se ha hecho la puja correctamente", style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.green,
    );
    double puja = jugador.valor_venta;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("¿Quieres pujar por este jugador?"),
        content: TextField(
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          onChanged: (value) => puja = double.parse(value),
          decoration: InputDecoration(hintText: jugador.valor_venta.toString()),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              // El try/catch debe ir DENTRO de la acción asíncrona
              try {
                if (widget.usuario.saldo < puja) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(snackBarValidadorValor);
                } else if (puja < jugador.valor_venta) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(snackBarValidadorValor2);
                } else {
                  jugador.pujas.add(Puja(widget.usuario, puja));

                  // Buscamos el usuario de forma segura
                  final usuarioLogica = Logicausuario.getUsuarioActual();

                 
                  print('--- DEBUG PUJA ---');
                  print('ID Usuario: ${usuarioLogica.id_usuario}');
                  print('Usuario: ${usuarioLogica.nombre}');
                  print('Mercado: ${widget.liga.mercado}');
                  print('ID Mercado: ${widget.liga.mercado.idMercado}');
                  print('ID Jugador: ${jugador.id_jugador}');
                  print('------------------');
                  await servicio.insertarPuja(
                    usuarioLogica.id_usuario!,
                    widget.liga.mercado.idMercado,
                    jugador.id_jugador,
                    puja,
                  );
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(snackBarConfirmador);
                }

                // Cerramos el diálogo usando su propio contexto
              } catch (e) {
                // Ahora sí capturamos si falla la base de datos o si falla el singleWhere/firstOrNull
                String mensaje = e.toString();

                print('Error a la hora de hacer la puja: $e');
                print('Descripcion: $mensaje');
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Ocurrió un error al procesar la puja"),
                    ),
                  );
                }
              }
            },

            child: Text("Aceptar"),
          ),
        ],
      ),
    );
  }

  Future<void> comprobarDuracion() async {
    if (widget.liga.mercado.tiempoRestante == Duration.zero) {
      widget.liga.comprobarSubastas();
      servicio.insertarMercadoDiario(widget.liga.id_liga);
    }
  }

  Future<void> cargarMercadoDiario() async {
    try {
      setState(() {
        cargando = true;
        error = null;
      });
      if (widget.liga.mercado.tiempoRestante == Duration.zero) {
        final nuevoMercado = await servicio.obtenerMercadoHoy(
          widget.liga.id_liga,
        );
        widget.liga.mercado = nuevoMercado;
        cuentaAtras = nuevoMercado.cuentaAtrasFormato;
      }

      if (mounted) {
        setState(() {
          cargando = false;
          usarMercadoDiario = true;
        });
      }
    } catch (e) {
      print('Error al cargar mercado diario: $error');
    }
  }

  String cambiarRutaImagen(String rutaImagen) {
    String rutaNueva =
        'https://ymdpeykhonejkkxncdig.supabase.co/storage/v1/object/public/$rutaImagen';
    return rutaNueva;
  }

  @override
  Widget build(BuildContext context) {
    for (var jugador in widget.liga.mercado.jugadores) {
      jugador.setIcono();
    }
    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            'https://ymdpeykhonejkkxncdig.supabase.co/storage/v1/object/public/images/FondoMundial2026.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(color: Colors.white.withValues(alpha: 0.75)),
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
                            color: Colors.black.withValues(alpha: 0.12),
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
              if (!cargando)
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
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
                      : _construirMercadoDiario(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _construirMercadoDiario() {
    if (widget.liga.mercado.jugadores.isEmpty) {
      return Center(child: Text('No hay jugadores disponibles hoy'));
    }

    return ListView.builder(
      itemCount: widget.liga.mercado.jugadores.length,
      itemBuilder: (context, index) {
        final jugador = widget.liga.mercado.jugadores[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: Image.network(
              cambiarRutaImagen(jugador.pais),
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
            subtitle: Row(
              children: [
                Text(jugador.posicion),
                SizedBox(width: 140),
                ElevatedButton(
                  onPressed: () => _pujar(jugador),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: const Text("Pujar"),
                ),
              ],
            ),

            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${(jugador.valor_venta / 1000000).toStringAsFixed(1)}M',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
