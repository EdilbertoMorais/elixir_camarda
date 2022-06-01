defmodule ExMon.Trainer do
  use Ecto.Schema

  import Ecto.Changeset

  alias ExMon.Trainer.Pokemon

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "trainers" do
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    has_many(:pokemon, Pokemon)

    # usa-se o has_many, para informar que o relacionamento é um para varios, neste caso um trainer
    # para varios pokemons (1 arg o nome do schema, 2 arg o modulo ExMon.Trainer.Pokemon)
    timestamps()
  end

  @requerid_params [:name, :password]

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params), do: create_changeset(%__MODULE__{}, params)
  def changeset(trainer, params), do: create_changeset(trainer, params)

  defp create_changeset(module_or_trainer, params) do
    module_or_trainer
    |> cast(params, @requerid_params)
    |> validate_required(@requerid_params)
    |> validate_length(:password, min: 6)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
