defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Jogador

  describe "criar_jogador/4" do
    test "retorna um jogador" do
      resposta_esperada = %Jogador{
        movimentos: %{chute: :chute, curar: :curar, soco: :soco},
        nome: "Edil",
        vida: 100
      }

      assert resposta_esperada == ExMon.criar_jogador("Edil", :chute, :soco, :curar)
    end
  end

  describe "inicio_jogo/1" do
    test "quando o jogo inciar, retorna uma mensagem" do
      jogador = ExMon.criar_jogador("Edil", :chute, :soco, :curar)

      # após capturarmos a mensagem com o capture_io, precisamos atribuir esse resultado
      # a uma variável para podermos usá-la, neste caso a (mensagens) será a variavel

      mensagens =
        capture_io(fn ->
          assert ExMon.inicio_jogo(jogador) == :ok
          # tudo que queremos capturar, fica dentro desse bloco
        end)

      # O =~ te da a opção de procurar apenas pelo conteudo informado a seguir, no caso abaixo a String
      # devolvida é muito grande, assim, com esse metodo, caso a msg abaixo apareça na string como retorno
      # o teste já sera aprovado
      assert mensagens =~ "O JOGO FOI INICIADO"
      assert mensagens =~ "status: :iniciado"
      assert mensagens =~ "turno: :jogador"
      # Usamos a variável (mensagens) acima para fazer o assert e chegarmos ao resultado esperado
    end
  end

  describe "movimentos/1" do
    setup do
      jogador = ExMon.criar_jogador("Edil", :chute, :soco, :curar)

      capture_io(fn ->
        ExMon.inicio_jogo(jogador)
      end)

      :ok
    end

    test "quando o movimento for valido, o jogador movimenta, depois o computador movimenta" do
      mensagens =
        capture_io(fn ->
          ExMon.movimentos(:chute)
        end)

      assert mensagens =~ "O JOGADOR atacou o ROBO"
      assert mensagens =~ "É A VEZ DO computador"
      assert mensagens =~ "status: :continue"
    end

    test "quando o movimento for invalido, retorna mensagem de erro" do
      mensagens =
        capture_io(fn ->
          ExMon.movimentos(:voadora)
        end)

      assert mensagens =~ "Movimento invalido: voadora."
    end
  end
end
