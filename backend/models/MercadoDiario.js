const { getConnection } = require('../config/database');

class MercadoDiario {
  constructor(id_mercado, id_liga, fecha_actualizacion, jugadores_json, fecha_proximo_cambio) {
    this.id_mercado = id_mercado;
    this.id_liga = id_liga;
    this.fecha_actualizacion = fecha_actualizacion;
    this.jugadores_json = jugadores_json; // JSON array de jugadores
    this.fecha_proximo_cambio = fecha_proximo_cambio;
  }

  // Obtener mercado de una liga específica
  static async getByLiga(id_liga) {
    const connection = await getConnection();
    try {
      const [rows] = await connection.execute(
        'SELECT * FROM mercado_diario WHERE id_liga = ?',
        [id_liga]
      );
      if (rows.length === 0) return null;
      const row = rows[0];
      return new MercadoDiario(
        row.id_mercado,
        row.id_liga,
        row.fecha_actualizacion,
        JSON.parse(row.jugadores_json),
        row.fecha_proximo_cambio
      );
    } finally {
      connection.release();
    }
  }

  // Obtener último ID de mercado registrado
  static async getLastMarketId(id_liga) {
    const connection = await getConnection();
    try {
      const [rows] = await connection.execute(
        'SELECT id_mercado FROM mercado_diario WHERE id_liga = ? ORDER BY fecha_actualizacion DESC LIMIT 1',
        [id_liga]
      );
      return rows.length > 0 ? rows[0].id_mercado : null;
    } finally {
      connection.release();
    }
  }

  // Crear o actualizar mercado
  static async createOrUpdate(id_liga, jugadores_ids, now, proximo_cambio) {
    const connection = await getConnection();
    try {
      const jugadores_json = JSON.stringify(jugadores_ids);
      const existente = await this.getByLiga(id_liga);

      if (existente) {
        await connection.execute(
          'UPDATE mercado_diario SET jugadores_json = ?, fecha_actualizacion = ?, fecha_proximo_cambio = ? WHERE id_liga = ?',
          [jugadores_json, now, proximo_cambio, id_liga]
        );
      } else {
        await connection.execute(
          'INSERT INTO mercado_diario (id_liga, jugadores_json, fecha_actualizacion, fecha_proximo_cambio) VALUES (?, ?, ?, ?)',
          [id_liga, jugadores_json, now, proximo_cambio]
        );
      }
      return new MercadoDiario(null, id_liga, now, jugadores_ids, proximo_cambio);
    } finally {
      connection.release();
    }
  }

  // Obtener detalles de jugadores del mercado
  static async getMarketPlayersDetails(id_liga) {
    const connection = await getConnection();
    try {
      const market = await this.getByLiga(id_liga);
      if (!market || !market.jugadores_json) return [];

      const ids = market.jugadores_json.join(',');
      const [rows] = await connection.execute(
        `SELECT * FROM jugadores WHERE id_jugador IN (${ids})`
      );
      return rows;
    } finally {
      connection.release();
    }
  }
}

module.exports = MercadoDiario;
