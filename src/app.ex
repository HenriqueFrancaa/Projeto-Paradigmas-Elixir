defmodule App do
  def exibirMenu do
    IO.puts("""
    ========== MENU DE OPÇÕES ==========
    1. Conversão de moedas
    2. Verificação de CPF/Email
    3. Estatísticas de um vetor númerico
    0. Finalizar
    ====================================
    """)

    op =
      IO.gets("> ")
      |> String.trim()

    try do
      op = String.to_integer(op)

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
          IO.puts("======== Finalizando Aplicação =========")

        _ ->
          IO.puts("Você selecionou uma opção inválida!")
      end

      if op != 0 do
        IO.puts("\e[H\e[2J")
        exibirMenu()
      end
    rescue
      ArgumentError ->
        IO.puts("Você selecionou uma opção inválida")
        exibirMenu()
    end
  end
end

App.exibirMenu()
