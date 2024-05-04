package main

import (
	"database/sql"
	"log"
	"net/http"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	_ "github.com/go-sql-driver/mysql"
	"github.com/kohdice/poke-graphql/internal/config"
	"github.com/kohdice/poke-graphql/internal/graphql"
	"github.com/uptrace/bun"
	"github.com/uptrace/bun/dialect/mysqldialect"
	"github.com/uptrace/bun/extra/bundebug"
)

func main() {
	cfg, err := config.NewConfig()
	if err != nil {
		log.Fatal(err)
	}

	databaseURL := cfg.DatabaseURL()
	port := cfg.Port()
	debug := cfg.Debug()

	sqldb, err := sql.Open("mysql", databaseURL)
	if err != nil {
		log.Fatal(err)
	}

	db := bun.NewDB(sqldb, mysqldialect.New())
	db.AddQueryHook(bundebug.NewQueryHook(bundebug.WithVerbose(debug)))

	srv := handler.NewDefaultServer(graphql.NewExecutableSchema(graphql.Config{Resolvers: &graphql.Resolver{}}))

	http.Handle("/graphql", srv)
	if debug {
		http.Handle("/", playground.Handler("GraphQL playground", "/graphql"))
		log.Printf("connect to http://localhost:%s/ for GraphQL playground", port)
	}

	log.Fatal(http.ListenAndServe(":"+port, nil))
}
