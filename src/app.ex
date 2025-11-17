defmodule Convertion do
  def option() do
    value =
      IO.gets("Digite o valor: ")
      |> String.trim()
      |> String.to_float()

    op =
      IO.gets("""
        === Deseja converter para? ===
      1. Real -> Dólar
      2. Real -> Euro
      3. Dólar -> Real
      4. Euro -> Real
      =============================
      >
      """)
      |> String.trim()
      |> String.to_integer()

    case op do
      1 ->
        IO.puts("Convertendo R$ #{value} para dólar...")
        IO.puts("R$ #{value} equivale a US$ #{convertToDolar(value)}")

      2 ->
        IO.puts("Convertendo R$ #{value} para euro...")
        IO.puts("R$ #{value} equivale a € #{convertToEuro(value)}")

      3 ->
        IO.puts("Convertendo US$ #{value} para Real...")
        IO.puts("US$ #{value} equivale a R$ #{convertDolarToReal(value)}")
      4 ->
        IO.puts("Convertendo € #{value} para Real...")
        IO.puts("€ #{value} equivale a R$ #{convertEuroToReal(value)}")
      _->
        IO.puts("Opção inválida!")
    end
  end
  # Valores de moedas atualizados(17 de novembro)
  defp convertToDolar(value), do: value / 5.33
  defp convertToEuro(value),  do: value / 6.18
  defp convertDolarToReal(value), do: value / 0.19
  defp convertEuroToReal(value), do: value / 0.16
end

defmodule Validate do
  def option() do
    op = IO.gets("""
      === O que deseja validar? ===
      1. Email
      2. CPF
      =============================
      >
    """)
    |> String.trim()
    |> String.to_integer()
    case op do
      1 ->
        email = IO.gets("Digite o email: ")
        if(validEmail(email)) do
          IO.inspect("O email #{email} é válido!")
        else
          IO.inspect("O email #{email} é inválido!")
        end
      2 ->
        cpf = IO.gets("Digite o CPF: ")
        if(validCpf(cpf)) do
          IO.inspect("O CPF #{cpf} é válido!")
        else
          IO.inspect("O CPF #{cpf} é inválido")
        end
    end

  end

  defp validEmail(email) do
    Regex.match?(~r/^[\w._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/, email)
  end

  defp validCpf(cpf) do

  end
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
        >
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
1. Conversão de moedas
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
    Validate.option()
  3 ->
    IO.puts("Você escolheu a opção 3")
    VectorStatistics.initVector()

  0 ->
    IO.puts("Finalizando")
end
