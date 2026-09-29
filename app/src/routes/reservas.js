const express = require("express");
const router = express.Router();
const pool = require("../db");

// CREATE - Criar reserva
router.post("/", async (req, res) => {
  try {
    const { cliente, data, status } = req.body;

    if (!cliente || !data || !status) {
      return res.status(400).json({
        erro: "cliente, data e status são obrigatórios",
      });
    }

    const resultado = await pool.query(
      `INSERT INTO reservas (cliente, data, status)
       VALUES ($1, $2, $3)
       RETURNING *`,
      [cliente, data, status]
    );

    res.status(201).json(resultado.rows[0]);
  } catch (erro) {
    console.error(erro);
    res.status(500).json({ erro: "Erro interno do servidor" });
  }
});

// READ - Listar todas
router.get("/", async (req, res) => {
  try {
    const resultado = await pool.query(
      "SELECT * FROM reservas ORDER BY id"
    );

    res.json(resultado.rows);
  } catch (erro) {
    console.error(erro);
    res.status(500).json({ erro: "Erro interno do servidor" });
  }
});

// READ - Buscar pelo ID
router.get("/:id", async (req, res) => {
  try {
    const resultado = await pool.query(
      "SELECT * FROM reservas WHERE id = $1",
      [req.params.id]
    );

    if (resultado.rows.length === 0) {
      return res.status(404).json({
        erro: "Reserva não encontrada",
      });
    }

    res.json(resultado.rows[0]);
  } catch (erro) {
    console.error(erro);
    res.status(500).json({ erro: "Erro interno do servidor" });
  }
});

// UPDATE - Atualizar reserva
router.put("/:id", async (req, res) => {
  try {
    const { cliente, data, status } = req.body;

    if (!cliente || !data || !status) {
      return res.status(400).json({
        erro: "cliente, data e status são obrigatórios",
      });
    }

    const resultado = await pool.query(
      `UPDATE reservas
       SET cliente = $1, data = $2, status = $3
       WHERE id = $4
       RETURNING *`,
      [cliente, data, status, req.params.id]
    );

    if (resultado.rows.length === 0) {
      return res.status(404).json({
        erro: "Reserva não encontrada",
      });
    }

    res.json(resultado.rows[0]);
  } catch (erro) {
    console.error(erro);
    res.status(500).json({ erro: "Erro interno do servidor" });
  }
});

// DELETE - Excluir reserva
router.delete("/:id", async (req, res) => {
  try {
    const resultado = await pool.query(
      "DELETE FROM reservas WHERE id = $1 RETURNING *",
      [req.params.id]
    );

    if (resultado.rows.length === 0) {
      return res.status(404).json({
        erro: "Reserva não encontrada",
      });
    }

    res.status(204).send();
  } catch (erro) {
    console.error(erro);
    res.status(500).json({ erro: "Erro interno do servidor" });
  }
});

module.exports = router;