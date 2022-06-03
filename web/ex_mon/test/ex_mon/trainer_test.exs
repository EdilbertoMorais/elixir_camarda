defmodule ExMon.TrainerTest do
  use ExMon.DataCase

  alias ExMon.Trainer

  describe "changeset/1" do
    test "when all params are valid, return a valid changeset" do
      # quando todos os parâmetros são válidos, retorna um changeset válido
      params = %{name: "Edil", password: "123456"}

      response = Trainer.changeset(params)

      assert %Ecto.Changeset{
               changes: %{
                 name: "Edil",
                 password: "123456"
               },
               errors: [],
               data: %ExMon.Trainer{},
               valid?: true
             } = response
    end

    test "when there are invalid params, returns an invalid changeset" do
      # quando há parâmetros inválidos, retorna um changeset inválido
      params = %{password: "123456"}

      response = Trainer.changeset(params)

      assert %Ecto.Changeset{
               changes: %{
                 password: "123456"
               },
               data: %ExMon.Trainer{},
               valid?: false
             } = response

      assert errors_on(response) == %{name: ["can't be blank"]}
    end
  end

  describe "build/1" do
    test "when all params are valid, return a trainer struct" do
      # quando todos os parâmetros são válidos, retorna uma estrutura de treinador
      params = %{name: "Edil", password: "123456"}

      response = Trainer.build(params)

      assert {:ok, %Trainer{name: "Edil", password: "123456"}} = response
    end

    test "when there are invalid params, returns an error" do
      # quando há parâmetros inválidos, retorna um erro
      params = %{password: "123456"}

      {:error, response} = Trainer.build(params)

      assert %Ecto.Changeset{valid?: false} = response

      assert errors_on(response) == %{name: ["can't be blank"]}
    end
  end
end
