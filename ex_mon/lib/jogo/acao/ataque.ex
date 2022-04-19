defmodule ExMon.Jogo.Acao.Ataque do
  alias ExMon.Jogo
  alias ExMon.Jogo.Status

  @soco 18..25
  @chute 10..35

  def ataque_oponente(oponente, movimento) do
    dano = calculo_poder(movimento)

    oponente
    |> Jogo.buscar_jogador()
    |> Map.get(:vida)
    |> calcula_total_vida(dano)
    |> atualizar_vida_oponente(oponente, dano)
  end

  defp calculo_poder(:soco), do: Enum.random(@soco)
  defp calculo_poder(:chute), do: Enum.random(@chute)

  defp calcula_total_vida(vida, dano) when vida - dano < 0, do: 0
  defp calcula_total_vida(vida, dano), do: vida - dano

  defp atualizar_vida_oponente(vida, oponente, dano) do
    oponente
    |> Jogo.buscar_jogador()
    |> Map.put(:vida, vida)
    |> atualizar_jogo(oponente, dano)
  end

  defp atualizar_jogo(jogador, oponente, dano) do
    Jogo.info()
    |> Map.put(oponente, jogador)
    |> Jogo.atualizar()

    Status.mensagem_movimento(oponente, :movimento, dano)
  end
end
