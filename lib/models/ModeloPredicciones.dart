class Modelopredicciones {

  final int id_prediccion;
  final String equipoLocal;
  final String equipoVisitante;
  final String fase;
  final int golesLocal;
  final int golesVisitante;
  bool verificarLocal = false;
  bool verificarVisitante = false;
  

  Modelopredicciones({required this.id_prediccion, required this.equipoLocal, required this.equipoVisitante, required this.fase, required this.golesLocal, required this.golesVisitante});


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