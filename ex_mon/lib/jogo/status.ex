defmodule ExMon.Jogo.Status do
  alias ExMon.Jogo

  def mensagem_da_rodada() do
    IO.puts("\n==== O jogo foi iniciado ====\n")
    IO.inspect(Jogo.info())
    IO.puts("-----------------------------------")
  end

  def mensagem_movimento_errado(movimento) do
    IO.puts("\n==== Movimento invalido: #{movimento}. ====\n")
  end
end
