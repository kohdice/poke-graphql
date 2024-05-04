package main

import (
	"log"
	"net/http"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"

	"github.com/kohdice/poke-graphql/internal/config"
	"github.com/kohdice/poke-graphql/internal/graphql"
)

func main() {
	cfg, err := config.NewConfig()
	if err != nil {
		log.Fatal(err)
	}

	port := cfg.Port()
	debug := cfg.Debug()

	srv := handler.NewDefaultServer(graphql.NewExecutableSchema(graphql.Config{Resolvers: &graphql.Resolver{}}))

	http.Handle("/graphql", srv)
	if debug {
		http.Handle("/", playground.Handler("GraphQL playground", "/graphql"))
		log.Printf("connect to http://localhost:%s/ for GraphQL playground", port)
	}

	log.Fatal(http.ListenAndServe(":"+port, nil))
}
