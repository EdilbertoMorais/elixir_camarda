defmodule FizzBuzz do
  def build(file_name) do
    # case File.read(file_name) do
    #   {:ok, result} -> result
    #   {:error, reason} -> reason  
    # end

    # file = File.read(file_name)
    # handle_file_read(file)

    # metodo mais legivel usando Pipe Operator com Pattern Matching
    file_name
    # esse acima será passado como primeiro parametro para o de baixo
    |> File.read()
    # não precisa de parametro pq ele pegou o resultado acima 
    |> handle_file_read()
  end

  # Pattern Matching
  defp handle_file_read({:ok, result}) do
    # passamos o result para o primeiro argumento da função String.split(list, ",")
    result =
      result
      |> String.split(",")
      # a função acima devolve como primeiro argumento a lista de Strings separada por ","
      |> Enum.map(&converter_and_evaluate_numbers/1)

    {:ok, result}
  end

  defp handle_file_read({:error, reason}), do: {:error, "Error reading the file: #{reason}"}

  defp converter_and_evaluate_numbers(elem) do
    elem
    |> String.to_integer()
    |> evaluate_numbers()
  end

  defp evaluate_numbers(number) when rem(number, 3) == 0 and rem(number, 5) == 0, do: :fizzbuzz
  defp evaluate_numbers(number) when rem(number, 3) == 0, do: :fizz
  defp evaluate_numbers(number) when rem(number, 5) == 0, do: :buzz
  defp evaluate_numbers(number), do: number
end
