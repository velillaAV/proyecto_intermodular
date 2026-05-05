const express = require('express');
const router = express.Router();
const {
  getMercadoHoy,
  actualizarTodosMercados
} = require('../controllers/mercadoController');

// GET /mercado/:id_liga - Obtener mercado de hoy de una liga
router.get('/:id_liga', getMercadoHoy);

// POST /mercado/actualizar-todos - Actualizar mercados (llamado por scheduler)
router.post('/actualizar-todos', actualizarTodosMercados);

module.exports = router;
