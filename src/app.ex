defmodule Convertion do
  def option() do
    try do
      input =
        IO.gets("Digite o valor: ") |> String.trim()

      value =
        if String.contains?(input, ".") do
          String.to_float(input)
        else
          String.to_integer(input) / 1
        end

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
          IO.puts("Convertendo R$ #{format(value)} para dólar...")
          IO.puts("R$ #{format(value)} equivale a US$ #{format(convertToDolar(value))}")

        2 ->
          IO.puts("Convertendo R$ #{format(value)} para euro...")
          IO.puts("R$ #{format(value)} equivale a € #{format(convertToEuro(value))}")

        3 ->
          IO.puts("Convertendo US$ #{format(value)} para Real...")
          IO.puts("US$ #{format(value)} equivale a R$ #{format(convertDolarToReal(value))}")

        4 ->
          IO.puts("Convertendo € #{format(value)} para Real...")
          IO.puts("€ #{format(value)} equivale a R$ #{format(convertEuroToReal(value))}")

        _ ->
          IO.puts("Opção inválida!")
      end
    rescue
      ArgumentError ->
        IO.puts("\nERRO: Você digitou um valor inválido! Tente novamente.")
        option()

      _e ->
        IO.puts("\nERRO desconhecido.")
        option()
    end
  end

  defp format(value) do
    :erlang.float_to_binary(value, decimals: 2)
  end

  # Valores de moedas atualizados (17 de novembro de 2025)
  defp convertToDolar(value), do: value / 5.33
  defp convertToEuro(value), do: value / 6.18
  defp convertDolarToReal(value), do: value / 0.19
  defp convertEuroToReal(value), do: value / 0.16
end

defmodule Validate do
  def option() do
    op =
      IO.gets("""
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
        email = IO.gets("Digite o email: ") |> String.trim()

        if(validEmail(email)) do
          IO.puts("O email #{email} é válido!")
        else
          IO.puts("O email #{email} é inválido!")
        end

      2 ->
        cpf = IO.gets("Digite o CPF: ") |> String.trim()

        if(validCpf(cpf)) do
          IO.puts("O CPF #{cpf} é válido!")
        else
          IO.puts("O CPF #{cpf} é inválido")
        end
    end
  end

  defp validEmail(email) do
    Regex.match?(~r/^[\w._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/, email)
  end

  defp validCpf(cpf) do
    cpf_clean = String.replace(cpf, ~r/[^\d]/, "")

    cond do
      String.length(cpf_clean) != 11 -> false
      all_same_digits?(cpf_clean) -> false
      true -> verify_calculation(cpf_clean)
    end
  end

  defp verify_calculation(cpf) do
    digits = cpf |> String.graphemes() |> Enum.map(&String.to_integer/1)

    first_nine = Enum.take(digits, 9)
    first_ten = Enum.take(digits, 10)

    # calculo dos dois ultimos digitos verificadores
    dv1 = calculate_digit(first_nine, 10)
    dv2 = calculate_digit(first_ten, 11)

    actual_dv1 = Enum.at(digits, 9)
    actual_dv2 = Enum.at(digits, 10)

    dv1 == actual_dv1 and dv2 == actual_dv2
  end

  defp calculate_digit(numbers, start_weight) do
    # sequência de pesos (10, 9, 8, ..., 2) ou (11, 10, 9, ..., 2)
    weights = Enum.to_list(start_weight..2//-1)

    # (n1 * w1) + (n2 * w2) + ... + (n9 * wN)
    sum =
      Enum.zip(numbers, weights)
      |> Enum.map(fn {n, w} -> n * w end)
      |> Enum.sum()

    remainder = rem(sum * 10, 11)

    if remainder == 10, do: 0, else: remainder
  end

  defp all_same_digits?(cpf) do
    cpf |> String.graphemes() |> Enum.uniq() |> length() == 1
  end
end

defmodule VectorStatistics do
  def initVector() do
    vector = collect([])
    IO.puts(vector)
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
