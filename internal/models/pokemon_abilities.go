package models

import (
	"context"
	"time"

	"github.com/uptrace/bun"
)

type PokemonAbilities struct {
	bun.BaseModel `bun:"table:pokemon_abilities"`

	PokemonID int       `bun:",nullzero,notnull"`
	TypeID    int       `bun:",nullzero,notnull"`
	Slot      int       `bun:",type:smallint,nullzero,notnull"`
	IsHidden  bool      `bun:",type:tinyint(1),nullzero,notnull"`
	CreatedBy string    `bun:",type:varchar(36),nullzero,notnull"`
	CreatedAt time.Time `bun:",nullzero,notnull,default:current_timestamp"`
	UpdatedBy string    `bun:",type:varchar(36),nullzero,notnull"`
	UpdatedAt time.Time `bun:",nullzero,notnull,default:current_timestamp"`

	// Relationship
	Pokemon     *Pokemon     `bun:"rel:belongs-to,join:pokemon_id=id"`
	PokemonType *PokemonType `bun:"rel:belongs-to,join:type_id=id"`
}

// Hook that updates UpdatedAt timestamp on each update.
func (m *PokemonAbilities) AfterUpdate(ctx context.Context, tx *bun.Tx) error {
	m.UpdatedAt = time.Now()
	_, err := tx.NewUpdate().
		Model(m).
		Set("updated_at = ?", m.UpdatedAt).
		Where("pokemon_id = ? and type_id = ?", m.PokemonID, m.TypeID).
		Exec(ctx)

	return err
}
