table "ability_mst" {
  schema = schema.main_db
  column "id" {
    null           = false
    type           = int
    comment        = "ID"
    auto_increment = true
  }
  column "ability_name" {
    null    = false
    type    = varchar(12)
    comment = "Ability"
  }
  column "created_by" {
    null    = false
    type    = varchar(36)
    comment = "Creator"
  }
  column "created_at" {
    null    = false
    type    = datetime
    default = sql("CURRENT_TIMESTAMP")
    comment = "Creation DateTime"
  }
  column "updated_by" {
    null    = false
    type    = varchar(36)
    comment = "Updater"
  }
  column "updated_at" {
    null    = false
    type    = datetime
    default = sql("CURRENT_TIMESTAMP")
    comment = "Update DateTime"
  }
  primary_key {
    columns = [column.id]
  }
}
table "pokemon_abilities" {
  schema = schema.main_db
  column "pokemon_id" {
    null    = false
    type    = int
    comment = "Pokemon ID"
  }
  column "ability_id" {
    null    = false
    type    = int
    comment = "Ability ID"
  }
  column "slot" {
    null    = false
    type    = smallint
    comment = "Slot of Ability"
  }
  column "is_hidden" {
    null    = false
    type    = bool
    comment = "Hidden Ability or Not"
  }
  column "created_by" {
    null    = false
    type    = varchar(36)
    comment = "Creator"
  }
  column "created_at" {
    null    = false
    type    = datetime
    default = sql("CURRENT_TIMESTAMP")
    comment = "Creation DateTime"
  }
  column "updated_by" {
    null    = false
    type    = varchar(36)
    comment = "Updater"
  }
  column "updated_at" {
    null    = false
    type    = datetime
    default = sql("CURRENT_TIMESTAMP")
    comment = "Update DateTime"
  }
  primary_key {
    columns = [column.pokemon_id, column.ability_id]
  }
  foreign_key "pokemon_abilities_FK_1" {
    columns     = [column.ability_id]
    ref_columns = [table.ability_mst.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "pokemon_abilities_FK_2" {
    columns     = [column.pokemon_id]
    ref_columns = [table.pokemon_mst.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "pokemon_abilities_FK_1" {
    columns = [column.ability_id]
  }
}
table "pokemon_mst" {
  schema = schema.main_db
  column "id" {
    null           = false
    type           = int
    comment        = "ID"
    auto_increment = true
  }
  column "national_pokedex_number" {
    null    = false
    type    = int
    comment = "National Pokédex Number"
  }
  column "pokemon_name" {
    null    = false
    type    = varchar(12)
    comment = "Name"
  }
  column "is_legendary" {
    null    = false
    type    = bool
    comment = "Legendary or Not"
  }
  column "is_mythical" {
    null    = false
    type    = bool
    comment = "Mythical or Not"
  }
  column "created_by" {
    null    = false
    type    = varchar(36)
    comment = "Creator"
  }
  column "created_at" {
    null    = false
    type    = datetime
    default = sql("CURRENT_TIMESTAMP")
    comment = "Creation DateTime"
  }
  column "updated_by" {
    null    = false
    type    = varchar(36)
    comment = "Updater"
  }
  column "updated_at" {
    null    = false
    type    = datetime
    default = sql("CURRENT_TIMESTAMP")
    comment = "Update DateTime"
  }
  primary_key {
    columns = [column.id]
  }
}
table "pokemon_status" {
  schema = schema.main_db
  column "id" {
    null           = false
    type           = int
    comment        = "ID"
    auto_increment = true
  }
  column "pokemon_id" {
    null    = false
    type    = int
    comment = "Pokemon ID"
  }
  column "hp" {
    null    = false
    type    = smallint
    comment = "HP"
  }
  column "attack" {
    null    = false
    type    = smallint
    comment = "Attack"
  }
  column "defense" {
    null    = false
    type    = smallint
    comment = "Defense"
  }
  column "special_attack" {
    null    = false
    type    = smallint
    comment = "Special Attack"
  }
  column "special_defense" {
    null    = false
    type    = smallint
    comment = "Special Defense"
  }
  column "speed" {
    null    = false
    type    = smallint
    comment = "Speed"
  }
  column "base_total" {
    null    = false
    type    = smallint
    comment = "Base Total"
  }
  column "created_by" {
    null    = false
    type    = varchar(36)
    comment = "Creator"
  }
  column "created_at" {
    null    = false
    type    = datetime
    default = sql("CURRENT_TIMESTAMP")
    comment = "Creation DateTime"
  }
  column "updated_by" {
    null    = false
    type    = varchar(36)
    comment = "Updater"
  }
  column "updated_at" {
    null    = false
    type    = datetime
    default = sql("CURRENT_TIMESTAMP")
    comment = "Update DateTime"
  }
  primary_key {
    columns = [column.id]
  }
  foreign_key "pokemon_status_FK_1" {
    columns     = [column.pokemon_id]
    ref_columns = [table.pokemon_mst.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "pokemon_status_FK_1" {
    columns = [column.pokemon_id]
  }
}
table "pokemon_types" {
  schema = schema.main_db
  column "pokemon_id" {
    null    = false
    type    = int
    comment = "Pokemon ID"
  }
  column "type_id" {
    null    = false
    type    = int
    comment = "Type ID"
  }
  column "slot" {
    null    = false
    type    = smallint
    comment = "Slot of Type"
  }
  column "created_by" {
    null    = false
    type    = varchar(36)
    comment = "Creator"
  }
  column "created_at" {
    null    = false
    type    = datetime
    default = sql("CURRENT_TIMESTAMP")
    comment = "Creation DateTime"
  }
  column "updated_by" {
    null    = false
    type    = varchar(36)
    comment = "Updater"
  }
  column "updated_at" {
    null    = false
    type    = datetime
    default = sql("CURRENT_TIMESTAMP")
    comment = "Update DateTime"
  }
  primary_key {
    columns = [column.pokemon_id, column.type_id]
  }
  foreign_key "pokemon_types_FK_1" {
    columns     = [column.pokemon_id]
    ref_columns = [table.pokemon_mst.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "pokemon_types_FK_2" {
    columns     = [column.type_id]
    ref_columns = [table.type_mst.column.id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "pokemon_types_FK_1" {
    columns = [column.type_id]
  }
}
table "type_mst" {
  schema = schema.main_db
  column "id" {
    null           = false
    type           = int
    comment        = "ID"
    auto_increment = true
  }
  column "type_name" {
    null    = false
    type    = varchar(12)
    comment = "Type"
  }
  column "created_by" {
    null    = false
    type    = varchar(36)
    comment = "Creator"
  }
  column "created_at" {
    null    = false
    type    = datetime
    default = sql("CURRENT_TIMESTAMP")
    comment = "Creation DateTime"
  }
  column "updated_by" {
    null    = false
    type    = varchar(36)
    comment = "Updater"
  }
  column "updated_at" {
    null    = false
    type    = datetime
    default = sql("CURRENT_TIMESTAMP")
    comment = "Update DateTime"
  }
  primary_key {
    columns = [column.id]
  }
}
schema "main_db" {
  charset = "utf8mb4"
  collate = "utf8mb4_0900_ai_ci"
}
