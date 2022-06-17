defmodule ExMon.Trainer.UpdateTest do
  use ExMon.DataCase

  alias ExMon.Trainer

  describe "call/1" do
    test "when the ID is valid, update the trainer" do
      # quando o ID for valido, atualiza o treinador
      params = %{name: "TrainerTeste", password: "123456"}
      {:ok, %Trainer{id: id}} = ExMon.create_trainer(params)

      new_params = %{"id" => id, "name" => "NEWTrainer", "password" => "987654321"}

      assert {:ok, %Trainer{id: ^id, name: "NEWTrainer", password: "987654321"}} =
               Trainer.Update.call(new_params)
    end

    test "When ID is invalid, return error message" do
      # Quando o ID for invalido, devolva mensagem de  erro
      new_params = %{"id" => "01232165165156", "name" => "NEWTrainer", "password" => "987654321"}

      assert Trainer.Update.call(new_params) == {:error, "Invalid ID format!"}
    end

    test "when the ID is valid, but the trainer does not exist" do
      # quando o ID for valido, mas o treinador não exite
      new_params = %{
        "id" => Ecto.UUID.generate(),
        "name" => "NEWTrainer2",
        "password" => "123456789"
      }

      assert Trainer.Update.call(new_params) == {:error, "Trainer not found!"}
    end
  end
end
