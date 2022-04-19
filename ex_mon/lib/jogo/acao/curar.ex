defmodule ExMon.Jogo.Acao.Curar do
  alias ExMon.Jogo
  alias ExMon.Jogo.Status

  @poder_curar 18..25

  def curar_vida(jogador) do
    jogador
    |> Jogo.buscar_jogador()
    |> Map.get(:vida)
    |> calcula_total_vida()
    |> definir_vida(jogador)
  end

  defp calcula_total_vida(vida), do: Enum.random(@poder_curar) + vida

  defp definir_vida(vida, jogador) when vida > 100, do: atualizar_vida_jogador(jogador, 100)
  defp definir_vida(vida, jogador), do: atualizar_vida_jogador(jogador, vida)

  defp atualizar_vida_jogador(jogador, vida) do
    jogador
    |> Jogo.buscar_jogador()
    |> Map.put(:vida, vida)
    |> atualizar_jogo(jogador, vida)
  end

  defp atualizar_jogo(dados_jogador, jogador, vida) do
    Jogo.info()
    |> Map.put(jogador, dados_jogador)
    |> Jogo.atualizar()

    Status.mensagem_movimento(jogador, :curar, vida)
  end
end
