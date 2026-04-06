import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/widgets/Appbar.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';
import 'package:proyecto_intermodular/models/user.dart';
import 'package:proyecto_intermodular/services/logicaUsuarios.dart';

class PantallaLigaNormal extends StatefulWidget {
  const PantallaLigaNormal({
    super.key,
    required this.ligaNombre,
  });

  final String ligaNombre;

  @override
  State<PantallaLigaNormal> createState() => _PantallaLigaNormalState();
}

class _PantallaLigaNormalState extends State<PantallaLigaNormal> {
  int _selectedIndex = 0;
  int _jornada = 1;

  late List<User> _jugadores;
  late User _usuarioActual;

  @override
  void initState() {
    super.initState();

    _jugadores = Logicausuario.getListaUsuarios();
    _usuarioActual = Logicausuario.getUsuarioActual();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0 && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  Widget _buildJugadorCard(User jugador, int index) {
    final esUsuarioActual =
        jugador.getNombre() == _usuarioActual.getNombre();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: esUsuarioActual
          ? Colors.blue.shade100
          : Colors.white.withOpacity(0.92),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.blue.shade900,
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jugador.getNombre(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    esUsuarioActual ? 'Tú' : 'Jugador',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              '0', // puntos (backend futuro)
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tituloLiga = widget.ligaNombre.trim().isNotEmpty
        ? widget.ligaNombre
        : 'LIGA FANTASY';

    return Scaffold(
      drawer: MyDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimensiones.paddingAppbar),
        child: Appbar(),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/FondoMundial2026.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.75),
            ),
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
                          'Jornada $_jornada',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          tituloLiga,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // 🔥 LISTA DE JUGADORES (SIN ERRORES)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: _jugadores.isEmpty
                        ? const Center(
                            child: Text('No hay jugadores en la liga'),
                          )
                        : ListView.builder(
                            itemCount: _jugadores.length,
                            itemBuilder: (context, index) {
                              return _buildJugadorCard(
                                _jugadores[index],
                                index,
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade900,
        unselectedItemColor: Colors.black87,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Clasificación',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Mercado',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Equipo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Predicciones',
          ),
        ],
      ),
    );
  }
}