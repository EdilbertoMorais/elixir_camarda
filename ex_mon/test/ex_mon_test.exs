defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Jogador

  describe "criar_jogador/4" do
    test "retorna um jogador" do
      resposta_esperada = %Jogador{
        movimentos: %{chute: :chute, curar: :curar, soco: :soco},
        nome: "Edil",
        vida: 100
      }

      assert resposta_esperada == ExMon.criar_jogador("Edil", :chute, :soco, :curar)
    end
  end

  describe "inicio_jogo/1" do
    test "quando o jogo inciar, retorna uma mensagem" do
      jogador = ExMon.criar_jogador("Edil", :chute, :soco, :curar)

      mensagens =
        capture_io(fn ->
          assert ExMon.inicio_jogo(jogador) == :ok
        end)
        # O =~ te da a opção de procurar apenas pelo conteudo informado a seguir, no caso abaixo a String
        # devolvida é muito grande, assim, com esse metodo, caso a msg abaixo apareça na string como retorno
        # o teste já sera aprovado
        assert mensagens =~ "O JOGO FOI INICIADO"
        assert mensagens =~ "status: :iniciado"
        assert mensagens =~ "turno: :jogador"
    end
  end

  # describe "movimentos/1" do
  #   test "quando o movimento for valido, o jogador movimenta, depois o computador movimenta" do
  #     jogador = ExMon.criar_jogador("Edil", :chute, :soco, :curar)
  #     ExMon.inicio_jogo(jogador)

  #     mensagens =
  #       capture_io(fn ->
  #         ExMon.movimentos(:chute)
  #       end)

  #       assert "banana" == mensagens
  #   end
  # end
end
