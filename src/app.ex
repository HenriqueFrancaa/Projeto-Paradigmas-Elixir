defmodule Convertion do
  def option() do
    value =
      IO.gets("Digite o valor: ")
      |> String.trim()
      |> String.to_float()

    op =
      IO.gets("Converter para:\n1. Dólar\n2. Euro\n> ")
      |> String.trim()
      |> String.to_integer()

    case op do
      1 ->
        IO.puts("Convertendo para dólar...")
        IO.puts("R$ #{value} equivale a US$ #{convertDolar(value)}")

      2 ->
        IO.puts("Convertendo para euro...")
        IO.puts("Resultado: #{convertEuro(value)}")

      _ ->
        IO.puts("Opção inválida!")
    end
  end
  defp convertDolar(value), do: value / 5.30
  defp convertEuro(value),  do: value / 6.00
end

defmodule VectorStatistics do
  def initVector() do
    vector = collect([])
    IO.inspect(vector)
    options(vector)
  end

  defp options(vector) do
    op = IO.gets(
        """
        === O que deseja saber sobre o vetor? ===
        1. Média
        2. Mediana
        3. Mínimo
        4. Máximo
        ==========================================
        """
      )
      |> String.trim()
      |> String.to_integer()


    case op do
      1 ->
        IO.inspect("A média é: #{getAvrg(vector)}")
      2 ->
        IO.inspect("A mediana é: #{getMedian(vector)}")
      3 ->
        IO.inspect("O menor valor é: #{getMin(vector)}")
      4 ->
        IO.inspect("O maior valor é: #{getMax(vector)}")
    end
  end

  defp collect(vector) do
    n = IO.gets("Insira um número (ou '#' para parar): ") |> String.trim()

    case n do
      "#" ->
        IO.puts("Encerrando inserções...\n")
        vector
      _ ->
        valor = String.to_integer(n)
        collect(vector ++ [valor])
    end
  end

  defp getAvrg(vector), do: Enum.sum(vector) / length(vector)

  defp getMedian(vector) do
    vector = Enum.sort(vector)
    n = length(vector)

    if rem(n, 2) == 1 do # quantidade impar
      Enum.at(vector, div(n, 2))
    else
      # fazendo a média dos dois centrais
      mid1 = Enum.at(vector, div(n, 2) - 1)
      mid2 = Enum.at(vector, div(n, 2))
      (mid1 + mid2) / 2
    end
  end

  defp getMin(vector) do
    vector = Enum.sort(vector)
    hd(vector)
  end

  defp getMax(vector) do
    vector = Enum.sort(vector)
    Enum.at(vector, length(vector)-1)
  end
end

IO.puts("""
=== Bem-vindo para a aplicação ===
1. Conversão de real para dólar ou euro
2. Verificação de CPF/Email
3. Estatísticas de um vetor númerico
0. Finalizar
==================================
""")

op =
  IO.gets("> ")
  |> String.trim()
  |> String.to_integer()

case op do
  1 ->
    IO.puts("Você escolheu a opção 1")
    Convertion.option()

  2 ->
    IO.puts("Você escolheu a opção 2")

  3 ->
    IO.puts("Você escolheu a opção 3")
    VectorStatistics.initVector()

  0 ->
    IO.puts("Finalizando")
end
