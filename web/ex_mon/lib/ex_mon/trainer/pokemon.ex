defmodule ExMon.Trainer.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset

  alias ExMon.Trainer

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "pokemons" do
    field :name, :string
    field :nickname, :string
    field :weight, :integer
    field :types, {:array, :string}
    belongs_to(:trainer, Trainer)

    # O belongs_to serve para dizer que o pokemons pertence a um trainer (neste caso, deve ser informar
    # o nome do schema e o modulo) neste caso o 1 arg é o schema e o 2 o modulo ExMon.Trainer
    timestamps()
  end

  @required [:name, :nickname, :weight, :types, :trainer_id]

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required)
    |> validate_required(@required)
    |> validate_length(:nickname, min: 2)
  end
end
