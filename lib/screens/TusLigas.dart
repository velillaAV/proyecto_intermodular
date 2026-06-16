import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/config/utils/estiloBotones.dart';
import 'package:proyecto_intermodular/models/liga.dart';
import 'package:proyecto_intermodular/screens/PantallaLigaNormal.dart';
import 'package:proyecto_intermodular/screens/PantallaLigaEspecial.dart';
import 'package:proyecto_intermodular/screens/PantallaOtorgacionDeEquipo.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/services/LogicaLigas.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';
import 'package:proyecto_intermodular/widgets/Appbar.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';

class TusLigas extends StatefulWidget {
  const TusLigas({super.key});

  @override
  State<TusLigas> createState() => _TusLigasState();
}

class _TusLigasState extends State<TusLigas> {
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(
      const AssetImage('assets/images/FondoMundial2026.jpg'),
      context,
    );
  }

  @override
  void initState() {
    super.initState();
    _cargarLigasUsuario();
  }

  Future<void> _cargarLigasUsuario() async {
    setState(() => _isLoading = true);

    

    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  List<Liga> _obtenerLigasDelUsuario() {
    final usuarioActual = Logicausuario.getUsuarioActual();
    return Logicaligas.getLigasByPropietario(usuarioActual.id_usuario! );
  }

  void _navegarALiga(Liga liga) {
    final usuarioActual = Logicausuario.getUsuarioActual();
    final pos = usuarioActual.usuario_ligas.indexWhere(
      (us) => us.ligaPerteneciente == liga,
    );
    var usuarioLiga =
        pos >= 0 ? usuarioActual.usuario_ligas[pos] : Modelousuario()
          ..ligaPerteneciente = liga;

    if (Logicaligas.getLigasNormales().contains(liga)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PantallaLigaNormal(liga: liga, usuario: usuarioLiga),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PantallaLigaEspecial(liga: liga, usuario: usuarioLiga),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ligasDelUsuario = _obtenerLigasDelUsuario();

    return Scaffold(
      drawer: MyDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimensiones.paddingAppbar),
        child: Appbar(),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // Fondo con imagen
                Positioned.fill(
                  child: Image.network(
                    'https://ymdpeykhonejkkxncdig.supabase.co/storage/v1/object/public/images/FondoMundial2026.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                // Overlay semi-transparente
                Positioned.fill(
                  child: Container(color: Colors.white.withValues(alpha: 0.8)),
                ),
                // Contenido principal
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TUS LIGAS',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Si no hay ligas, mostrar mensaje
                        if (ligasDelUsuario.isEmpty)
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 50,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.15),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  const Text(
                                    '¡No estás en ninguna liga!',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Únete a una liga desde la pantalla principal para empezar a jugar.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 25),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: CustomStyles.estiloBotonInicioSesion,
                                    child: const Text('VOLVER A INICIO'),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          // Lista de ligas
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: ligasDelUsuario.length,
                            itemBuilder: (context, index) {
                              final liga = ligasDelUsuario[index];
                              final numParticipantes = liga
                                  .getParticipantes()
                                  .length;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: ElevatedButton(
                                  onPressed: () => _navegarALiga(liga),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black87,
                                    elevation: 5,
                                    padding: const EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              liga.getNombreLiga(),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Participantes: $numParticipantes',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              const Color.fromARGB(
                                                255,
                                                6,
                                                58,
                                                231,
                                              ),
                                              Colors.red,
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
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
