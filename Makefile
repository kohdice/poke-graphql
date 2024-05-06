SRC := ./cmd/poke-graphql
BIN := ./bin/server
BUILD_LDFLAGS := "-s -w"

.PHONY: build
build:
	go build -trimpath -ldflags=$(BUILD_LDFLAGS) -o $(BIN) $(SRC)

.PHONY: clean
clean:
	go clean

.PHONY: fmt
fmt:
	goimports -w .
	go fmt ./...

.PHONY: lint
lint:
	go vet ./...

.PHONY: ci-lint
ci-lint:
	golangci-lint run ./...

.PHONY: test
test:
	go test -v -cover ./...

.PHONY: coverage
coverage:
	go test -v -coverprofile=coverage.out -covermode=atomic ./...
	go tool cover -html=coverage.out -o coverage.html

.PHONY: tidy
tidy:
	go mod tidy

.PHONY: migration
migration: tidy
	@echo ""
	@echo "Running migration..."
	atlas schema apply --env dev

.PHONY: wait
wait:
	@echo "Waiting..." && sleep 20

.PHONY: air
air: wait migration
	@echo ""
	@echo "Running air..."
	@air -c .air.toml
