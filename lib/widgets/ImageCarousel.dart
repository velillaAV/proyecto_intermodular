import 'package:flutter/material.dart';


class ImageCarousel extends StatefulWidget {
  /// Lista de rutas de imágenes locales (assets)
  final List<String> imagePaths;

  const ImageCarousel({Key? key, required this.imagePaths}) : super(key: key);

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  // Controlador que permite:
  // - Cambiar de página manualmente (flechas)
  // - Escuchar cambios de página
  late PageController _controller;

  // Guarda el índice actual del carrusel
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    // Inicializamos el controlador cuando el widget se crea
    _controller = PageController();
  }

  @override
  void dispose() {
    // Muy importante: liberar el controlador
    // para evitar fugas de memoria
    _controller.dispose();
    super.dispose();
  }

  // Función para ir a la siguiente imagen
  void _nextPage() {
    // Solo avanza si NO estamos en la última imagen
    if (_currentPage < widget.imagePaths.length - 1) {
      // nextPage hace una animación automática
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

 

  final List<List<String>> descriptions = [
    ["La Copa Mundial de la FIFA México 1970 fue la novena edición de la Copa Mundial de Fútbol. Se celebró en México, entre el 31 de mayo y el 21 de junio."]
    ,
    ["La Copa Mundial de la FIFA México 1986 fue la decimotercera edición de la Copa Mundial de Fútbol. Se desarrolló entre el 31 de mayo y el 29 de junio."],
    ["La Copa Mundial de la FIFA Estados Unidos 1994 fue la decimoquinta edición de la Copa Mundial de Fútbol, y se desarrolló en los Estados Unidos entre el 17 de junio y el 17 de julio de 1994.",
    "Se eligió a Estados Unidos como sede del Mundial por primera vez en la historia, lo que generó gran polémica por ser un país sin tradición futbolística debido a la popularidad de otros deportes como el béisbol, el fútbol americano, el hockey sobre hielo y el baloncesto. "],
  ];

  // Función para ir a la imagen anterior
  void _previousPage() {
    // Solo retrocede si NO estamos en la primera imagen
    if (_currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showImageDialog(BuildContext context, int index) {
     

     
    showDialog(
      context: context,
      builder: (context) {
       
        return AlertDialog(
        title: const Text("Información"),
        
          content: 
          
          Text(descriptions[index].join("\n")),
          actions: [
            
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cerrar"),
            ),
          ],
        );
      },
    );
     
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,

          // Stack permite superponer:
          // El PageView
          // Las flechas encima
          children: [
            SizedBox(
              height: 250,

              // PageView es el widget que permite deslizar horizontalmente
              child: PageView.builder(
                // Le pasamos el controlador
                controller: _controller,

                // Número total de páginas
                itemCount: widget.imagePaths.length,

                // Se ejecuta cada vez que cambia la página
                onPageChanged: (index) {
                  setState(() {
                    // Actualizamos el índice actual

                    _currentPage = index;
                  });
                },

                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _showImageDialog(context, index);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        widget.imagePaths[index],
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    ),
                  );
                },
              ),
            ),

           
            // Flecha izquierda
           
            Positioned(
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),

                /// Al presionar llama a la función
                onPressed: _previousPage,
              ),
            ),

           
            // Flecha derecha
           
            Positioned(
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                onPressed: _nextPage,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        /// =========================
        /// Indicadores (los puntitos)
        /// =========================
        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          /// Generamos un indicador por cada imagen
          children: List.generate(widget.imagePaths.length, (index) {
            return AnimatedContainer(
              /// Animación suave cuando cambia tamaño/color
              duration: const Duration(milliseconds: 300),

              margin: const EdgeInsets.symmetric(horizontal: 4),

              /// Si es la página actual → más grande
              width: _currentPage == index ? 14 : 8,
              height: 8,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),

                /// Azul si es la página activa
                /// Gris si no lo es
                color: _currentPage == index
                    ? Colors.blue
                    : Colors.grey.shade400,
              ),
            );
          }),
        ),
      ],
    );
  }
}
