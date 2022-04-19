defmodule ExMon.Jogo do
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

  def jogador, do: Map.get(info(), :jogador)
  def turno, do: Map.get(info(), :turno)
end
