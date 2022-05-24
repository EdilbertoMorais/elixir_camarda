defmodule ExMon.Repo.Migrations.CreateTrainerTable do
  use Ecto.Migration

  def change do
    create table(:trainers, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      # hash (#) seria o Jogo da velha ou tralha como é chamado na programação
      add :password_hash, :string

      # o password_hash salva no banco de dados a senha criptografada, conceito correto para salvar senhas
      # função que insere as colunas de inserção de dados e atualização no banco de dados
      timestamps()
    end
  end
end
