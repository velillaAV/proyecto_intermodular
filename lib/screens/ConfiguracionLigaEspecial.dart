import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/config/utils/estiloBotones.dart';
import 'package:proyecto_intermodular/models/ModeloJugador.dart';
import 'package:proyecto_intermodular/models/ModeloLigaEspecial.dart';
import 'package:proyecto_intermodular/screens/SeleccionPaisLigaEspecial.dart';
import 'package:proyecto_intermodular/services/LogicaJugadores.dart';
import 'package:proyecto_intermodular/widgets/Appbar.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';
import 'package:proyecto_intermodular/services/LogicaLigas.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';

class ConfiguracionLigaEspecial extends StatefulWidget {
  const ConfiguracionLigaEspecial({super.key});

  @override
  State<ConfiguracionLigaEspecial> createState() => _ConfiguracionLigaEspecialState();
}

class _ConfiguracionLigaEspecialState extends State<ConfiguracionLigaEspecial> {
  String nombreLiga = "";
  int numParticipantes = 0;
  
  Future<void> _loadSelecciones(Modeloligaespecial liga) async {
    try {

      for (var equipo2 in liga.listaSelecciones) {
        List<Modelojugador> lista = await Logicajugadores()
            .rellenarSelecciones(equipo2.escudo!);
       for(var jugador in lista) {
        if(jugador.posicion != "PORL" && jugador.posicion != "DEFL" && jugador.posicion != "CENL" && jugador.posicion != "DELL") {
          equipo2.equipo.add(jugador);
        
        }
       }
           
      }
      
    } catch (e) {
      // Handle error
      
    }
  }
  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }

  void _enviarLiga() async {
    final nombre = nombreLiga.trim();
    if (nombre.isEmpty) {
      _mostrarMensaje('Por favor ingresa un nombre de liga.');
      return;
    }

    if (await Logicaligas.existeLigaNombre(nombre)) {
      _mostrarMensaje(
          'Ya existe una liga con ese nombre. Usa la opción de unirse para entrar.');
      return;
    }

    final usuarioActual = Logicausuario.getUsuarioActual();
    final result = await Logicaligas.crearLigaEspecial(nombre, usuarioActual, numParticipantes);
    final nuevaLiga = result['liga'] as Modeloligaespecial;
    _loadSelecciones(nuevaLiga);

    final cargada = await Logicaligas.buscarLigaPorNombre(nombre) as Modeloligaespecial?;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeleccionPais(liga: cargada ?? nuevaLiga),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimensiones.paddingAppbar),
        child: Appbar(),
      ),
      body: Stack(
        children: [
          
          Positioned.fill(
            child: Image.network(
              'https://ymdpeykhonejkkxncdig.supabase.co/storage/v1/object/public/images/FondoMundial2026.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.85),
            ),
          ),

       
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Crear liga",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🔹 Nombre
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Nombre de la liga',
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        nombreLiga = value;
                      },
                    ),

                    const SizedBox(height: 15),

                    // 🔹 Participantes
                    TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        labelText: 'Número de participantes',
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        numParticipantes = int.tryParse(value) ?? 0;
                      },
                    ),

                    const SizedBox(height: 15),

                    
                  

                   
                    ElevatedButton(
                      style: CustomStyles.estiloBotonInicioSesion,
                      onPressed: _enviarLiga,
                      child: const Text("Crear liga"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}