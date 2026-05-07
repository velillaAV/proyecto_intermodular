const { getConnection } = require('../config/database');

class Jugador {
  constructor(id_jugador, nombre, pais, valor_clausula, valor_venta, posicion) {
    this.id_jugador = id_jugador;
    this.nombre = nombre;
    this.pais = pais;
    this.valor_clausula = valor_clausula;
    this.valor_venta = valor_venta;
    this.posicion = posicion;
  }

  static async getAll() {
    const connection = await getConnection();
    try {
      const [rows] = await connection.execute('SELECT * FROM jugadores');
      return rows.map(row => new Jugador(
        row.id_jugador,
        row.nombre,
        row.pais,
        row.valor_clausula,
        row.valor_venta,
        row.posicion
      ));
    } finally {
      connection.release();
    }
  }

  static async getByPosicion(posicion) {
    const connection = await getConnection();
    try {
      const [rows] = await connection.execute(
        'SELECT * FROM jugadores WHERE posicion = ?',
        [posicion]
      );
      return rows.map(row => new Jugador(
        row.id_jugador,
        row.nombre,
        row.pais,
        row.valor_clausula,
        row.valor_venta,
        row.posicion
      ));
    } finally {
      connection.release();
    }
  }

  static async create(jugador) {
    const connection = await getConnection();
    try {
      const [result] = await connection.execute(
        'INSERT INTO jugadores (nombre, pais, valor_clausula, valor_venta, posicion) VALUES (?, ?, ?, ?, ?)',
        [jugador.nombre, jugador.pais, jugador.valor_clausula, jugador.valor_venta, jugador.posicion]
      );
      return new Jugador(result.insertId, ...Object.values(jugador));
    } finally {
      connection.release();
    }
  }
}

module.exports = Jugador;