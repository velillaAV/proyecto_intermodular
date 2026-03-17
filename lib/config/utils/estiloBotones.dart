import 'package:flutter/material.dart';

class CustomStyles {
  static ButtonStyle estiloBotones = ElevatedButton.styleFrom(
    elevation: 4,
    minimumSize: const Size(260, 50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
  );

  static ButtonStyle estiloBotonInicioSesion = ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 6, 58, 231),
    foregroundColor: Colors.white,
    elevation: 4,
    minimumSize: const Size(260, 50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
  );

  static ButtonStyle estiloBotonRegistrarse = ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
    elevation: 4,
    minimumSize: const Size(260, 50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
  );

  static ButtonStyle estiloBotonRojo = ElevatedButton.styleFrom(
    backgroundColor: Colors.red,
    foregroundColor: Colors.white,
    elevation: 4,
    minimumSize: const Size(260, 50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
  );

  static ButtonStyle estiloBotonGoogle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black87,
    elevation: 2,
    minimumSize: const Size(260, 50),
    side: const BorderSide(color: Colors.grey, width: 1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
  );
}
