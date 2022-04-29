defmodule ExMon do
  alias ExMon.{Jogo, Jogador}
  alias ExMon.Jogo.{Acoes, Status}

  @ataque_computador [:chute, :soco, :curar]

  @nome_computador "Robo"

  def criar_jogador(nome, chute, soco, curar) do
    Jogador.jogador(nome, chute, soco, curar)
  end

  def inicio_jogo(jogador) do
    # computador = criar_jogador("Robo", :chute, :soco, :curar)
    # Jogo.inicio(computador, jogador)
    # --------------------------------------------------------------
    # Aplicando Pipe Operator abaixo
    # a variavel passa a ser o primeiro atributo ("Robo") que é o primeiro atibuto da função
    # criar_jogador, que é chamada com pipe operator, informando os demais atributos, passando o
    # resultado para a função inicio, usando o resultado da função criar_jogador como primeiro
    # atributo da função inicio

    @nome_computador
    |> criar_jogador(:chute, :soco, :curar)
    |> Jogo.inicio(jogador)

    Status.mensagem_da_rodada(Jogo.info())

    movimento_computador(Jogo.info())
  end

  def movimentos(movimento) do
    Jogo.info()
    |> Map.get(:status)
    |> tratar_status(movimento)
  end

  defp tratar_status(:fim_do_jogo, _movimento), do: Status.mensagem_da_rodada(Jogo.info())

  defp tratar_status(_outro, movimento) do
    movimento
    |> Acoes.buscar_movimentos()
    |> lutando()

    movimento_computador(Jogo.info())
  end

  defp lutando({:error, movimento}), do: Status.mensagem_movimento_errado(movimento)

  defp lutando({:ok, movimento}) do
    case movimento do
      :curar -> Acoes.curar()
      movimento -> Acoes.atacar(movimento)
    end

    Status.mensagem_da_rodada(Jogo.info())
  end

  defp movimento_computador(%{turno: :computador, status: :iniciado}) do
    movimento = {:ok, Enum.random([:chute, :soco])}
    lutando(movimento)
  end

  # verificar se temos outra forma de priorizar o movimento de curar
  defp movimento_computador(%{turno: :computador, vida: vida_computador})
       when vida_computador <= 40 do
    movimento = {:ok, Enum.random([:chute, :soco, :curar, :curar])}
    lutando(movimento)
  end

  defp movimento_computador(%{turno: :computador, status: :continue}) do
    movimento = {:ok, Enum.random(@ataque_computador)}
    lutando(movimento)
  end

  defp movimento_computador(_), do: :ok
end
