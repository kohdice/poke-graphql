package models

import (
	"context"
	"time"

	"github.com/uptrace/bun"
)

type Pokemon struct {
	bun.BaseModel `bun:"table:pokemon_mst"`

	ID                    int       `bun:",pk,autoincrement"`
	NationalPokedexNumber int       `bun:",nullzero,notnull"`
	PokemonName           string    `bun:",type:varchar(12),nullzero,notnull"`
	IsLegendary           bool      `bun:",type:tinyint(1),nullzero,notnull"`
	IsMythical            bool      `bun:",type:tinyint(1),nullzero,notnull"`
	CreatedBy             string    `bun:",type:varchar(36),nullzero,notnull"`
	CreatedAt             time.Time `bun:",nullzero,notnull,default:current_timestamp"`
	UpdatedBy             string    `bun:",type:varchar(36),nullzero,notnull"`
	UpdatedAt             time.Time `bun:",nullzero,notnull,default:current_timestamp"`

	// Relationship
	Status    *PokemonStatus    `bun:"rel:has-one"`
	Abilities []*PokemonAbility `bun:"m2m:pokemon_abilities"`
	Types     []*PokemonType    `bun:"m2m:pokemon_types"`
}

// Hook that updates UpdatedAt timestamp on each update.
func (m *Pokemon) AfterUpdate(ctx context.Context, tx *bun.Tx) error {
	m.UpdatedAt = time.Now()
	_, err := tx.NewUpdate().
		Model(m).
		Set("updated_at = ?", m.UpdatedAt).
		Where("id = ?", m.ID).
		Exec(ctx)

	return err
}
