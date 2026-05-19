import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/config/utils/estiloBotones.dart';
import 'package:proyecto_intermodular/models/ModeloLigaEspecial.dart';
import 'package:proyecto_intermodular/screens/PantallaOtorgacionDeEquipo.dart';
import 'package:proyecto_intermodular/screens/SeleccionPaisLigaEspecial.dart';
import 'package:proyecto_intermodular/services/LogicaLigas.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';
import 'package:proyecto_intermodular/widgets/Appbar.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';

class UnirseLigaNormal extends StatefulWidget {
  const UnirseLigaNormal({super.key});
  @override
  State<UnirseLigaNormal> createState() => _UnirseLigaNormalState();
}

class _UnirseLigaNormalState extends State<UnirseLigaNormal> {
  String nombreLiga = '';

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  void _enviarLiga() {
    final nombre = nombreLiga.trim();

    if (nombre.isEmpty) {
      _mostrarMensaje('Por favor ingresa un nombre de liga.');
      return;
    }

    final ligaExistente = Logicaligas.buscarLigaPorNombre(nombre);

    if (ligaExistente == null) {
      _mostrarMensaje('No existe ninguna liga con ese nombre.');
      return;
    } else if (ligaExistente.participantes.length ==
        ligaExistente.capDeParticipantes) {
       _mostrarMensaje('Esa liga ya está llena.');
      return;  
    } else if (Logicaligas.getLigasNormales().contains(ligaExistente)) {
      final usuarioActual = Logicausuario.getUsuarioActual();
      if (Logicaligas.unirUsuarioALiga(nombre, usuarioActual) == true) {
        Logicausuario.getUsuarioActual().unirLiga();
        Logicausuario.getUsuarioActual().usuario_ligas.last.ligaPerteneciente =
            ligaExistente;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PantallaOtorgacionDeEquipo(
              liga: Logicaligas.buscarLigaPorNombre(nombre)!,
              usuario: Logicausuario.getUsuarioActual().usuario_ligas.last,
            ),
          ),
        );
      } else {
        _mostrarMensaje('Ya estas en esta liga.');
        return;
      }
    } else {
      final usuarioActual = Logicausuario.getUsuarioActual();

      if (Logicaligas.unirUsuarioALiga(nombre, usuarioActual) == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SeleccionPais(liga: ligaExistente as Modeloligaespecial),
          ),
        );
      } else {
        _mostrarMensaje('Ya estas en esta liga.');
        return;
      }
    }
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
            child: Image.asset(
              'images/FondoMundial2026.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.white.withOpacity(0.85)),
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
                      'Unirse a una liga',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Ingresa el nombre exacto de la liga para unirte.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: CustomStyles.estiloBotonInicioSesion,
                      onPressed: _enviarLiga,
                      child: const Text('Unirse a liga'),
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
