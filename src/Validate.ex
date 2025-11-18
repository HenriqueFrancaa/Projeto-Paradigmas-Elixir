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
