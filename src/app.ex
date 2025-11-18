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
