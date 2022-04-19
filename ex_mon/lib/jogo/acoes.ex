defmodule ExMon.Jogo.Acoes do
  alias ExMon.Jogo

  def atacar(movimento) do
    case Jogo.turno() do
      :jogador -> "Ataca o computador"
      :computador -> "Ataca o jogador"
    end
  end

  def buscar_movimentos(movimento) do
    Jogo.jogador()
    |> Map.get(:movimentos)
    |> confirmar_movimento(movimento)
  end

  defp confirmar_movimento(movimentos, movimento) do
    Enum.find_value(movimentos, {:error, movimento}, fn {chave, valor} ->
      if valor == movimento, do: {:ok, chave}
    end)
  end
end
