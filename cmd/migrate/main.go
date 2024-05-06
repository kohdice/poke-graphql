package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"ariga.io/atlas-go-sdk/atlasexec"
)

func main() {
	workdir, err := atlasexec.NewWorkingDir(
		atlasexec.WithMigrations(
			os.DirFS("./migrations"),
		),
	)
	if err != nil {
		log.Fatalf("failed to load working directory: %v", err)
	}

	defer workdir.Close()

	client, err := atlasexec.NewClient(workdir.Path(), "atlas")
	if err != nil {
		log.Fatalf("failed to initialize client: %v", err)
	}

	res, err := client.MigrateApply(context.Background(), &atlasexec.MigrateApplyParams{
		URL: "mysql://root:root@db:3306/main_db?charset=utf8mb4&parseTime=true",
	})
	if err != nil {
		log.Fatalf("failed to apply migrations: %v", err)
	}

	fmt.Printf("Applied %d migrations\n", len(res.Applied))
}
