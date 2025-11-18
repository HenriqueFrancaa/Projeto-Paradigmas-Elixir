defmodule Convertion do
  def option() do
    try do
      op =
        IO.gets("""
        === Deseja converter para? ===
        1. Real  ->  Dólar
        2. Real  ->  Euro
        3. Dólar ->  Real
        4. Euro  ->  Real
        0. Sair
        =============================
        """)
        |> String.trim()
        |> String.to_integer()

      case op do
        0 ->
          IO.puts("Saindo...")
          # para terminar sem recursão
          :ok

        1 ->
          value = read_value()
          IO.puts("Convertendo R$ #{format(value)} para dólar...")
          IO.puts("R$ #{format(value)} equivale a US$ #{format(convertToDolar(value))}")
          option()

        2 ->
          value = read_value()
          IO.puts("Convertendo R$ #{format(value)} para euro...")
          IO.puts("R$ #{format(value)} equivale a € #{format(convertToEuro(value))}")
          option()

        3 ->
          value = read_value()
          IO.puts("Convertendo US$ #{format(value)} para Real...")
          IO.puts("US$ #{format(value)} equivale a R$ #{format(convertDolarToReal(value))}")
          option()

        4 ->
          value = read_value()
          IO.puts("Convertendo € #{format(value)} para Real...")
          IO.puts("€ #{format(value)} equivale a R$ #{format(convertEuroToReal(value))}")
          option()

        _ ->
          IO.puts("Opção inválida!")
          option()
      end
    rescue
      ArgumentError ->
        IO.puts("\nERRO: Você digitou um valor inválido! Tente novamente.")
        option()
    end
  end

  defp read_value() do
    input = IO.gets("> Digite o valor: ") |> String.trim()

    if String.contains?(input, ".") do
      String.to_float(input)
    else
      String.to_integer(input) * 1.0
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
