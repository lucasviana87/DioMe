# Vamos solicitar como entrada dois números e depois vamos realizar uma operação simples entre eles.

# Entrada de valores
texto = input("Digite uma string: ")
entrada_numero = input("Digite um número inteiro: ")

# Verifica se digitou um número inteiro
if entrada_numero.isdigit():
    numero = int(entrada_numero)
    print((texto + " ") * numero)

# Erro caso não digite o número inteiro
else:
    print("Erro: só aceito número inteiro no campo de número.")