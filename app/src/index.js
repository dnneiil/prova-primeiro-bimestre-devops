const app = require('./app');
const { initDb } = require('./db');

const PORT = process.env.PORT || 3000;

async function main() {
  try {
    await initDb();
    app.listen(PORT, () => {
      console.log(`Servidor rodando na porta ${PORT}`);
    });
  } catch (err) {
    console.error('Falha ao iniciar o servidor:', err);
    process.exit(1);
  }
}

main();
