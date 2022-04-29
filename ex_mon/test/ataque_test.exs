defmodule ExMon.Jogo.Acao.AtaqueTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Jogo

  describe "ataque_oponente/2" do
    setup do
      jogador = ExMon.criar_jogador("Edil", :chute, :soco, :curar)

      capture_io(fn ->
        ExMon.inicio_jogo(jogador)

        if Jogo.info().turno == :computer do
          Jogo.atualizar(Jogo.info())
        end
      end)

      :ok
    end

    test "quando o jogador ataca o computador, o computador realiza um movimento" do
      mensagens =
        capture_io(fn ->
          ExMon.movimentos(:chute)
        end)

      assert mensagens =~ "É A VEZ DO computador"
      assert mensagens =~ "status: :continue"
      assert mensagens =~ "turno: :computador"
      assert mensagens =~ "É A VEZ DO jogador."
    end
  end
end
