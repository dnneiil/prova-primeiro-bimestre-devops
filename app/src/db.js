const { Pool } = require('pg');

const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'reservas',
  port: parseInt(process.env.DB_PORT || '5432', 10),
  ssl: process.env.DB_SSL === 'true' ? { rejectUnauthorized: false } : false,
});

async function initDb() {
  await pool.query(`
    CREATE TABLE IF NOT EXISTS reservas (
      id        SERIAL PRIMARY KEY,
      cliente   VARCHAR(255) NOT NULL,
      data      DATE         NOT NULL,
      status    VARCHAR(50)  NOT NULL,
      criado_em TIMESTAMP    NOT NULL DEFAULT NOW()
    );
  `);
  console.log('Tabela "reservas" verificada/criada com sucesso.');
}

module.exports = { pool, initDb };
