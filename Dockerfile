# Etapa de build (utilizando imagem oficial do Go para compilação)
FROM golang:1.18 AS builder

# Definindo o diretório de trabalho
WORKDIR /app

# Copiando os arquivos do projeto para dentro da imagem
COPY . .

# Inicializando o módulo Go
RUN go mod init fullcycle

# Compilando o código Go
RUN go build -o fullcycle .

# Etapa final (utilizando imagem mínima para execução)
FROM scratch

# Copiando o binário compilado da etapa anterior
COPY --from=builder /app/fullcycle /fullcycle

# Definindo o comando que será executado ao rodar o container
ENTRYPOINT ["/fullcycle"]

