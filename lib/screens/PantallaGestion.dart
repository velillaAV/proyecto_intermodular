import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/services/LogicaJugadores.dart';
import 'package:proyecto_intermodular/models/ModeloEstadisticas.dart';
import 'package:proyecto_intermodular/widgets/Appbar.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';

/// Pantalla de Gestión de Estadísticas
///
/// Esta pantalla muestra:
/// 1. Registrar estadísticas de un jugador
/// 2. Ver los puntos totales de todos los jugadores
/// 3. Ver la jornada actual
/// 4. Iniciar una nueva jornada (manual)

class PantallaGestion extends StatefulWidget {
  @override
  State<PantallaGestion> createState() => _PantallaGestionState();
}

class _PantallaGestionState extends State<PantallaGestion> {
  final logica = Logicajugadores();

  // Controladores de texto para el formulario
  final TextEditingController idJugadorController = TextEditingController();
  final TextEditingController golesController = TextEditingController();
  final TextEditingController asistenciasController = TextEditingController();
  final TextEditingController minutosController = TextEditingController();
  final TextEditingController amarillasController = TextEditingController();
  final TextEditingController rojasController = TextEditingController();

  List<Map<String, dynamic>> jugadoresConPuntos = [];
  int puntos = 0;

  Future<void> _guardarEstadisticas() async {
    if (idJugadorController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor ingrese el ID del jugador')),
      );
      return;
    }

    try {
      final stats = ModeloEstadisticas(
        id_jugador: int.parse(idJugadorController.text),
        goles: int.tryParse(golesController.text) ?? 0,
        asistencias: int.tryParse(asistenciasController.text) ?? 0,
        minutos: int.tryParse(minutosController.text) ?? 0,
        tarjetas_amarillas: int.tryParse(amarillasController.text) ?? 0,
        tarjetas_rojas: int.tryParse(rojasController.text) ?? 0,
      );
      Logicajugadores().sumarPuntos(stats);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✓ Estadísticas guardadas - Puntos: $puntos')),
      );

      // Limpiar formulario
      idJugadorController.clear();
      golesController.clear();
      asistenciasController.clear();
      minutosController.clear();
      amarillasController.clear();
      rojasController.clear();

      // Recargar datos
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: const Color.fromARGB(181, 255, 255, 255),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                const Color.fromARGB(255, 6, 58, 231),
                Colors.red,
                Colors.green,
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),
        title: Row(
          children: [
            SizedBox(width: 10),
            Text(
              'ROAD TO THE FIFA WORLD CUP 26 APP',
              style: TextStyle(color: Color.fromARGB(255, 240, 240, 240)),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 6, 58, 231).withOpacity(0.1),
                        Colors.blue.shade50,
                      ],
                    ),
                  ),
                  child: Padding(padding: EdgeInsets.all(16)),
                ),
              ),
              SizedBox(height: 25),

              // Formulario de estadísticas
              Text(
                'Registrar Estadísticas',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 6, 58, 231),
                ),
              ),
              SizedBox(height: 15),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        controller: idJugadorController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'ID Jugador',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 6, 58, 231),
                              width: 2,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 6, 58, 231),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: golesController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Goles',
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 6, 58, 231),
                                    width: 2,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.sports_soccer,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: asistenciasController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Asistencias',
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 6, 58, 231),
                                    width: 2,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.assistant,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: minutosController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Minutos',
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 6, 58, 231),
                                    width: 2,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.timer,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: amarillasController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Amarillas',
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 6, 58, 231),
                                    width: 2,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.warning,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: rojasController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Tarjetas Rojas',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 6, 58, 231),
                              width: 2,
                            ),
                          ),
                          prefixIcon: Icon(Icons.cancel, color: Colors.red),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _guardarEstadisticas,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor: Color.fromARGB(255, 6, 58, 231),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Guardar Estadísticas',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25),

              // Lista de jugadores con puntos
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    idJugadorController.dispose();
    golesController.dispose();
    asistenciasController.dispose();
    minutosController.dispose();
    amarillasController.dispose();
    rojasController.dispose();
    super.dispose();
  }
}
