-- Create "ability_mst" table
CREATE TABLE `ability_mst` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT "ID",
  `ability_name` varchar(12) NOT NULL COMMENT "Ability",
  `created_by` varchar(36) NOT NULL COMMENT "Creator",
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Creation DateTime",
  `updated_by` varchar(36) NOT NULL COMMENT "Updater",
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Update DateTime",
  PRIMARY KEY (`id`)
) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

-- Create "pokemon_mst" table
CREATE TABLE `pokemon_mst` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT "ID",
  `national_pokedex_number` int NOT NULL COMMENT "National Pokédex Number",
  `pokemon_name` varchar(12) NOT NULL COMMENT "Name",
  `is_legendary` bool NOT NULL COMMENT "Legendary or Not",
  `is_mythical` bool NOT NULL COMMENT "Mythical or Not",
  `created_by` varchar(36) NOT NULL COMMENT "Creator",
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Creation DateTime",
  `updated_by` varchar(36) NOT NULL COMMENT "Updater",
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Update DateTime",
  PRIMARY KEY (`id`)
) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

-- Create "pokemon_abilities" table
CREATE TABLE `pokemon_abilities` (
  `pokemon_id` int NOT NULL COMMENT "Pokemon ID",
  `ability_id` int NOT NULL COMMENT "Ability ID",
  `slot` smallint NOT NULL COMMENT "Slot of Ability",
  `is_hidden` bool NOT NULL COMMENT "Hidden Ability or Not",
  `created_by` varchar(36) NOT NULL COMMENT "Creator",
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Creation DateTime",
  `updated_by` varchar(36) NOT NULL COMMENT "Updater",
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Update DateTime",
  PRIMARY KEY (`pokemon_id`, `ability_id`),
  INDEX `pokemon_abilities_FK_1` (`ability_id`),
  CONSTRAINT `pokemon_abilities_FK_1` FOREIGN KEY (`ability_id`) REFERENCES `ability_mst` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT `pokemon_abilities_FK_2` FOREIGN KEY (`pokemon_id`) REFERENCES `pokemon_mst` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

-- Create "pokemon_status" table
CREATE TABLE `pokemon_status` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT "ID",
  `pokemon_id` int NOT NULL COMMENT "Pokemon ID",
  `hp` smallint NOT NULL COMMENT "HP",
  `attack` smallint NOT NULL COMMENT "Attack",
  `defense` smallint NOT NULL COMMENT "Defense",
  `special_attack` smallint NOT NULL COMMENT "Special Attack",
  `special_defense` smallint NOT NULL COMMENT "Special Defense",
  `speed` smallint NOT NULL COMMENT "Speed",
  `base_total` smallint NOT NULL COMMENT "Base Total",
  `created_by` varchar(36) NOT NULL COMMENT "Creator",
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Creation DateTime",
  `updated_by` varchar(36) NOT NULL COMMENT "Updater",
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Update DateTime",
  PRIMARY KEY (`id`),
  INDEX `pokemon_status_FK_1` (`pokemon_id`),
  CONSTRAINT `pokemon_status_FK_1` FOREIGN KEY (`pokemon_id`) REFERENCES `pokemon_mst` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

-- Create "type_mst" table
CREATE TABLE `type_mst` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT "ID",
  `type_name` varchar(12) NOT NULL COMMENT "Type",
  `created_by` varchar(36) NOT NULL COMMENT "Creator",
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Creation DateTime",
  `updated_by` varchar(36) NOT NULL COMMENT "Updater",
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Update DateTime",
  PRIMARY KEY (`id`)
) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

-- Create "pokemon_types" table
CREATE TABLE `pokemon_types` (
  `pokemon_id` int NOT NULL COMMENT "Pokemon ID",
  `type_id` int NOT NULL COMMENT "Type ID",
  `slot` smallint NOT NULL COMMENT "Slot of Type",
  `created_by` varchar(36) NOT NULL COMMENT "Creator",
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Creation DateTime",
  `updated_by` varchar(36) NOT NULL COMMENT "Updater",
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT "Update DateTime",
  PRIMARY KEY (`pokemon_id`, `type_id`),
  INDEX `pokemon_types_FK_1` (`type_id`),
  CONSTRAINT `pokemon_types_FK_1` FOREIGN KEY (`pokemon_id`) REFERENCES `pokemon_mst` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT `pokemon_types_FK_2` FOREIGN KEY (`type_id`) REFERENCES `type_mst` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION
) CHARSET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
