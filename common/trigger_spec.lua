-- Return a map: technology_name -> { conditions = { ... } }
-- Supported condition types below: "craft-item", "build-entity".
-- Add more if you like (mine-entity, kill-entity, etc).
return {
  ["automation"] = {
      { type = "craft-item", item = "transport-belt", count = 3 },
      { type = "craft-item", item = "electronic-circuit", count = 2 }

  },
  ["toolbelt"] = {

      { type = "craft-item", item = "steel-chest", count = 1 },
      { type = "craft-item", item = "inserter", count = 1 },
      { type = "craft-item", item = "long-handed-inserter", count = 1 },
      { type = "craft-item", item = "fast-inserter", count = 1 },
      { type = "craft-item", item = "coal", count = 1 },
      { type = "craft-item", item = "steel-plate", count = 1 },
      { type = "craft-item", item = "iron-chest", count = 1 },
  },
  -- ["other-tech"] = { conditions = { ... } },
}
