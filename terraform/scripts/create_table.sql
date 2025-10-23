CREATE TABLE facultad (
  id SERIAL PRIMARY KEY,
  facul_nombre VARCHAR(255) NOT NULL,
  decano VARCHAR(255),
  numero_estuiantes INTEGER
);