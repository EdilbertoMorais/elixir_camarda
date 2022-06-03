defmodule ExMonWeb.Controllers.TrainersControllerTest do
  use ExMonWeb.ConnCase

  alias ExMon.Trainer

  describe "show/2" do
    test "when there is a trainer with the given id, returns the trainer", %{conn: conn} do
      # quando há um treinador com o id fornecido, retorna o treinador
      params = %{name: "Edil", password: "123456"}

      {:ok, %Trainer{id: id}} = ExMon.create_trainer(params)

      response =
        conn
        |> get(Routes.trainers_path(conn, :show, id))
        |> json_response(:ok)

      assert %{"id" => _id, "inserted_at" => _inserted_at, "name" => "Edil"} = response
    end

    test "when there is an error, returns the error", %{conn: conn} do
      # quando há um erro, retorna o erro

      response =
        conn
        |> get(Routes.trainers_path(conn, :show, "1234"))
        |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid ID format!"}

      assert response == expected_response
    end
  end
end
