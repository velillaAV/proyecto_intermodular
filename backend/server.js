const express = require('express');
const cors = require('cors');
const path = require('path');
const schedule = require('node-schedule');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Servir archivos estáticos (imágenes, etc)
app.use('/assets', express.static(path.join(__dirname, '../assets')));

// Importar rutas
const usuarioRoutes = require('./routes/usuarios');
const jugadorRoutes = require('./routes/jugadores');
const mercadoRoutes = require('./routes/mercado');
const { actualizarMercado } = require('./controllers/mercadoController');
const { getConnection } = require('./config/database');

// Usar rutas
app.use('/usuarios', usuarioRoutes);
app.use('/jugadores', jugadorRoutes);
app.use('/mercado', mercadoRoutes);

// ===== SCHEDULER PARA ACTUALIZAR MERCADO A LAS 00:00 =====
// Se ejecuta todos los días a las 00:00
schedule.scheduleJob('0 0 * * *', async () => {
  console.log('Iniciando actualización automática de mercados a las 00:00');
  try {
    const connection = await getConnection();
    const [ligas] = await connection.execute('SELECT id_liga FROM ligas');
    connection.release();

    for (const liga of ligas) {
      await actualizarMercado(liga.id_liga);
    }
    console.log('Mercados actualizados exitosamente');
  } catch (error) {
    console.error('Error en actualización automática de mercados:', error);
  }
});

// Ruta de prueba
app.get('/', (req, res) => {
  res.json({ message: 'API funcionando correctamente' });
  console.log('API funcionando correctamente')
});

// Manejo de errores básico
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Algo salió mal!' });
});

app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});