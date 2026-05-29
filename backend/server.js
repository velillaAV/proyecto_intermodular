const express = require('express');
const cors = require('cors');
const path = require('path');
const schedule = require('node-schedule');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());

// Capturar raw body para debugging y permitir que express.json lo verifique
app.use(express.json({
  verify: (req, res, buf) => {
    try {
      req.rawBody = buf.toString();
    } catch (e) {
      req.rawBody = null;
    }
  }
}));

// Manejo de errores de JSON malformado para devolver 400 en vez de provocar un crash
app.use((err, req, res, next) => {
  if (err instanceof SyntaxError && err.status === 400 && 'body' in err) {
    console.error('Bad JSON received:', err.message);
    if (req && req.rawBody) {
      console.error('Raw body:', req.rawBody);
    }
    return res.status(400).json({ error: 'Malformed JSON' });
  }
  next();
});

// Servir archivos estáticos (imágenes, etc)
app.use('/assets', express.static(path.join(__dirname, '../assets')));

// Importar rutas
const usuarioRoutes = require('./routes/usuarios');
const jugadorRoutes = require('./routes/jugadores');
const mercadoRoutes = require('./routes/mercado');
const ligaRoutes = require('./routes/ligas');
const { actualizarMercado } = require('./controllers/mercadoController');
const { getConnection } = require('./config/database');

// Usar rutas
app.use('/usuarios', usuarioRoutes);
app.use('/jugadores', jugadorRoutes);
app.use('/mercado', mercadoRoutes);
app.use('/ligas', ligaRoutes);

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

const server = app.listen(PORT, '0.0.0.0', () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});

server.on('error', (error) => {
  if (error.code === 'EADDRINUSE') {
    console.error(`Error: el puerto ${PORT} ya está en uso. Detén el proceso existente o cambia el puerto.`);
    process.exit(1);
  }
  console.error('Error en el servidor:', error);
});