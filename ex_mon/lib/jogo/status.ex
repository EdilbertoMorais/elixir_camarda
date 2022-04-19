defmodule ExMon.Jogo.Status do

  def mensagem_da_rodada(%{status: :iniciado} = info) do
    IO.puts("\n==== O JOGO FOI INICIADO ====\n")
    IO.inspect(info)
    IO.puts("-----------------------------------")
  end

  def mensagem_da_rodada(%{status: :continue, turno: jogador} = info) do
    IO.puts("\n==== É a vez do #{jogador}. ====\n")
    IO.inspect(info)
    IO.puts("-----------------------------------")
  end

  def mensagem_da_rodada(%{status: :fim_do_jogo} = info) do
    IO.puts("\n==== FIM DO JOGO. ====\n")
    IO.inspect(info)
    IO.puts("-----------------------------------")
  end

  def mensagem_movimento_errado(movimento) do
    IO.puts("\n==== Movimento invalido: #{movimento}. ====\n")
  end

  def mensagem_movimento(:computador, :movimento, dano) do
    IO.puts("\n==== O jogador atacou o Robo dando #{dano} de dano. ====\n")
  end

  def mensagem_movimento(:jogador, :movimento, dano) do
    IO.puts("\n==== O Robo atacou o jogador dando #{dano} de dano. ====\n")
  end
end
