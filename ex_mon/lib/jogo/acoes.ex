defmodule ExMon.Jogo.Acoes do
  alias ExMon.Jogo
  alias ExMon.Jogo.Acao.{Ataque, Curar}

  def atacar(movimento) do
    case Jogo.turno() do
      :jogador -> Ataque.ataque_oponente(:computador, movimento)
      :computador -> Ataque.ataque_oponente(:jogador, movimento)
    end
  end

  def curar() do
    case Jogo.turno() do
      :jogador -> Curar.curar_vida(:jogador)
      :computador -> Curar.curar_vida(:computador)
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
