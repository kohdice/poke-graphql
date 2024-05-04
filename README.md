# poke-graphql

[![PkgGoDev](https://pkg.go.dev/badge/github.com/kohdice/poke-graphql)](https://pkg.go.dev/github.com/kohdice/poke-graphql)
[![codecov](https://codecov.io/gh/kohdice/poke-graphql/graph/badge.svg?token=IV7F60OTG7)](https://codecov.io/gh/kohdice/poke-graphql)

The GraphQL API to retrieve Pokémon data.

## 1. Table of Contents

- [1. Table of Contents](#1-table-of-contents)
- [2. About This Repository](#2-about-this-repository)
- [3. Usage](#3-usage)
  - [a. Create a `.env` file](#a-create-a-env-file)
  - [b. Run servers](#b-run-servers)
  - [c. Access GraphQL Playground](#c-access-graphql-playground)

## 2. About This Repository

This is a repository for a GraphQL API that returns Pokémon data,
created with [gqlgen](https://github.com/99designs/gqlgen) and [Bun](https://github.com/uptrace/bun).

## 3. Usage

### a. Create a `.env` file

Create a `.env` file based on `.env.tmp`.  
※ You can use `.env.tmp` by copying it and renaming it to `.env`.

### b. Run servers

```sh
docker compose up --build
```

### c. Access GraphQL Playground

Go to Playground: [http://localhost:8080](http://localhost:8080)
