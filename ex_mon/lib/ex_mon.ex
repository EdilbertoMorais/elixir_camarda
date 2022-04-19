defmodule ExMon do
  alias ExMon.{Jogo, Jogador}
  alias ExMon.Jogo.{Acoes, Status}

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
  end

  def movimentos(movimento) do
    movimento
    |> Acoes.buscar_movimentos()
    |> lutando()
  end

  defp lutando({:error, movimento}), do: Status.mensagem_movimento_errado(movimento)

  defp lutando({:ok, movimento}) do
    case movimento do
      :curar -> "realiza_cura"
      movimento -> Acoes.atacar(movimento)
    end

    Status.mensagem_da_rodada(Jogo.info())
  end
end
