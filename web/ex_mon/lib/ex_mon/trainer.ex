defmodule ExMon.Trainer do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "trainers" do
    field :name, :string
    field :password_hash, :string
    timestamps()
  end

  @requerid_params [:name, :password_hash]
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @requerid_params)
    |> validate_required(@requerid_params)
  end

end
