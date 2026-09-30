const { Router } = require('express');
const { pool } = require('../db');

const router = Router();

// POST /reservas — criar reserva
router.post('/', async (req, res) => {
  const { cliente, data, status } = req.body;

  if (!cliente || !data || !status) {
    return res.status(400).json({
      erro: 'Os campos "cliente", "data" e "status" são obrigatórios.',
    });
  }

  try {
    const result = await pool.query(
      'INSERT INTO reservas (cliente, data, status) VALUES ($1, $2, $3) RETURNING *',
      [cliente, data, status]
    );
    return res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ erro: 'Erro interno ao criar reserva.' });
  }
});

// GET /reservas — listar todas
router.get('/', async (_req, res) => {
  try {
    const result = await pool.query('SELECT * FROM reservas ORDER BY id');
    return res.json(result.rows);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ erro: 'Erro interno ao buscar reservas.' });
  }
});

// GET /reservas/:id — buscar por id
router.get('/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const result = await pool.query('SELECT * FROM reservas WHERE id = $1', [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ erro: `Reserva com id ${id} não encontrada.` });
    }

    return res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ erro: 'Erro interno ao buscar reserva.' });
  }
});

// PUT /reservas/:id — atualizar reserva
router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const { cliente, data, status } = req.body;

  if (!cliente || !data || !status) {
    return res.status(400).json({
      erro: 'Os campos "cliente", "data" e "status" são obrigatórios.',
    });
  }

  try {
    const result = await pool.query(
      'UPDATE reservas SET cliente = $1, data = $2, status = $3 WHERE id = $4 RETURNING *',
      [cliente, data, status, id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ erro: `Reserva com id ${id} não encontrada.` });
    }

    return res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    return res.status(500).json({ erro: 'Erro interno ao atualizar reserva.' });
  }
});

// DELETE /reservas/:id — remover reserva
router.delete('/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const result = await pool.query(
      'DELETE FROM reservas WHERE id = $1 RETURNING *',
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ erro: `Reserva com id ${id} não encontrada.` });
    }

    return res.status(200).json({ mensagem: `Reserva com id ${id} removida com sucesso.` });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ erro: 'Erro interno ao remover reserva.' });
  }
});

module.exports = router;
