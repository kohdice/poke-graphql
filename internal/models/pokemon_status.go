package models

import (
	"context"
	"time"

	"github.com/uptrace/bun"
)

type PokemonStatus struct {
	bun.BaseModel `bun:"table:pokemon_status"`

	ID             int       `bun:",pk,autoincrement"`
	PokemonID      int       `bun:",nullzero,notnull"`
	HP             int       `bun:",type:smallint,nullzero,notnull"`
	Attack         int       `bun:",type:smallint,nullzero,notnull"`
	Defense        int       `bun:",type:smallint,nullzero,notnull"`
	SpecialAttack  int       `bun:",type:smallint,nullzero,notnull"`
	SpecialDefense int       `bun:",type:smallint,nullzero,notnull"`
	Speed          int       `bun:",type:smallint,nullzero,notnull"`
	BaseTotal      int       `bun:",type:smallint,nullzero,notnull"`
	CreatedBy      string    `bun:",type:varchar(36),nullzero,notnull"`
	CreatedAt      time.Time `bun:",nullzero,notnull,default:current_timestamp"`
	UpdatedBy      string    `bun:",type:varchar(36),nullzero,notnull"`
	UpdatedAt      time.Time `bun:",nullzero,notnull,default:current_timestamp"`

	// Relationship
	Pokemon *Pokemon `bun:"rel:belongs-to,join:pokemon_id=id"`
}

// Hook that updates UpdatedAt timestamp on each update.
func (m *PokemonStatus) AfterUpdate(ctx context.Context, tx *bun.Tx) error {
	m.UpdatedAt = time.Now()
	_, err := tx.NewUpdate().
		Model(m).
		Set("updated_at = ?", m.UpdatedAt).
		Where("id =?", m.ID).
		Exec(ctx)

	return err
}
