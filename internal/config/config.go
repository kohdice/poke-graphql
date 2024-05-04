package config

import (
	"fmt"
	"os"
)

type Configurer interface {
	DatabaseURL() string
	Port() string
	Debug() bool
}

type config struct {
	databaseURL string
	port        string
	debug       bool
}

func (c *config) DatabaseURL() string {
	return c.databaseURL
}

func (c *config) Port() string {
	return c.port
}

func (c *config) Debug() bool {
	return c.debug
}

func NewConfig() (Configurer, error) {
	databaseURL, ok := os.LookupEnv("DATABASE_URL")
	if !ok {
		return nil, fmt.Errorf("DATABASE_URL is not set")
	}

	port, ok := os.LookupEnv("PORT")
	if !ok {
		return nil, fmt.Errorf("PORT is not set")
	}

	debugStr := os.Getenv("DEBUG")
	debug := debugStr == "true"

	return &config{
		databaseURL: databaseURL,
		port:        port,
		debug:       debug,
	}, nil
}
