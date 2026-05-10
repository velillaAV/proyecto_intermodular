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

CREATE TABLE IF NOT EXISTS ligas (
id_liga INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(200) NOT NULL,
cod_invitacion INT NOT NULL,
propietario_id INT NOT NULL,
tipo VARCHAR(200),
cap_participantes INT NOT NULL,
fase VARCHAR(200)


);
