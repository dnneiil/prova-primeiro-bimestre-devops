const express = require('express');
const reservasRouter = require('./routes/reservas');

const app = express();

app.use(express.json());

// Health check
app.get('/health', (_req, res) => {
  res.json({ status: 'ok' });
});

// Rotas de reservas
app.use('/reservas', reservasRouter);

module.exports = app;
