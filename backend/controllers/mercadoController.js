const Jugador = require('../models/Jugador');
const MercadoDiario = require('../models/MercadoDiario');
const { getConnection } = require('../config/database');

// Obtener jugadores que NO están en ninguna plantilla de una liga
const getJugadoresDisponibles = async (id_liga) => {
  const connection = await getConnection();
  try {
    // Jugadores que NO están en ninguna plantilla de la liga
    const [jugadores] = await connection.execute(`
      SELECT j.* FROM jugadores j
      WHERE j.id_jugador NOT IN (
        SELECT DISTINCT ej.id_jugador 
        FROM equipos_jugadores ej
        JOIN equipos e ON ej.id_equipo = e.id_equipo
        WHERE e.id_liga = ?
      )
      ORDER BY RAND()
    `, [id_liga]);
    
    return jugadores;
  } finally {
    connection.release();
  }
};

// Obtener mercado de hoy de una liga
const getMercadoHoy = async (req, res) => {
  try {
    const { id_liga } = req.params;
    const mercado = await MercadoDiario.getByLiga(id_liga);
    
    if (!mercado) {
      return res.status(404).json({ error: 'Mercado no encontrado' });
    }

    // Obtener detalles completos de los jugadores
    const jugadores = await MercadoDiario.getMarketPlayersDetails(id_liga);
    
    const now = new Date();
    const proximaCambio = new Date(mercado.fecha_proximo_cambio);
    const tiempoRestante = proximaCambio.getTime() - now.getTime();

    res.json({
      mercado: {
        id_liga: mercado.id_liga,
        fecha_actualizacion: mercado.fecha_actualizacion,
        fecha_proximo_cambio: mercado.fecha_proximo_cambio,
        tiempoRestante: Math.max(0, tiempoRestante)
      },
      jugadores: jugadores.map(j => ({
        id_jugador: j.id_jugador,
        nombre: j.nombre,
        posicion: j.posicion,
        pais: j.pais,
        valor_clausula: j.valor_clausula,
        valor_venta: j.valor_venta,
        foto: `/assets/images/jugadores/${j.id_jugador}.png`
      }))
    });
  } catch (error) {
    console.error('Error al obtener mercado:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

// Actualizar mercado de una liga (se llama cada día a las 00:00)
const actualizarMercado = async (id_liga) => {
  try {
    // Obtener jugadores disponibles
    const disponibles = await getJugadoresDisponibles(id_liga);
    
    if (disponibles.length === 0) {
      console.log(`No hay jugadores disponibles para la liga ${id_liga}`);
      return;
    }

    // Obtener mercado anterior para evitar repeticiones
    const mercadoAnterior = await MercadoDiario.getByLiga(id_liga);
    const idsAnteriores = mercadoAnterior ? mercadoAnterior.jugadores_json : [];

    // Filtrar jugadores que no estén en el mercado anterior
    const disponiblesNuevos = disponibles.filter(
      j => !idsAnteriores.includes(j.id_jugador)
    );

    // Si faltan jugadores, usar todos los disponibles
    const jugadoresFinal = disponiblesNuevos.length >= 11 
      ? disponiblesNuevos 
      : disponibles;

    // Seleccionar 11 jugadores aleatorios
    const jugadoresSeleccionados = jugadoresFinal
      .sort(() => Math.random() - 0.5)
      .slice(0, 11)
      .map(j => j.id_jugador);

    // Calcular próximo cambio (mañana a las 00:00)
    const now = new Date();
    const proximaCambio = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1, 0, 0, 0, 0);

    // Guardar o actualizar mercado
    await MercadoDiario.createOrUpdate(id_liga, jugadoresSeleccionados, now, proximaCambio);
    
    console.log(`Mercado actualizado para liga ${id_liga}`);
  } catch (error) {
    console.error(`Error actualizando mercado para liga ${id_liga}:`, error);
  }
};

// Endpoint para actualizar todos los mercados (llamado por scheduler)
const actualizarTodosMercados = async (req, res) => {
  try {
    const connection = await getConnection();
    const [ligas] = await connection.execute('SELECT id_liga FROM ligas');
    connection.release();

    for (const liga of ligas) {
      await actualizarMercado(liga.id_liga);
    }

    res.json({ message: 'Todos los mercados han sido actualizados' });
  } catch (error) {
    console.error('Error actualizando todos los mercados:', error);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
};

module.exports = {
  getMercadoHoy,
  actualizarTodosMercados,
  actualizarMercado
};
