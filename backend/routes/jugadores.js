const express = require('express');
const router = express.Router();
const {
  getJugadores,
  getJugadoresByPais,
  getJugadoresByPosicion,
  sumarPuntos,
  obtenerPuntosJugador,
  createJugador,
  generarEquipo
} = require('../controllers/jugadorController');
// GET /jugadores - Obtener todos los jugadores
router.get('/', getJugadores);

// GET /jugadores/pais/:pais - Obtener jugadores por pais
router.get('/pais/:pais', getJugadoresByPais);

// GET /jugadores/posicion/:posicion - Obtener jugadores por posición
router.get('/posicion/:posicion', getJugadoresByPosicion);

// POST //puntuar - Sumar puntos a jugador
router.post('/puntuar', sumarPuntos);
// POST //puntos//id - recoger puntos por id
router.get('/puntos/:id_jugador', obtenerPuntosJugador);

// POST /jugadores - Crear nuevo jugador
router.post('/', createJugador);

// GET /jugadores/generar-equipo - Generar equipo aleatorio
router.get('/generar-equipo', generarEquipo);

module.exports = router;