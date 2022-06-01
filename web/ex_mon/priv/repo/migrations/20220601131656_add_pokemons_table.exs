defmodule ExMon.Repo.Migrations.AddPokemonsTable do
  use Ecto.Migration

  def change do
    create table(:pokemons, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :nickname, :string
      add :weight, :integer
      add :types, {:array, :string} #na migration quando queremos uma lista de algum tipo, colocamos uma tupla
      # onde o primeiro é um tipo array (não é lista pq estamos na migration) e o segundo é o tipo de array
      # que neste caso é um array de string
      add :trainer_id, references(:trainers, type: :uuid, on_delete: :delete_all), null: false
      # o trainer_id vai fazer a referencia para a tabela trainers(1 arg), tipo do id (que é uuid - 2 arg),
      # e o on_delete e :delete_all => que significa que quando um trainer é deletado, todos os pokemons que
      # são vinculados a esse trainer (3 arg), e o null: false que garante que este campo nao pode ser nulo ou em branco
      timestamps()
    end
  end
end
