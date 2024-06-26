// Code generated by github.com/99designs/gqlgen, DO NOT EDIT.

package model

type Node interface {
	IsNode()
	GetID() string
}

// Pokémon
type Pokemon struct {
	// The ID of an object.
	ID string `json:"id"`
	// The National Pokédex number of this Pokémon.
	NationalPokedexNumber int `json:"nationalPokedexNumber"`
	// The name of this Pokémon.
	Name string `json:"name"`
}

func (Pokemon) IsNode()            {}
func (this Pokemon) GetID() string { return this.ID }

// Root Query.
type Query struct{}
