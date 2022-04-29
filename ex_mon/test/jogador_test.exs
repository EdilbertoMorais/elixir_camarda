defmodule ExMon.JogadorTest do
  use ExUnit.Case

  describe "jogador/4" do
    test "criando jogador" do
      resposta_esperada = %ExMon.Jogador{
        movimentos: %{chute: :chute, curar: :curar, soco: :soco},
        nome: "Edil",
        vida: 100
      }

      assert resposta_esperada == ExMon.Jogador.jogador("Edil", :chute, :soco, :curar)
    end
  end
end
