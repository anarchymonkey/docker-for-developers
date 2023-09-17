FROM golang

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -o url-shortner.exe

EXPOSE 8080

CMD ["./url-shortner.exe"]