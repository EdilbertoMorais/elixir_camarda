defmodule ExMon.Jogo.Acao.CurarTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  describe "curar_vida/1" do
    setup do
      jogador = ExMon.criar_jogador("Edil", :chute, :soco, :curar)

      capture_io(fn ->
        ExMon.inicio_jogo(jogador)
      end)

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
