import 'package:flutter/material.dart';
import 'package:proyecto_intermodular/models/ModeloUsuario.dart';
import 'package:proyecto_intermodular/models/liga.dart';

class Mercado extends StatefulWidget {
  const Mercado({super.key, required this.usuario, required this.liga, required this.actualizar});
  final Modelousuario usuario;
  final Liga liga;
  final void Function() actualizar;
  @override
  State<Mercado> createState() => _MercadoState();
}

class _MercadoState extends State<Mercado> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}