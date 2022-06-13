defmodule ExMonWeb.TrainersView do
  use ExMonWeb, :view

  alias ExMon.Trainer

  def render("create.json", %{
        trainer: %Trainer{id: id, name: name, inserted_at: inserted_at},
        token: token
      }) do
    %{
      message: "Trainer created!",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at
      },
      token: token
    }
  end

  # def render("show_all.json", %{trainers: trainers}) do
  #   render_many(trainers, ExMonWeb.TrainersView, "show.json")
  # end

  def render("show.json", %{
        trainer: %Trainer{id: id, name: name, inserted_at: inserted_at, pokemon: pokemon}
      }) do
    %{
      id: id,
      name: name,
      inserted_at: inserted_at,
      pokemon: pokemon
    }
  end

  # def render("show.json", %{
  #       trainers: %Trainer{id: id, name: name, inserted_at: inserted_at, pokemon: pokemon}
  #     }) do
  #   %{
  #     id: id,
  #     name: name,
  #     inserted_at: inserted_at,
  #     pokemon: pokemon
  #   }
  # end

  def render("update.json", %{
        trainer: %Trainer{
          id: id,
          name: name,
          inserted_at: inserted_at,
          updated_at: updated_at,
          pokemon: pokemon
        }
      }) do
    %{
      message: "Trainer updated!",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at,
        updated_at: updated_at,
        pokemon: pokemon
      }
    }
  end
end
