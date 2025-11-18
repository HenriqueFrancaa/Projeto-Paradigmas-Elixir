defmodule VectorStatistics do
  def initVector() do
    vector = collect([])
    IO.inspect(vector)
    options(vector)
  end

  defp options(vector) do
    op =
      IO.gets("""
      === O que deseja saber sobre o vetor? ===
      1. Média
      2. Mediana
      3. Mínimo
      4. Máximo
      ==========================================
      >
      """)
      |> String.trim()
      |> String.to_integer()

    case op do
      1 ->
        IO.puts("A média é: #{getAvrg(vector)}")

      2 ->
        IO.puts("A mediana é: #{getMedian(vector)}")

      3 ->
        IO.puts("O menor valor é: #{getMin(vector)}")

      4 ->
        IO.puts("O maior valor é: #{getMax(vector)}")
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

    # quantidade impar
    if rem(n, 2) == 1 do
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
    Enum.at(vector, length(vector) - 1)
  end
end
