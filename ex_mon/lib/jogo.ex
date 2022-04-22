defmodule ExMon.Jogo do
  alias ExMon.Jogador
  use Agent

  def inicio(computador, jogador) do
    valor_inicial = %{
      computador: computador,
      jogador: jogador,
      turno: :jogador,
      status: :iniciado
    }

    Agent.start_link(fn -> valor_inicial end, name: __MODULE__)
  end

  def info do
    Agent.get(__MODULE__, & &1)
  end

  def atualizar(estado) do
    Agent.update(__MODULE__, fn _ -> atualizar_estado_jogo(estado) end)
  end

  def jogador, do: Map.get(info(), :jogador)
  ExM
  def buscar_jogador(jogador), do: Map.get(info(), jogador)

  defp atualizar_estado_jogo(
         %{jogador: %Jogador{vida: vida_jogador}, computador: %Jogador{vida: vida_computador}} =
           estado
       )
       when vida_jogador == 0 or vida_computador == 0,
       do: Map.put(estado, :status, :fim_do_jogo)

  defp atualizar_estado_jogo(estado) do
    estado
    |> Map.put(:status, :continue)
    |> atualizar_turno()
  end

  defp atualizar_turno(%{turno: :jogador} = estado), do: Map.put(estado, :turno, :computador)
  defp atualizar_turno(%{turno: :computador} = estado), do: Map.put(estado, :turno, :jogador)
end
