defmodule ExMon.JogoTest do
  use ExUnit.Case

  alias ExMon.{Jogo, Jogador}

  describe "inicio/2" do
    test "iniciar o estado do jogo" do
      jogador = ExMon.criar_jogador("Edil", :chute, :soco, :curar)
      computador = ExMon.criar_jogador("Robo", :chute, :soco, :curar)

      assert {:ok, _pid} = Jogo.inicio(computador, jogador)
    end
  end

  describe "info/0" do
    test "retorna o estado corrente do jogo" do
      jogador = ExMon.criar_jogador("Edil", :chute, :soco, :curar)
      computador = ExMon.criar_jogador("Robo", :chute, :soco, :curar)

      Jogo.inicio(computador, jogador)

      resposta_esperada = :iniciado

      assert resposta_esperada == Jogo.info().status
    end
  end

  describe "atualizar/1" do
    test "retornar a atualização do estado do jogo" do
      jogador = ExMon.criar_jogador("Edil", :chute, :soco, :curar)
      computador = ExMon.criar_jogador("Robo", :chute, :soco, :curar)

      Jogo.inicio(computador, jogador)

      # if Jogo.info().turno == :computer do
      #   Jogo.atualizar(Jogo.info())
      # end

      # resposta_esperada = %{
      #   computador: %Jogador{
      #     movimentos: %{chute: :chute, curar: :curar, soco: :soco},
      #     nome: "Robo",
      #     vida: 100
      #   },
      #   jogador: %Jogador{
      #     movimentos: %{chute: :chute, curar: :curar, soco: :soco},
      #     nome: "Edil",
      #     vida: 100
      #   },
      #   status: :iniciado,
      #   turno: :jogador
      # }

      # assert resposta_esperada == Jogo.info()

      nova_resposta_esperada = %{
        computador: %Jogador{
          movimentos: %{chute: :chute, curar: :curar, soco: :soco},
          nome: "Robo",
          vida: 85
        },
        jogador: %Jogador{
          movimentos: %{chute: :chute, curar: :curar, soco: :soco},
          nome: "Edil",
          vida: 50
        },
        status: :iniciado,
        turno: :jogador
      }

      Jogo.atualizar(nova_resposta_esperada)

      resposta_esperada = %{nova_resposta_esperada | turno: :computador, status: :continue}

      assert resposta_esperada == Jogo.info()
    end
  end

  describe "jogador/0" do
    test "retornar a estrutura do jogador" do
      jogador = ExMon.criar_jogador("Edil", :chute, :soco, :curar)
      computador = ExMon.criar_jogador("Robo", :chute, :soco, :curar)

      Jogo.inicio(computador, jogador)

      resposta_esperada = %ExMon.Jogador{
        movimentos: %{chute: :chute, curar: :curar, soco: :soco},
        nome: "Edil",
        vida: 100
      }

      assert resposta_esperada == Jogo.jogador()
    end
  end

  describe "turno/0" do
    test "retornar o turno do jogo" do
      jogador = ExMon.criar_jogador("Edil", :chute, :soco, :curar)
      computador = ExMon.criar_jogador("Robo", :chute, :soco, :curar)

      Jogo.inicio(computador, jogador)

      if Jogo.info().turno == :computer do
        Jogo.atualizar(Jogo.info())
      end

      assert Jogo.turno() in [:computador, :jogador]

      # assert %{turno: :jogador} = Jogo.info()
      # buscando a chave turno: dentro do map tb da certo
    end
  end

  describe "buscar_jogador/0" do
    test "retornar os dados do jogador" do
      jogador = ExMon.criar_jogador("Edil", :chute, :soco, :curar)
      computador = ExMon.criar_jogador("Robo", :chute, :soco, :curar)

      Jogo.inicio(computador, jogador)

      resposta_esperada = %ExMon.Jogador{
        movimentos: %{chute: :chute, curar: :curar, soco: :soco},
        nome: "Edil",
        vida: 100
      }

      assert resposta_esperada == Jogo.info().jogador
    end
  end
end
