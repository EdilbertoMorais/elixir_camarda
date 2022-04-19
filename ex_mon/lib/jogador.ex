defmodule ExMon.Jogador do
  @chaves_necessarias [:nome, :movimentos, :vida]
  @maximo_vida 100

  @enforce_keys @chaves_necessarias
  defstruct @chaves_necessarias

  def jogador(nome, chute, soco, curar) do
    %ExMon.Jogador{
      movimentos: %{
        chute: chute,
        soco: soco,
        curar: curar
      },
      nome: nome,
      vida: @maximo_vida
    }
  end
end
