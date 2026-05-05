-- Tabla para almacenar el mercado diario de cada liga
CREATE TABLE IF NOT EXISTS mercado_diario (
  id_mercado INT AUTO_INCREMENT PRIMARY KEY,
  id_liga INT NOT NULL UNIQUE,
  jugadores_json JSON NOT NULL,
  fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  fecha_proximo_cambio DATETIME NOT NULL,
  FOREIGN KEY (id_liga) REFERENCES ligas(id_liga) ON DELETE CASCADE,
  INDEX idx_liga (id_liga)
);
