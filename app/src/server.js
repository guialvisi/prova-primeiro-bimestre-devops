const app = require("./app");
const pool = require("./db");

const PORT = process.env.PORT || 3000;

async function iniciarServidor() {
  try {
    await pool.query(`
      CREATE TABLE IF NOT EXISTS reservas (
        id SERIAL PRIMARY KEY,
        cliente VARCHAR(255) NOT NULL,
        data DATE NOT NULL,
        status VARCHAR(50) NOT NULL
      )
    `);

    console.log("Banco de dados conectado.");

    app.listen(PORT, "0.0.0.0", () => {
      console.log(`API rodando na porta ${PORT}`);
    });
  } catch (erro) {
    console.error("Erro ao iniciar aplicação:", erro);
    process.exit(1);
  }
}

iniciarServidor();