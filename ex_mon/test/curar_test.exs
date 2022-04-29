defmodule ExMon.Jogo.Acao.CurarTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Jogo

  describe "curar_vida/1" do
    setup do
      jogador = ExMon.criar_jogador("Edil", :chute, :soco, :curar)
      computador = ExMon.criar_jogador("Robo", :chute, :soco, :curar)

      Jogo.inicio(computador, jogador)
      # jogador = ExMon.criar_jogador("Edil", :chute, :soco, :curar)
      # ExMon.inicio_jogo(jogador)

      if Jogo.info().turno == :computador do
        Jogo.atualizar(Jogo.info())
      end

      :ok
    end

    test "quando o jogador realiza o movimento de curar" do
      mensagens =
        capture_io(fn ->
          ExMon.movimentos(:curar)
        end)

      assert mensagens =~ "O jogador se RECUPEROU"
    end
  end
end
