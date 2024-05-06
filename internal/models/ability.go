package models

import (
	"context"
	"time"

	"github.com/uptrace/bun"
)

type PokemonAbility struct {
	bun.BaseModel `bun:"table:ability_mst"`

	ID          int       `bun:",pk,autoincrement"`
	AbilityName string    `bun:",type:varchar(12),nullzero,notnull"`
	CreatedBy   string    `bun:",type:varchar(36),nullzero,notnull"`
	CreatedAt   time.Time `bun:",nullzero,notnull,default:current_timestamp"`
	UpdatedBy   string    `bun:",type:varchar(36),nullzero,notnull"`
	UpdatedAt   time.Time `bun:",nullzero,notnull,default:current_timestamp"`

	// Relationship
	Pokemons []*Pokemon `bun:"m2m:pokemon_types"`
}

// Hook that updates UpdatedAt timestamp on each update.
func (m *PokemonAbility) AfterUpdate(ctx context.Context, tx *bun.Tx) error {
	m.UpdatedAt = time.Now()
	_, err := tx.NewUpdate().
		Model(m).
		Set("updated_at = ?", m.UpdatedAt).
		Where("id = ?", m.ID).
		Exec(ctx)

	return err
}
