import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/config/utils/estiloBotones.dart';
import 'package:proyecto_intermodular/widgets/Appbar.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';
import 'package:proyecto_intermodular/screens/PantallaLigaNormal.dart';

class Liganormal extends StatefulWidget {
  const Liganormal({super.key});

  @override
  State<Liganormal> createState() => _LiganormalState();
}

class _LiganormalState extends State<Liganormal> {
  String nombreLiga = "";
  int numParticipantes = 0;
  bool clausulas = true;

  void _enviarLiga() {
    if (nombreLiga.trim().isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PantallaLigaNormal(ligaNombre: nombreLiga),
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
          // 🔹 Fondo
          Positioned.fill(
            child: Image.asset(
              'images/FondoMundial2026.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.85),
            ),
          ),

          // 🔹 Contenido
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

                    // 🔹 Checkbox
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Cláusulas"),
                        Checkbox(
                          value: clausulas,
                          onChanged: (bool? valor) {
                            if (valor == null) return;
                            setState(() {
                              clausulas = valor;
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    // 🔹 Botón
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