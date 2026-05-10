import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_intermodular/config/constantes/colors.dart';
import 'package:proyecto_intermodular/config/constantes/dimensions.dart';
import 'package:proyecto_intermodular/config/translations/users/languagesPantallaRegistrar.dart';
import 'package:proyecto_intermodular/config/utils/Camera.dart';
import 'package:proyecto_intermodular/config/utils/estiloBotones.dart';
import 'package:proyecto_intermodular/controllers/UserControllers.dart';
import 'package:proyecto_intermodular/screens/PantallaInicioSesion.dart';
import 'package:proyecto_intermodular/services/LogicaUsuarios.dart';
import 'package:proyecto_intermodular/services/api_service.dart';

class PantallaRegistrar extends StatefulWidget {
  const PantallaRegistrar({super.key});

  @override
  State<PantallaRegistrar> createState() => _PantallaRegistrarState();
}

const List<String> listaLugares = <String>[
  'Zaragoza',
  'Huesca',
  'Teruel',
  'Frankfurt',
];

typedef EntradaMenu = DropdownMenuEntry<String>;

class _PantallaRegistrarState extends State<PantallaRegistrar> {
  String _nombre = '';
  String _contrasena = '';
  String _contrasenaRepetida = '';
  String _tratamiento = 'Sr';
  int _edad = 0;
  String _lugarNacimiento = listaLugares.first;
  bool _tickONo = false;
  String? _fotoRuta;

  static final List<EntradaMenu> menuEntries =
      UnmodifiableListView<EntradaMenu>(
        listaLugares.map<EntradaMenu>(
          (String name) => EntradaMenu(value: name, label: name),
        ),
      );

  // ── Helpers ───────────────────────────────────────────────────────────────

  void _snack(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }

  void _irA(Widget pantalla) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => pantalla),
    );
  }

  SizedBox _gap() => SizedBox(height: Dimensiones.paddingMediano);

  Widget _radioBtn(String valor) {
    return Row(
      children: [
        Radio<String>(
          value: valor,
          groupValue: _tratamiento,
          onChanged: (value) => setState(() => _tratamiento = value!),
        ),
        Text(valor),
      ],
    );
  }

  Widget _campoTexto({
    required String label,
    required void Function(String) onChanged,
    bool obscureText = false,
    bool soloNumeros = false,
  }) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: soloNumeros ? TextInputType.number : null,
      inputFormatters:
          soloNumeros ? [FilteringTextInputFormatter.digitsOnly] : null,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      onChanged: onChanged,
    );
  }

  Widget _botonFoto(String label, Future<String?> Function() accion) {
    return FloatingActionButton.extended(
      label: Text(label),
      onPressed: () async {
        final path = await accion();
        if (path == null) return;
        setState(() => _fotoRuta = path);
      },
    );
  }

  // ── Lógica ────────────────────────────────────────────────────────────────

  Future<void> _aceptar() async {
    if (_nombre.isEmpty) {
      return _snack("El campo (nombre) está vacio");
    }
    if (_contrasena.isEmpty) {
      return _snack("El campo (contraseña) está vacio");
    }
    if (_contrasenaRepetida.isEmpty) {
      return _snack("El campo (contraseña) está vacio");
    }
    if (_edad == 0) {
      return _snack("El campo (edad) está vacio");
    }
    if (_contrasena != _contrasenaRepetida) {
      return _snack("La contraseña no es igual que la repetida");
    }
    if (!_tickONo) {
      return _snack("No están aceptados los terminos");
    }
    if (Logicausuario.mismoNombre(_nombre)) {
      return _snack("El usuario ya existe");
    }

    final created = await ApiService.registerUser({
      'nombre': _nombre,
      'contrasena': _contrasena,
      'genero': _tratamiento,
      'edad': _edad,
      'lugarNacimiento': _lugarNacimiento,
      'fotoRuta': _fotoRuta,
      'isAdmin': false,
    });

    if (!created) {
      return _snack("No se pudo registrar el usuario. Intenta de nuevo.");
    }

    UserControllers.creacionYInsercionDeUsuario(
      _nombre,
      _contrasena,
      _edad,
      _tratamiento,
      _lugarNacimiento,
      _fotoRuta,
      false,
    );
    _irA(const Pantallainiciosesion());
  }

  void _cancelar() => _irA(const Pantallainiciosesion());

  Color _colorBotonTick(Set<WidgetState> states) {
    const Set<WidgetState> interactiveStates = <WidgetState>{
      WidgetState.pressed,
      WidgetState.hovered,
      WidgetState.focused,
    };
    if (states.any(interactiveStates.contains)) return Colors.blue;
    return Colors.red;
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                Color.fromARGB(255, 6, 58, 231),
                Colors.red,
                Colors.green,
              ],
            ),
          ),
        ),
        title: Row(
          children: [
            SizedBox(width: Dimensiones.paddingEnano),
            Text(
              Languagespantallaregistrar.getTexto(
                Languagespantallaregistrar.registrar,
              ),
              style: const TextStyle(color: Color.fromARGB(255, 240, 240, 240)),
            ),
          ],
        ),
        backgroundColor: Colorcetes.appBarColor,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          // Tratamiento
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Languagespantallaregistrar.getTexto(
                                  Languagespantallaregistrar.tratamiento,
                                ),
                                style: TextStyle(
                                    fontSize: Dimensiones.paddingMediano),
                              ),
                              SizedBox(width: Dimensiones.paddingMediano),
                              _radioBtn('Sr'),
                              _radioBtn('Sra'),
                            ],
                          ),

                          _gap(),

                          SizedBox(
                            width: 500,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _campoTexto(
                                  label: Languagespantallaregistrar.getTexto(
                                    Languagespantallaregistrar.nombre,
                                  ),
                                  onChanged: (value) => _nombre = value,
                                ),

                                _gap(),

                                _campoTexto(
                                  label: Languagespantallaregistrar.getTexto(
                                    Languagespantallaregistrar.contrasena,
                                  ),
                                  onChanged: (value) => _contrasena = value,
                                  obscureText: true,
                                ),

                                _gap(),

                                _campoTexto(
                                  label: Languagespantallaregistrar.getTexto(
                                    Languagespantallaregistrar.repitecontrasena,
                                  ),
                                  onChanged: (value) =>
                                      _contrasenaRepetida = value,
                                  obscureText: true,
                                ),

                                _gap(),

                                Row(
                                  children: [
                                    Text(
                                      Languagespantallaregistrar.getTexto(
                                        Languagespantallaregistrar.subeFoto,
                                      ),
                                    ),
                                    const SizedBox(width: 30),
                                    _botonFoto(
                                      Languagespantallaregistrar.getTexto(
                                        Languagespantallaregistrar.galeria,
                                      ),
                                      CameraGalleryService().selectPhoto,
                                    ),
                                    const SizedBox(width: 30),
                                    _botonFoto(
                                      Languagespantallaregistrar.getTexto(
                                        Languagespantallaregistrar.tomarFoto,
                                      ),
                                      CameraGalleryService().takePhoto,
                                    ),
                                  ],
                                ),

                                _gap(),

                                _campoTexto(
                                  label: Languagespantallaregistrar.getTexto(
                                    Languagespantallaregistrar.edad,
                                  ),
                                  onChanged: (value) =>
                                      _edad = int.tryParse(value) ?? 0,
                                  soloNumeros: true,
                                ),

                                _gap(),

                                DropdownMenu(
                                  label: Text(
                                    Languagespantallaregistrar.getTexto(
                                      Languagespantallaregistrar.lugarNacimiento,
                                    ),
                                  ),
                                  initialSelection: listaLugares.first,
                                  onSelected: (String? value) {
                                    setState(
                                        () => _lugarNacimiento = value!);
                                  },
                                  dropdownMenuEntries: menuEntries,
                                ),

                                _gap(),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      Languagespantallaregistrar.getTexto(
                                        Languagespantallaregistrar.aceptarTerminos,
                                      ),
                                      style: TextStyle(
                                          fontSize: Dimensiones.paddingMediano),
                                    ),
                                    Checkbox(
                                      checkColor: Colors.white,
                                      fillColor:
                                          WidgetStateProperty.resolveWith(
                                              _colorBotonTick),
                                      value: _tickONo,
                                      onChanged: (value) {
                                        setState(() => _tickONo = value!);
                                      },
                                    ),
                                  ],
                                ),

                                _gap(),

                                ElevatedButton(
                                  onPressed: _aceptar,
                                  style: CustomStyles.estiloBotonRegistrarse,
                                  child: Text(
                                    Languagespantallaregistrar.getTexto(
                                      Languagespantallaregistrar.aceptar,
                                    ),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),

                                SizedBox(height: Dimensiones.paddingEnano),

                                ElevatedButton(
                                  onPressed: _cancelar,
                                  style: CustomStyles.estiloBotonRojo,
                                  child: Text(
                                    Languagespantallaregistrar.getTexto(
                                      Languagespantallaregistrar.cancelar,
                                    ),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}