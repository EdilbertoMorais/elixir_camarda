defmodule ExMon.Trainer.DeleteTest do
  use ExMon.DataCase

  alias ExMon.Trainer

  describe "call / 1" do
    test "when the ID is valid, delete the trainer" do
      # quando o ID for valido, delete o treinador
      params = %{name: "Edilberto", password: "123456"}
      {:ok, %Trainer{id: id}} = ExMon.create_trainer(params)

      assert {:ok, %Trainer{id: ^id}} = Trainer.Delete.call(id)
    end
  end

  test "When ID is invalid, return error message" do
    # Quando o ID for invalido, devolva mensagem de  erro
    invalid_id = "xxxxxxxxxxx"

    assert Trainer.Delete.call(invalid_id) == {:error, "Invalid ID format!"}
  end

  test "when the ID is valid, but the trainer does not exist" do
    # quando o ID for valido, mas o treinador não exite
    id = Ecto.UUID.generate()

    assert Trainer.Delete.call(id) == {:error, "Trainer not found!"}
  end
end
