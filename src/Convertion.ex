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
