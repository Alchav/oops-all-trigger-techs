
local Spec = require("common.trigger_spec")

local function localized_condition(cond)
  if cond.type == "craft-item" then
    return {"", {"", cond.count}, " × ", {"item-name."..cond.item}}
  elseif cond.type == "craft-fluid" then
    return {"", {"", cond.count}, " × ", {"fluid-name."..cond.item}}
  elseif cond.type == "build-entity" then
    return {"", {"", cond.count}, " × ", {"entity-name."..cond.entity}}
  else
    return {"", cond.type} -- fallback
  end
end

local function join_with_commas_and_and(parts)
  if #parts == 0 then return {""} end
  if #parts == 1 then return parts[1] end
  local acc = {"", parts[1]}
  for i = 2, #parts do
    if i < #parts then
      acc = {"", acc, {", "}, parts[i]}
    else
      acc = {"", acc, {" and "}, parts[i]}
    end
  end
  return acc
end

local function cond_text(c)
  if c.type == "craft-item" and c.item then
    return tostring(c.count or 1) .. " [item=" .. c.item .. "]"
  elseif c.type == "craft-fluid" and c.fluid then
    return tostring(c.count or 1) .. " [fluid=" .. c.fluid .. "]"
  else
    return tostring(c.count or 1) .. " × " .. (c.item or c.entity or c.type or "?")
  end
end

local function make_trigger_description(conditions)
  local parts = {}
  for _, c in ipairs(conditions) do
    table.insert(parts, cond_text(c))
  end
  return "Craft " .. table.concat(parts, ", ")
end

local function icon_for_item(name)
  local proto = (data.raw.item and data.raw.item[name])
            or (data.raw.tool and data.raw.tool[name])
            or (data.raw.armor and data.raw.armor[name])
            or (data.raw.module and data.raw.module[name])
            or (data.raw.rail_planner and data.raw.rail_planner[name])
            or (data.raw.item_with_entity_data and data.raw.item_with_entity_data[name])
            or (data.raw.capsule and data.raw.capsule[name])
  if not proto then return nil end
  if proto.icons then
    return table.deepcopy(proto.icons), 64
  elseif proto.icon then
    return {{icon = proto.icon, icon_size = proto.icon_size or 64}}, 64
  end
  return nil
end

local function icon_for_entity(name)
  local e = nil
  for type_name, t in pairs(data.raw) do
    if type_name ~= "item" and type_name ~= "recipe" and type_name ~= "technology" then
      if t[name] then e = t[name]; break end
    end
  end
  if e then
    if e.icons then
      return table.deepcopy(e.icons), e.icon_size or 64
    elseif e.icon then
      return {{icon = e.icon, icon_size = e.icon_size or 64}}, e.icon_size or 64
    end
  end
  for _, item in pairs(data.raw.item or {}) do
    if item.place_result == name then
      return icon_for_item(item.name)
    end
  end
  return nil
end

local function collect_icons(conditions)
  spacing = math.floor(112 / #conditions)
  log("COLLECTING ICONS")
  log(#conditions)
  log(spacing)
  if spacing > 32 then
      spacing = 32
  end
  local icons, icon_size, i = {}, 64, 0
  for _, c in ipairs(conditions) do
    local ic_tbl, sz
    if c.type == "craft-item" then
      ic_tbl, sz = icon_for_item(c.item)
    elseif c.type == "craft-fluid" then
      ic_tbl, sz = icon_for_entity(c.fluid)
    end
    if ic_tbl then
      icon_size = sz or icon_size
      for _, ic in ipairs(ic_tbl) do
        local copy = table.deepcopy(ic)
        copy.scale = 0.5
        copy.floating = true
        copy.shift = {spacing * i, 0}
        icons[#icons+1] = copy
      end
      i = i + 1
    end
  end
  return (#icons > 0) and icons or nil, icon_size
end

for tech_name, def in pairs(Spec) do
    local tech = data.raw.technology[tech_name]
    local icons, icon_size = collect_icons(def)
    tech.research_trigger = {
      type = "scripted",
      trigger_description = make_trigger_description(def),
      icons = icons,
      icon_size = icon_size,
    }
end

data.raw.technology["electronics"].effects = {
      {
        type = "unlock-recipe",
        recipe = "copper-cable"
      },
      {
        type = "unlock-recipe",
        recipe = "electronic-circuit"
      },
      {
        type = "unlock-recipe",
        recipe = "inserter"
      },
      {
        type = "unlock-recipe",
        recipe = "small-electric-pole"
      }
}
data.raw.technology["automation-science-pack"] = nil
data.raw.technology["logistic-science-pack"] = nil
data.raw.technology["military-science-pack"] = nil
data.raw.technology["chemical-science-pack"] = nil
data.raw.technology["production-science-pack"] = nil
data.raw.technology["utility-science-pack"] = nil

data.raw.technology["automation"].prerequisites = {"steam-power", "electronics"}
data.raw.technology["automation"].research_trigger = {type = "craft-item", item = "electronic-circuit", count = 30}

data.raw.technology["electric-mining-drill"].prerequisites = {"steam-power", "electronics"}
data.raw.technology["electric-mining-drill"].research_trigger = {type = "craft-item", item = "small-electric-pole", count = 20}
data.raw.technology["logistics"].prerequisites = {"steam-power", "electronics"}
data.raw.technology["logistics"].research_trigger = {type = "craft-item", item = "transport-belt", count = 25}
data.raw.technology["repair-pack"].prerequisites = {"steam-power", "electronics"}
data.raw.technology["repair-pack"].research_trigger = {type = "craft-item", item = "electronic-circuit", count = 125}
data.raw.technology["fast-inserter"].prerequisites = {"steam-power", "electronics"}
data.raw.technology["fast-inserter"].research_trigger = {type = "craft-item", item = "inserter", count = 100}
data.raw.technology["gun-turret"].prerequisites = {"steam-power", "electronics"}
data.raw.technology["gun-turret"].research_trigger = {type = "craft-item", item = "firearm-magazine", count = 25}
data.raw.technology["lamp"].prerequisites = {"steam-power", "electronics"}
data.raw.technology["lamp"].research_trigger = {type = "craft-item", item = "copper-cable", count = 200}
data.raw.technology["military"].prerequisites = nil
data.raw.technology["military"].research_trigger = {type = "craft-item", item = "light-armor", count = 1}
data.raw.technology["stone-wall"].prerequisites = nil
data.raw.technology["stone-wall"].research_trigger = {type = "craft-item", item = "stone-brick", count = 25}
data.raw.technology["gate"].prerequisites = {"stone-wall", "steel-processing", "electronics"}
data.raw.technology["gate"].research_trigger = {type = "craft-item", item = "stone-wall", count = 50}
data.raw.technology["steel-processing"].prerequisites = {"steam-power"}
data.raw.technology["steel-processing"].research_trigger = {type = "craft-item", item = "iron-plate", count = 15000}
data.raw.technology["heavy-armor"].research_trigger = {type = "craft-item", item = "firearm-magazine", count = 500}
data.raw.technology["physical-projectile-damage-1"].research_trigger = {type = "craft-item", item = "shotgun", count = 1}
data.raw.technology["radar"].prerequisites = {"steam-power", "electronics"}
data.raw.technology["radar"].research_trigger = {type = "craft-item", item = "iron-gear-wheel", count = 2000}

data.raw.technology["weapon-shooting-speed-1"].research_trigger = {type = "craft-item", item = "submachine-gun", count = 1}
data.raw.technology["weapon-shooting-speed-2"].prerequisites = {"weapon-shooting-speed-1"}
data.raw.technology["weapon-shooting-speed-2"].research_trigger = {type = "craft-item", item = "firearm-magazine", count = 250}
data.raw.technology["weapon-shooting-speed-3"].prerequisites = { "military-2"}
data.raw.technology["weapon-shooting-speed-3"].research_trigger = {type = "craft-item", item = "piercing-rounds-magazine", count = 250}
data.raw.technology["weapon-shooting-speed-4"].prerequisites = {"tank"}
data.raw.technology["weapon-shooting-speed-4"].research_trigger = {type = "craft-item", item = "cannon-shell", count = 150}
data.raw.technology["weapon-shooting-speed-5"].prerequisites = {"rocketry"}
data.raw.technology["weapon-shooting-speed-5"].research_trigger = {type = "craft-item", item = "rocket", count = 150}
data.raw.technology["weapon-shooting-speed-6"].prerequisites = {"explosive-rocketry"}
data.raw.technology["weapon-shooting-speed-6"].research_trigger = {type = "craft-item", item = "explosive-rocket", count = 150}

data.raw.technology["physical-projectile-damage-2"].prerequisites = {"physical-projectile-damage-1"}
data.raw.technology["physical-projectile-damage-2"].research_trigger = {type = "craft-item", item = "shotgun-shell", count = 25}
data.raw.technology["physical-projectile-damage-3"].prerequisites = {"physical-projectile-damage-2", "military-2"}
data.raw.technology["physical-projectile-damage-3"].research_trigger = {type = "craft-item", item = "shotgun-shell", count = 100}
data.raw.technology["physical-projectile-damage-4"].prerequisites = {"defender"}
data.raw.technology["physical-projectile-damage-4"].research_trigger = {type = "craft-item", item = "defender-capsule", count = 100}
data.raw.technology["physical-projectile-damage-5"].prerequisites = {"tank"}
data.raw.technology["physical-projectile-damage-5"].research_trigger = {type = "craft-item", item = "explosive-cannon-shell", count = 150}
data.raw.technology["physical-projectile-damage-6"].prerequisites = {"military-4"}
data.raw.technology["physical-projectile-damage-6"].research_trigger = {type = "craft-item", item = "piercing-shotgun-shell", count = 250}

data.raw.technology["advanced-material-processing"].prerequisites = {"steel-axe", "stone-wall"}
data.raw.technology["automation-2"].prerequisites = {"steel-processing", "automation", "electronics"}
data.raw.technology["automation-2"].research_trigger = {type = "craft-item", item = "assembling-machine-1", count = 200}
data.raw.technology["circuit-network"].prerequisites = {"automation"}
data.raw.technology["circuit-network"].research_trigger = {type = "craft-item", item = "electronic-circuit", count = 1000}
data.raw.technology["engine"].prerequisites = {"steel-processing", "automation"}
data.raw.technology["engine"].research_trigger = {type = "craft-item", item = "pipe", count = 200}
data.raw.technology["electric-energy-distribution-1"].prerequisites = {"steel-processing", "electric-mining-drill"}
data.raw.technology["electric-energy-distribution-1"].research_trigger = {type = "craft-item", item = "small-electric-pole", count = 125}
data.raw.technology["landfill"].prerequisites = {"automation"}
data.raw.technology["landfill"].research_trigger = {type = "craft-item", item = "stone", count = 250}
data.raw.technology["logistics-2"].prerequisites = {"logistics"}
data.raw.technology["toolbelt"].prerequisites = {"logistics", "landfill", "stone-wall", "steel-processing", "repair-pack", "fast-inserter", "lamp", "radar"}
data.raw.technology["bulk-inserter"].prerequisites = {"fast-inserter", "advanced-circuit"}
data.raw.technology["military-2"].prerequisites = {"military", "steel-processing"}
data.raw.technology["military-2"].research_trigger = {type = "craft-item", item = "gun-turret", count = 15}
data.raw.technology["solar-energy"].prerequisites = {"steel-processing", "electronics", "steam-power"}
data.raw.technology["solar-energy"].research_trigger = {type = "craft-fluid", fluid = "steam", amount = 500000}
data.raw.technology["fluid-handling"].research_trigger = {type = "craft-item", item = "assembling-machine-2", count = 100}
data.raw.technology["oil-gathering"].research_trigger = {type = "craft-item", item = "pipe-to-ground", count = 20}
data.raw.technology["railway"].research_trigger = {type = "craft-item", item = "stone", count = 1500}
data.raw.technology["automobilism"].research_trigger = {type = "craft-item", item = "engine-unit", count = 8}
data.raw.technology["flammables"].research_trigger = {type = "craft-fluid", fluid = "crude-oil", amount = 1000}
data.raw.technology["flamethrower"].prerequisites = {"flammables"}
data.raw.technology["flamethrower"].research_trigger = {type = "craft-fluid", fluid = "crude-oil", amount = 10000}
data.raw.technology["plastics"].research_trigger = {type = "craft-fluid", fluid = "petroleum-gas", amount = 500}
data.raw.technology["advanced-circuit"].research_trigger = {type = "craft-item", item = "plastic-bar", count = 500}
data.raw.technology["modules"].research_trigger = {type = "craft-item", item = "advanced-circuit", count = 50}
data.raw.technology["solar-panel-equipment"].research_trigger = {type = "craft-item", item = "solar-panel", count = 5}
data.raw.technology["sulfur-processing"].research_trigger = {type = "craft-item", item = "chemical-plant", count = 5}
data.raw.technology["explosives"].research_trigger = {type = "craft-item", item = "sulfur", count = 100}
data.raw.technology["land-mine"].prerequisites = {"explosives"}
data.raw.technology["battery"].research_trigger = {type = "craft-fluid", fluid = "sulfuric-acid", amount = 25000}
data.raw.technology["battery-equipment"].research_trigger = {type = "craft-item", item = "battery", count = 100}
data.raw.technology["rocketry"].prerequisites = {"explosives", "flammables", "military-2"}
data.raw.technology["inserter-capacity-bonus-2"].prerequisites = {"electronics"}
data.raw.technology["inserter-capacity-bonus-2"].research_trigger = {type = "craft-item", item = "inserter", count = 500}
data.raw.technology["inserter-capacity-bonus-7"].prerequisites = {"automation"}
data.raw.technology["inserter-capacity-bonus-7"].research_trigger = {type = "craft-item", item = "long-handed-inserter", count = 500}
data.raw.technology["inserter-capacity-bonus-1"].prerequisites = {"bulk-inserter"}
data.raw.technology["inserter-capacity-bonus-1"].research_trigger = {type = "craft-item", item = "fast-inserter", count = 1000}
data.raw.technology["inserter-capacity-bonus-3"].research_trigger = {type = "craft-item", item = "bulk-inserter", count = 500}
data.raw.technology["inserter-capacity-bonus-3"].prerequisites = {"bulk-inserter"}
data.raw.technology["inserter-capacity-bonus-4"].prerequisites = {"bulk-inserter", "quality-module"}
data.raw.technology["inserter-capacity-bonus-4"].research_trigger = {type = "craft-item", item = {name = "long-handed-inserter", quality = "uncommon", comparator = ">="}, count = 1}
data.raw.technology["inserter-capacity-bonus-5"].prerequisites = {"bulk-inserter", "quality-module"}
data.raw.technology["inserter-capacity-bonus-5"].research_trigger = {type = "craft-item", item = {name = "fast-inserter", quality = "rare", comparator = ">="}, count = 1}
data.raw.technology["inserter-capacity-bonus-6"].prerequisites = {"bulk-inserter", "quality-module", "epic-quality"}
data.raw.technology["inserter-capacity-bonus-6"].research_trigger = {type = "craft-item", item = {name = "bulk-inserter", quality = "epic", comparator = ">="}, count = 1}
data.raw.technology["concrete"].research_trigger = {type = "craft-item", item = "stone-brick", count = 2000}
data.raw.technology["stronger-explosives-1"].research_trigger = {type = "craft-item", item = "grenade", count = 200}
data.raw.technology["stronger-explosives-2"].prerequisites = {"land-mine"}
data.raw.technology["stronger-explosives-2"].research_trigger = {type = "craft-item", item = "land-mine", count = 200}
data.raw.technology["stronger-explosives-3"].prerequisites = {"rocketry"}
data.raw.technology["stronger-explosives-3"].research_trigger = {type = "craft-item", item = "rocket", count = 200}
data.raw.technology["stronger-explosives-4"].prerequisites = {"military-4"}
data.raw.technology["stronger-explosives-4"].research_trigger = {type = "craft-item", item = "cluster-grenade", count = 200}
data.raw.technology["stronger-explosives-5"].prerequisites = {"explosive-rocketry"}
data.raw.technology["stronger-explosives-5"].research_trigger = {type = "craft-item", item = "explosive-rocket", count = 200}
data.raw.technology["stronger-explosives-6"].prerequisites = {"atomic-bomb"}
data.raw.technology["stronger-explosives-6"].research_trigger = {type = "craft-item", item = "atomic-bomb", count = 5}

data.raw.technology["belt-immunity-equipment"].research_trigger = {type = "craft-item", item = "transport-belt", count = 2500}
data.raw.technology["night-vision-equipment"].research_trigger = {type = "craft-item", item = "small-lamp", count = 150}
data.raw.technology["mining-productivity-1"].research_trigger = {type = "craft-item", item = "electric-mining-drill", count = 250}
data.raw.technology["mining-productivity-2"].prerequisites = {"mining-productivity-1", "sulfur-processing"}
data.raw.technology["mining-productivity-2"].research_trigger = {type = "craft-item", item = "electric-mining-drill", count = 500}
data.raw.technology["mining-productivity-3"].prerequisites = {"mining-productivity-2", "robotics", "processing-unit", "low-density-structure", "advanced-material-processing-2", "productivity-module", "railway"}
data.raw.technology["mining-productivity-3"].research_trigger = {type = "craft-item", item = "electric-mining-drill", count = 1000}

data.raw.technology["defender"].prerequisites = {"military-2"}
data.raw.technology["defender"].research_trigger = {type = "craft-item", item = "piercing-rounds-magazine", count = 200}
data.raw.technology["follower-robot-count-1"].research_trigger = {type = "craft-item", item = "defender-capsule", count = 50}
data.raw.technology["distractor"].research_trigger = {type = "craft-item", item = "defender-capsule", count = 100}
data.raw.technology["follower-robot-count-2"].prerequisites = {"distractor"}
data.raw.technology["follower-robot-count-2"].research_trigger = {type = "craft-item", item = "distractor-capsule", count = 50}
data.raw.technology["destroyer"].research_trigger = {type = "craft-item", item = "distractor-capsule", count = 100}
data.raw.technology["follower-robot-count-3"].prerequisites = {"follower-robot-count-2"}
data.raw.technology["follower-robot-count-3"].research_trigger = {type = "craft-item", item = "distractor-capsule", count = 100}
data.raw.technology["follower-robot-count-4"].prerequisites = {"destroyer"}
data.raw.technology["follower-robot-count-4"].research_trigger = {type = "craft-item", item = "destroyer-capsule", count = 75}

data.raw.technology["refined-flammables-1"].research_trigger = {type = "craft-item", item = "flamethrower-ammo", count = 50}
data.raw.technology["refined-flammables-2"].prerequisites = {"refined-flammables-1"}
data.raw.technology["refined-flammables-2"].research_trigger = {type = "craft-item", item = "flamethrower-ammo", count = 150}
data.raw.technology["refined-flammables-3"].prerequisites = {"flamethrower", "quality-module"}
data.raw.technology["refined-flammables-3"].research_trigger = {type = "craft-item", item = {name = "flamethrower-ammo", quality = "uncommon", comparator = "="}, count = 1}
data.raw.technology["refined-flammables-4"].prerequisites = {"flamethrower", "quality-module"}
data.raw.technology["refined-flammables-4"].research_trigger = {type = "craft-item", item = {name = "flamethrower-ammo", quality = "rare", comparator = "="}, count = 1}
data.raw.technology["refined-flammables-5"].prerequisites = {"flamethrower", "epic-quality"}
data.raw.technology["refined-flammables-5"].research_trigger = {type = "craft-item", item = {name = "flamethrower-ammo", quality = "epic", comparator = "="}, count = 1}
data.raw.technology["refined-flammables-6"].prerequisites = {"flamethrower", "legendary-quality"}
data.raw.technology["refined-flammables-6"].research_trigger = {type = "craft-item", item = {name = "flamethrower-ammo", quality = "legendary", comparator = "="}, count = 1}


data.raw.technology["advanced-combinators"].prerequisites = {"advanced-circuit", "circuit-network"}

data.raw.technology["advanced-material-processing-2"].prerequisites = {"advanced-circuit", "advanced-material-processing"}

data.raw.technology["advanced-oil-processing"].prerequisites = {"advanced-circuit", "sulfur-processing"}

data.raw.technology["coal-liquefaction"].prerequisites = {"lubricant", "advanced-material-processing-2", "productivity-module"}
data.raw.technology["coal-liquefaction"].research_trigger = {type = "craft-fluid", fluid = "heavy-oil", amount = 50000}

data.raw.technology["lubricant"].prerequisites = {"advanced-oil-processing"}
data.raw.technology["lubricant"].research_trigger = {type = "craft-fluid", fluid = "heavy-oil", amount = 25000}


data.raw.technology["laser"].prerequisites = {"advanced-circuit", "sulfur-processing", "battery"}
data.raw.technology["processing-unit"].prerequisites = {"advanced-circuit", "sulfur-processing"}
data.raw.technology["military-3"].prerequisites = {"advanced-circuit", "sulfur-processing", "military-2"}
data.raw.technology["military-3"].research_trigger = {type = "craft-item", item = "piercing-rounds-magazine", count = 1000}
data.raw.technology["uranium-mining"].prerequisites = {"concrete", "advanced-circuit", "sulfur-processing"}
data.raw.technology["uranium-mining"].research_trigger = {type = "craft-item", item = "hazard-concrete", amount = 10}
data.raw.technology["braking-force-1"].research_trigger = {type = "craft-item", item = "rail", count = 500}
data.raw.technology["braking-force-1"].prerequisites = {"railway"}
data.raw.technology["braking-force-2"].prerequisites = {"railway"}
data.raw.technology["braking-force-2"].research_trigger = {type = "craft-item", item = "locomotive", count = 10}
data.raw.technology["braking-force-3"].prerequisites = {"railway"}
data.raw.technology["braking-force-3"].research_trigger = {type = "craft-item", item = "cargo-wagon", count = 20}
data.raw.technology["braking-force-4"].prerequisites = {"railway"}
data.raw.technology["braking-force-4"].research_trigger = {type = "craft-item", item = "train-stop", count = 10}
data.raw.technology["braking-force-5"].prerequisites = {"automated-rail-transportation"}
data.raw.technology["braking-force-5"].research_trigger = {type = "craft-item", item = "rail-signal", count = 50}
data.raw.technology["braking-force-6"].prerequisites = {"automated-rail-transportation"}
data.raw.technology["braking-force-6"].research_trigger = {type = "craft-item", item = "rail-chain-signal", count = 25}
data.raw.technology["braking-force-7"].prerequisites = {"fluid-wagon"}
data.raw.technology["braking-force-7"].research_trigger = {type = "craft-item", item = "fluid-wagon", count = 15}
data.raw.technology["uranium-ammo"].research_trigger = {type = "craft-item", item = "uranium-238", count = 1000}
data.raw.technology["kovarex-enrichment-process"].prerequisites = {"nuclear-power"}
data.raw.technology["kovarex-enrichment-process"].research_trigger = {type = "craft-item", item = "uranium-fuel-cell", count = 15}
data.raw.technology["nuclear-power"].research_trigger = {type = "craft-item", item = "uranium-235", count = 1}
data.raw.technology["nuclear-fuel-reprocessing"].prerequisites = {"nuclear-power", "productivity-module"}
data.raw.technology["nuclear-fuel-reprocessing"].research_trigger = {type = "craft-item", item = "depleted-uranium-fuel-cell", count = 150}
data.raw.technology["productivity-module-2"].research_trigger = {type = "craft-item", item = "productivity-module", count = 50}
data.raw.technology["speed-module-2"].research_trigger = {type = "craft-item", item = "speed-module", count = 50}
data.raw.technology["efficiency-module-2"].research_trigger = {type = "craft-item", item = "efficiency-module", count = 50}
data.raw.technology["quality-module-2"].research_trigger = {type = "craft-item", item = "quality-module", count = 50}

data.raw.technology["productivity-module-3"].prerequisites = {"productivity-module-2", "advanced-material-processing-2"}
data.raw.technology["speed-module-3"].prerequisites = {"speed-module-2", "advanced-material-processing-2"}
data.raw.technology["efficiency-module-3"].prerequisites = {"efficiency-module-2", "advanced-material-processing-2"}
data.raw.technology["quality-module-3"].prerequisites = {"quality-module-2", "advanced-material-processing-2"}
data.raw.technology["productivity-module-3"].research_trigger = {type = "craft-item", item = "productivity-module-2", count = 50}
data.raw.technology["speed-module-3"].research_trigger = {type = "craft-item", item = "speed-module-2", count = 50}
data.raw.technology["efficiency-module-3"].research_trigger = {type = "craft-item", item = "efficiency-module-2", count = 50}
data.raw.technology["quality-module-3"].research_trigger = {type = "craft-item", item = "quality-module-2", count = 50}


data.raw.technology["electric-energy-distribution-2"].prerequisites = {"electric-energy-distribution-1", "advanced-circuit"}
data.raw.technology["artillery"].research_trigger = {type = "craft-item", item = "radar", count = 100}


data.raw.technology["automation-3"].prerequisites = {"electric-engine", "advanced-material-processing-2", "productivity-module", "speed-module"}
data.raw.technology["automation-3"].research_trigger = {type = "craft-item", item = "assembling-machine-2", count = 150}

data.raw.technology["energy-shield-equipment"].prerequisites = {"solar-panel-equipment", "military-2"}
data.raw.technology["energy-shield-equipment"].research_trigger = {type = "craft-item", item = "solar-panel-equipment", count = 2}
data.raw.technology["energy-shield-mk2-equipment"].prerequisites = {"energy-shield-equipment", "military-3", "power-armor", "low-density-structure", "quality-module"}
data.raw.technology["energy-shield-mk2-equipment"].research_trigger = {type = "craft-item", item = {name = "energy-shield-equipment", quality = "uncommon", comparator = ">="}, count = 2}

data.raw.technology["logistic-robotics"].prerequisites = {"logistics-2", "robotics"}

data.raw.technology["logistic-system"].prerequisites = {"logistic-robotics", "low-density-structure", "processing-unit"}
data.raw.technology["logistic-system"].research_trigger = {type = "craft-item", item = "logistic-robot", count = 100}
data.raw.technology["worker-robots-speed-1"].prerequisites = {"robotics"}
data.raw.technology["worker-robots-speed-1"].research_trigger = {type = "craft-item", item = "logistic-robot", count = 150}
data.raw.technology["worker-robots-storage-1"].prerequisites = {"robotics"}
data.raw.technology["worker-robots-storage-1"].research_trigger = {type = "craft-item", item = "construction-robot", count = 150}
data.raw.technology["worker-robots-speed-2"].prerequisites = {"robotics", "quality-module"}
data.raw.technology["worker-robots-speed-2"].research_trigger = {type = "craft-item", item = {name ="construction-robot", quality = "rare", comparator = ">="}, count = 5}
data.raw.technology["worker-robots-storage-2"].prerequisites = {"robotics", "advanced-material-processing-2", "processing-unit", "quality-module"}
data.raw.technology["worker-robots-storage-2"].research_trigger = {type = "craft-item", item = {name ="logistic-robot", quality = "rare", comparator = ">="}, count = 5}
data.raw.technology["worker-robots-speed-3"].prerequisites = {"robotics", "processing-unit", "epic-quality"}
data.raw.technology["worker-robots-speed-3"].research_trigger = {type = "craft-item", item = {name ="logistic-robot", quality = "epic", comparator = ">="}, count = 10}
data.raw.technology["worker-robots-storage-3"].prerequisites = {"robotics", "processing-unit", "productivity-module", "epic-quality"}
data.raw.technology["worker-robots-storage-3"].research_trigger = {type = "craft-item", item = {name ="construction-robot", quality = "epic", comparator = ">="}, count = 10}
data.raw.technology["worker-robots-speed-4"].prerequisites = {"robotics", "low-density-structure", "legendary-quality"}
data.raw.technology["worker-robots-speed-4"].research_trigger = {type = "craft-item", item = {name ="construction-robot", quality = "legendary", comparator = ">="}, count = 15}
data.raw.technology["worker-robots-speed-5"].prerequisites = {"robotics", "advanced-material-processing-2", "productivity-module", "legendary-quality"}
data.raw.technology["worker-robots-speed-6"].prerequisites = {"robotics", "space-science-pack"}
data.raw.technology["worker-robots-speed-5"].research_trigger = {type = "craft-item", item = {name ="logistic-robot", quality = "legendary", comparator = ">="}, count = 15}

data.raw.technology["low-density-structure"].prerequisites = {"plastics", "advanced-material-processing"}

data.raw.technology["personal-roboport-equipment"].prerequisites = {"construction-robotics", "logistic-robotics"}
data.raw.technology["personal-roboport-mk2-equipment"].prerequisites = {"processing-unit", "personal-roboport-equipment", "solar-panel-equipment", "low-density-structure", "quality-module"}
data.raw.technology["personal-roboport-mk2-equipment"].research_trigger = {type = "craft-item", item = {name = "personal-roboport-equipment", quality = "uncommon", comparator = ">="}, count = 1}
data.raw.technology["spidertron"].research_trigger = {type = "craft-item", item = "efficiency-module-3", count = 5}
data.raw.technology["rocket-silo"].prerequisites = {"automation-3", "logistics-3", "concrete", "rocket-fuel", "electric-energy-accumulators", "solar-energy", "processing-unit", "low-density-structure", "speed-module-3", "productivity-module-3", "radar"}

data.raw.technology["epic-quality"].prerequisites = {"quality-module-2"}
data.raw.technology["epic-quality"].research_trigger = {type = "craft-item", item = {name = "quality-module-2", quality = "rare", comparator = "="}, count = 1}
data.raw.technology["legendary-quality"].prerequisites = {"quality-module-3", "epic-quality"}
data.raw.technology["legendary-quality"].research_trigger = {type = "craft-item", item = {name = "quality-module-3", quality = "epic", comparator = "="}, count = 1}

data.raw.technology["battery-mk2-equipment"].prerequisites = {"power-armor","battery-equipment","low-density-structure","quality-module"}
data.raw.technology["battery-mk2-equipment"].research_trigger = {type = "craft-item", item = {name = "battery-equipment", quality = "uncommon", comparator = ">="}, count = 1}

data.raw.technology["power-armor-mk2"].prerequisites = {"speed-module-2", "efficiency-module-2", "low-density-structure", "power-armor", "military-4"}

data.raw.technology["power-armor"].research_trigger = {type = "craft-item", item = "processing-unit", count = 250}

data.raw.technology["laser-turret"].prerequisites = {"laser", "military-2"}

data.raw.technology["personal-laser-defense-equipment"].prerequisites = {"low-density-structure", "military-3", "solar-panel-equipment", "laser-turret", "power-armor"}
data.raw.technology["personal-laser-defense-equipment"].research_trigger = {type = "craft-item", item = "laser-turret", count = 50}

data.raw.technology["effect-transmission"].prerequisites = {"speed-module", "productivity-module", "efficiency-module", "quality-module", "processing-unit", "advanced-material-processing-2"}

data.raw.technology["elevated-rail"].prerequisites = {"railway", "concrete"}

data.raw.technology["logistics-3"].prerequisites = {"lubricant", "logistics-2"}

data.raw.technology["recycling"].prerequisites = {"processing-unit", "concrete", "quality-module"}
data.raw.technology["recycling"].research_trigger = {type = "craft-item", item = "quality-module", count = 5}

data.raw.technology["military-4"].prerequisites = {"military-3", "explosives", "quality-module"}
data.raw.technology["military-4"].research_trigger = {type = "craft-item", item = "poison-capsule", count = 100}

data.raw.technology["fission-reactor-equipment"].prerequisites = {"nuclear-power", "power-armor", "processing-unit", "low-density-structure"}
data.raw.technology["fission-reactor-equipment"].research_trigger = {type = "craft-item", item = "uranium-fuel-cell", count = 100}

data.raw.technology["discharge-defense-equipment"].prerequisites = {"solar-panel-equipment", "military-3", "laser-turret", "power-armor"}
data.raw.technology["discharge-defense-equipment"].research_trigger = {type = "craft-item", item = "laser-turret", count = 75}

data.raw.technology["atomic-bomb"].research_trigger = {type = "craft-item", item = "uranium-235", count = 100}
data.raw.technology["explosive-rocketry"].research_trigger = {type = "craft-item", item = "rocket", count = 1000}

data.raw.technology["artillery-shell-range-1"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["artillery-shell-speed-1"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["follower-robot-count-5"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["follower-robot-count-5"].prerequisites = {"space-science-pack"}
data.raw.technology["laser-weapons-damage-7"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["laser-weapons-damage-7"].prerequisites = {"space-science-pack"}
data.raw.technology["mining-productivity-4"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["mining-productivity-4"].prerequisites = {"space-science-pack"}
data.raw.technology["physical-projectile-damage-7"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["physical-projectile-damage-7"].prerequisites = {"space-science-pack"}
data.raw.technology["refined-flammables-7"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["refined-flammables-7"].prerequisites = {"space-science-pack"}
data.raw.technology["stronger-explosives-7"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["stronger-explosives-7"].prerequisites = {"space-science-pack"}
data.raw.technology["worker-robots-speed-6"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["worker-robots-speed-6"].prerequisites = {"space-science-pack"}
data.raw.technology["space-science-pack"].effects = {{type = "unlock-recipe", recipe = "lab"}}
data.raw.technology["research-speed-1"].prerequisites = {"space-science-pack"}
data.raw.technology["research-speed-1"].unit.count = 4000
data.raw.technology["research-speed-1"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["research-speed-2"].prerequisites = {"research-speed-1"}
data.raw.technology["research-speed-2"].unit.count = 8000
data.raw.technology["research-speed-2"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["research-speed-3"].prerequisites = {"research-speed-2"}
data.raw.technology["research-speed-3"].unit.count = 12000
data.raw.technology["research-speed-3"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["research-speed-4"].prerequisites = {"research-speed-3"}
data.raw.technology["research-speed-4"].unit.count = 16000
data.raw.technology["research-speed-4"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["research-speed-5"].prerequisites = {"research-speed-4"}
data.raw.technology["research-speed-5"].unit.count = 20000
data.raw.technology["research-speed-5"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["research-speed-6"].prerequisites = {"research-speed-5"}
data.raw.technology["research-speed-6"].unit.count = 24000
data.raw.technology["research-speed-6"].unit.ingredients = {{"space-science-pack", 1}}

data.raw.technology["laser-shooting-speed-1"].prerequisites = {"laser-turret", "quality-module"}
data.raw.technology["laser-shooting-speed-1"].research_trigger = {type = "craft-item", item = {name = "laser-turret", quality = "uncommon", comparator = "="}, count = 1}
data.raw.technology["laser-shooting-speed-2"].prerequisites = {"distractor", "quality-module"}
data.raw.technology["laser-shooting-speed-2"].research_trigger = {type = "craft-item", item = {name = "distractor-capsule", quality = "uncommon", comparator = "="}, count = 1}
data.raw.technology["laser-shooting-speed-3"].prerequisites = {"personal-laser-defense-equipment", "quality-module"}
data.raw.technology["laser-shooting-speed-3"].research_trigger = {type = "craft-item", item = {name = "personal-laser-defense-equipment", quality = "uncommon", comparator = "="}, count = 1}
data.raw.technology["laser-shooting-speed-4"].prerequisites = {"laser-turret", "quality-module"}
data.raw.technology["laser-shooting-speed-4"].research_trigger = {type = "craft-item", item = {name = "laser-turret", quality = "rare", comparator = "="}, count = 5}
data.raw.technology["laser-shooting-speed-5"].prerequisites = {"distractor", "quality-module"}
data.raw.technology["laser-shooting-speed-5"].research_trigger = {type = "craft-item", item = {name = "distractor-capsule", quality = "rare", comparator = ">="}, count = 5}
data.raw.technology["laser-shooting-speed-6"].prerequisites = {"personal-laser-defense-equipment", "quality-module"}
data.raw.technology["laser-shooting-speed-6"].research_trigger = {type = "craft-item", item = {name = "personal-laser-defense-equipment", quality = "rare", comparator = ">="}, count = 5}
data.raw.technology["laser-shooting-speed-7"].prerequisites = {"laser-turret", "quality-module", "epic-quality"}
data.raw.technology["laser-shooting-speed-7"].research_trigger = {type = "craft-item", item = {name = "laser-turret", quality = "epic", comparator = ">="}, count = 1}


data.raw.technology["laser-weapons-damage-1"].prerequisites = {"laser-turret", "quality-module"}
data.raw.technology["laser-weapons-damage-1"].research_trigger = {type = "craft-item", item = {name = "laser-turret", quality = "uncommon", comparator = "="}, count = 5}
data.raw.technology["laser-weapons-damage-2"].prerequisites = {"distractor", "quality-module"}
data.raw.technology["laser-weapons-damage-2"].research_trigger = {type = "craft-item", item = {name = "distractor-capsule", quality = "uncommon", comparator = "="}, count = 5}
data.raw.technology["laser-weapons-damage-3"].prerequisites = {"personal-laser-defense-equipment", "quality-module"}
data.raw.technology["laser-weapons-damage-3"].research_trigger = {type = "craft-item", item = {name = "personal-laser-defense-equipment", quality = "uncommon", comparator = "="}, count = 5}
data.raw.technology["laser-weapons-damage-4"].prerequisites = {"laser-turret", "quality-module"}
data.raw.technology["laser-weapons-damage-4"].research_trigger = {type = "craft-item", item = {name = "laser-turret", quality = "rare", comparator = ">="}, count = 1}
data.raw.technology["laser-weapons-damage-5"].prerequisites = {"distractor", "quality-module"}
data.raw.technology["laser-weapons-damage-5"].research_trigger = {type = "craft-item", item = {name = "distractor-capsule", quality = "rare", comparator = ">="}, count = 1}
data.raw.technology["laser-weapons-damage-6"].prerequisites = {"personal-laser-defense-equipment", "quality-module"}
data.raw.technology["laser-weapons-damage-6"].research_trigger = {type = "craft-item", item = {name = "personal-laser-defense-equipment", quality = "rare", comparator = ">="}, count = 1}



for _, tech in pairs(data.raw.technology) do
    if tech.research_trigger then
        tech.unit = nil
    if not (string.find(tech.name, "research-speed", 1, true) or string.find(tech.name, "mining-productivity", 1, true)) then
        tech.upgrade = false
    end
  end