FROM golang:1.21 as base

WORKDIR /app

#COPY go.mod .

COPY . .

RUN go mod download

RUN go build -o main .

FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]