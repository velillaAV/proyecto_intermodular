import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/config/utils/estiloBotones.dart';
import 'package:proyecto_intermodular/screens/ConfiguracionLigaEspecial.dart';
import 'package:proyecto_intermodular/screens/LigaNormal.dart';
import 'package:proyecto_intermodular/widgets/Appbar.dart';
import 'package:proyecto_intermodular/widgets/drawer.dart';


class Eleccionliga extends StatefulWidget {
  const Eleccionliga({super.key});

  @override
  State<Eleccionliga> createState() => _EleccionligaState();
}

class _EleccionligaState extends State<Eleccionliga> {
  void _ligaNormal() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Liganormal()),
    );
  }

  void _ligaEspecial() {
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConfiguracionLigaEspecial()),
    );
  }

  Widget tarjetaLiga({
    required String titulo,
    required String descripcion,
    required Color colorTitulo,
    VoidCallback? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: CustomStyles.estiloTarjetaLiga,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: colorTitulo,
              ),
            ),
            const SizedBox(height: 10),
            Text(descripcion, style: const TextStyle(fontSize: 14)),
          ],
        ),
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
              "https://ymdpeykhonejkkxncdig.supabase.co/storage/v1/object/public/images/FondoMundial2026.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.white.withOpacity(0.7)),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "ELIGE TIPO",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 30),

                  tarjetaLiga(
                    titulo: "LIGA NORMAL",
                    descripcion:
                        "Una liga Fantasy tradicional con equipos aleatorios",
                    colorTitulo: Colors.red,
                    onPressed: _ligaNormal,
                  ),

                  tarjetaLiga(
                    titulo: "LIGA ESPECIAL",
                    descripcion:
                        "Escoge una selección y juega solo con sus jugadores",
                    colorTitulo: Colors.blue,
                    onPressed: _ligaEspecial,
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
