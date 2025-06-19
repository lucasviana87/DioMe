# Vamos solicitar como entrada dois números e depois vamos realizar uma operação simples entre eles.

# Recebendo os dados do usuário
numero1 = int(input("Digite o primeiro número inteiro: "))
numero2 = int(input("Digite o segundo número inteiro: "))

# Recebendo a operação digitada
operacao = input("Digite a operação que deseja realizar (+ , - , * , / ): ")

# Realizando soma
if operacao == '+':
    print(numero1 + numero2)

# Realizando subtração
elif operacao == '-':
    print(numero1 - numero2)

# Realizando multiplicação    
elif operacao == '*':
    print(numero1 * numero2)

# Realizando divisão
elif operacao == '/':
    print(numero1 / numero2)

# Informando a operação inválida
else: 
    print("Erro: O campo de operações só aceito + , - , * , /")