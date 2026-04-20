class Modelopredicciones {

  final int id_prediccion;
  final String equipoLocal;
  final String equipoVisitante;
  final String fase;
  int golesLocal = 0;
  int golesVisitante = 0;
  bool verificarLocal = false;
  bool verificarVisitante = false;
  

  Modelopredicciones({required this.id_prediccion, required this.equipoLocal, required this.equipoVisitante, required this.fase});


  void comprobacion(int golesLocal2, int golesVisitante2) {
        if(golesLocal == golesLocal2) {
            verificarLocal = true;
        } else {
          verificarLocal = false;
        }  

          if(golesVisitante == golesVisitante2) {
              verificarVisitante = true;
          } else  {
            verificarVisitante = false;
          }
      
        
  }


}