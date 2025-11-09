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
-- data.raw.technology["automation-science-pack"] = nil
-- data.raw.technology["logistic-science-pack"] = nil
-- data.raw.technology["military-science-pack"] = nil
-- data.raw.technology["chemical-science-pack"] = nil
-- data.raw.technology["production-science-pack"] = nil
-- data.raw.technology["utility-science-pack"] = nil

data.raw.technology["automation"].prerequisites = {"steam-power", "electronics"}
data.raw.technology["automation"].research_trigger = {type = "craft-item", item = "electronic-circuit", count = 30}

data.raw.technology["electric-mining-drill"].prerequisites = {"steam-power", "electronics"}
data.raw.technology["electric-mining-drill"].research_trigger = {type = "craft-item", item = "transport-belt", count = 50}
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
data.raw.technology["military"].prerequisites = {"steam-power", "electronics"}
data.raw.technology["military"].research_trigger = {type = "craft-item", item = "firearm-magazine", count = 50}
data.raw.technology["stone-wall"].prerequisites = {"steam-power", "electronics"}
data.raw.technology["stone-wall"].research_trigger = {type = "craft-item", item = "stone-brick", count = 25}
data.raw.technology["gate"].prerequisites = {"stone-wall", "steel-processing"}
data.raw.technology["gate"].research_trigger = {type = "craft-item", item = "stone-wall", count = 50}
data.raw.technology["steel-processing"].prerequisites = {"steam-power", "electronics"}
data.raw.technology["steel-processing"].research_trigger = {type = "craft-item", item = "iron-plate", count = 1000}
data.raw.technology["heavy-armor"].research_trigger = {type = "craft-item", item = "firearm-magazine", count = 500}
data.raw.technology["physical-projectile-damage-1"].research_trigger = {type = "craft-item", item = "shotgun", count = 1}
data.raw.technology["radar"].prerequisites = {"steam-power", "electronics"}
data.raw.technology["radar"].research_trigger = {type = "craft-item", item = "iron-plate", count = 250}

data.raw.technology["weapon-shooting-speed-1"].research_trigger = {type = "craft-item", item = "submachine-gun", count = 1}
data.raw.technology["weapon-shooting-speed-2"].prerequisites = {"weapon-shooting-speed-1"}
data.raw.technology["weapon-shooting-speed-2"].research_trigger = {type = "craft-item", item = "firearm-magazine", count = 250}
data.raw.technology["weapon-shooting-speed-3"].prerequisites = {"weapon-shooting-speed-2", "military-2"}
data.raw.technology["weapon-shooting-speed-3"].research_trigger = {type = "craft-item", item = "piercing-rounds-magazine", count = 250}
data.raw.technology["weapon-shooting-speed-4"].prerequisites = {"weapon-shooting-speed-3", "tank"}
data.raw.technology["weapon-shooting-speed-4"].research_trigger = {type = "craft-item", item = "cannon-shell", count = 150}
data.raw.technology["weapon-shooting-speed-5"].prerequisites = {"weapon-shooting-speed-4", "rocketry"}
data.raw.technology["weapon-shooting-speed-5"].research_trigger = {type = "craft-item", item = "rocket", count = 150}
data.raw.technology["weapon-shooting-speed-6"].prerequisites = {"weapon-shooting-speed-5", "robotics"}
data.raw.technology["weapon-shooting-speed-6"].research_trigger = {type = "craft-item", item = "explosive-rocket", count = 150}

data.raw.technology["physical-projectile-damage-2"].prerequisites = {"physical-projectile-damage-1"}
data.raw.technology["physical-projectile-damage-2"].research_trigger = {type = "craft-item", item = "shotgun-shell", count = 50}
data.raw.technology["physical-projectile-damage-3"].prerequisites = {"physical-projectile-damage-2", "military-2"}
data.raw.technology["physical-projectile-damage-3"].research_trigger = {type = "craft-item", item = "shotgun-shell", count = 250}
data.raw.technology["physical-projectile-damage-4"].prerequisites = {"physical-projectile-damage-3", "defender"}
data.raw.technology["physical-projectile-damage-4"].research_trigger = {type = "craft-item", item = "defender-capsule", count = 100}
data.raw.technology["physical-projectile-damage-5"].prerequisites = {"physical-projectile-damage-4", "tank"}
data.raw.technology["physical-projectile-damage-5"].research_trigger = {type = "craft-item", item = "explosive-cannon-shell", count = 150}
data.raw.technology["physical-projectile-damage-6"].prerequisites = {"physical-projectile-damage-5", "military-4"}
data.raw.technology["physical-projectile-damage-6"].research_trigger = {type = "craft-item", item = "piercing-shotgun-shell", count = 250}

data.raw.technology["advanced-material-processing"].prerequisites = {"steel-processing"}
data.raw.technology["advanced-material-processing"].research_trigger = {type = "craft-item", item = "steel-plate", count = 1000}
data.raw.technology["automation-2"].prerequisites = {"steel-processing", "automation"}
data.raw.technology["automation-2"].research_trigger = {type = "craft-item", item = "assembling-machine-1", count = 200}
data.raw.technology["circuit-network"].prerequisites = {"automation"}
data.raw.technology["circuit-network"].research_trigger = {type = "craft-item", item = "electronic-circuit", count = 1000}
data.raw.technology["engine"].prerequisites = {"steel-processing"}
data.raw.technology["engine"].research_trigger = {type = "craft-item", item = "pipe", count = 200}
data.raw.technology["electric-energy-distribution-1"].prerequisites = {"steel-processing"}
data.raw.technology["electric-energy-distribution-1"].research_trigger = {type = "craft-item", item = "small-electric-pole", count = 100}
data.raw.technology["landfill"].prerequisites = {"automation"}
data.raw.technology["landfill"].research_trigger = {type = "craft-item", item = "stone", count = 250}
data.raw.technology["logistics-2"].prerequisites = {"logistics"}
data.raw.technology["logistics-2"].research_trigger = {type = "craft-item", item = "transport-belt", count = 1000}
data.raw.technology["toolbelt"].prerequisites = {"steel-processing", "logistics"}
data.raw.technology["toolbelt"].research_trigger = {type = "craft-item", item = "iron-gear-wheel", count = 2000}
data.raw.technology["bulk-inserter"].prerequisites = {"logistics-2"}
data.raw.technology["bulk-inserter"].research_trigger = {type = "craft-item", item = "fast-inserter", count = 500}
data.raw.technology["military-2"].prerequisites = {"military", "steel-processing"}
data.raw.technology["military-2"].research_trigger = {type = "craft-item", item = "gun-turret", count = 100}
data.raw.technology["solar-energy"].prerequisites = {"military", "steel-processing"}
data.raw.technology["solar-energy"].research_trigger = {type = "craft-fluid", fluid = "steam", count = 1000000}
data.raw.technology["fluid-handling"].research_trigger = {type = "craft-item", item = "assembling-machine-2", count = 50}
data.raw.technology["oil-gathering"].research_trigger = {type = "craft-item", item = "pipe-to-ground", count = 20}
data.raw.technology["railway"].research_trigger = {type = "craft-item", item = "engine-unit", count = 150}
data.raw.technology["automobilism"].research_trigger = {type = "craft-item", item = "engine-unit", count = 8}
data.raw.technology["fluid-wagon"].research_trigger = {type = "craft-item", item = "locomotive", count = 1}
data.raw.technology["automated-rail-transportation"].research_trigger = {type = "craft-item", item = "locomotive", count = 2}
data.raw.technology["flammables"].research_trigger = {type = "craft-fluid", fluid = "crude-oil", count = 1000}
data.raw.technology["flamethrower"].research_trigger = {type = "craft-fluid", fluid = "crude-oil", count = 10000}
data.raw.technology["plastics"].research_trigger = {type = "craft-fluid", fluid = "petroleum-gas", count = 500}
data.raw.technology["advanced-circuit"].research_trigger = {type = "craft-item", item = "plastic-bar", count = 500}
data.raw.technology["modules"].research_trigger = {type = "craft-item", item = "advanced-circuit", count = 500}
data.raw.technology["modular-armor"].research_trigger = {type = "craft-item", item = "advanced-circuit", count = 250}
data.raw.technology["solar-panel-equipment"].research_trigger = {type = "craft-item", item = "solar-panel", count = 100}
data.raw.technology["sulfur-processing"].research_trigger = {type = "craft-item", item = "chemical-plant", count = 10}
data.raw.technology["explosives"].research_trigger = {type = "craft-item", item = "sulfur", count = 100}
data.raw.technology["cliff-explosives"].research_trigger = {type = "craft-item", item = "explosives", count = 100}
data.raw.technology["land-mine"].prerequisites = {"explosives"}
data.raw.technology["land-mine"].research_trigger = {type = "craft-item", item = "explosives", count = 1000}
data.raw.technology["battery"].research_trigger = {type = "craft-fluid", fluid = "sulfuric-acid", count = 1000}
data.raw.technology["battery-equipment"].research_trigger = {type = "craft-item", item = "battery", count = 100}
data.raw.technology["rocketry"].prerequisites = {"explosives", "flammables"}
data.raw.technology["rocketry"].research_trigger = {type = "craft-item", item = "explosives", count = 200}
data.raw.technology["inserter-capacity-bonus-3"].prerequisites = {"fast-inserter"}
data.raw.technology["inserter-capacity-bonus-3"].research_trigger = {type = "craft-item", item = "fast-inserter", count = 500}
data.raw.technology["inserter-capacity-bonus-4"].research_trigger = {type = "craft-item", item = "bulk-inserter", count = 500}
data.raw.technology["inserter-capacity-bonus-4"].prerequisites = {"bulk-inserter"}
data.raw.technology["inserter-capacity-bonus-2"].prerequisites = {"automation"}
data.raw.technology["inserter-capacity-bonus-2"].research_trigger = {type = "craft-item", item = "long-handed-inserter", count = 500}
data.raw.technology["inserter-capacity-bonus-1"].prerequisites = {"inserter-capacity-bonus-3"}
data.raw.technology["inserter-capacity-bonus-1"].research_trigger = {type = "craft-item", item = "inserter", count = 500}
data.raw.technology["concrete"].research_trigger = {type = "craft-item", item = "stone-brick", count = 2000}
data.raw.technology["stronger-explosives-1"].research_trigger = {type = "craft-item", item = "grenade", count = 200}
data.raw.technology["stronger-explosives-2"].prerequisites = {land-mine"}
data.raw.technology["stronger-explosives-2"].research_trigger = {type = "craft-item", item = "land-mine", count = 200}
data.raw.technology["stronger-explosives-3"].prerequisites = {"rocketry"}
data.raw.technology["stronger-explosives-3"].research_trigger = {type = "craft-item", item = "rocket", count = 200}
data.raw.technology["stronger-explosives-4"].prerequisites = {"military-4"}
data.raw.technology["stronger-explosives-4"].research_trigger = {type = "craft-item", item = "cluster-grenade", count = 200}
data.raw.technology["stronger-explosives-5"].prerequisites = {"explosive-rocketry"}
data.raw.technology["stronger-explosives-5"].research_trigger = {type = "craft-item", item = "explosive-rocket", count = 200}
data.raw.technology["stronger-explosives-6"].prerequisites = {"atomic-bomb"}
data.raw.technology["stronger-explosives-6"].research_trigger = {type = "craft-item", item = "atomic-bomb", count = 5}
-- data.raw.technology["stronger-explosives-7"].research_trigger = {type = "craft-item", item = "atomic-bomb", count = 1}

data.raw.technology["productivity-module"].research_trigger = {type = "craft-item", item = "iron-ore", count = 40000}
data.raw.technology["speed-module"].research_trigger = {type = "craft-item", item = "copper-ore", count = 15000}
data.raw.technology["efficiency-module"].research_trigger = {type = "craft-item", item = "coal", count = 15000}
data.raw.technology["quality-module"].research_trigger = {type = "craft-item", item = "assembling-machine-2", count = 200}

data.raw.technology["belt-immunity-equipment"].research_trigger = {type = "craft-item", item = "transport-belt", count = 2500}
data.raw.technology["night-vision-equipment"].research_trigger = {type = "craft-item", item = "small-lamp", count = 150}
data.raw.technology["electric-energy-accumulators"].research_trigger = {type = "craft-item", item = "medium-electric-pole", count = 500}
data.raw.technology["mining-productivity-1"].research_trigger = {type = "craft-item", item = "electric-mining-drill", count = 100}
data.raw.technology["mining-productivity-2"].prerequisites = {"mining-productivity-1", "sulfur-processing"}
data.raw.technology["mining-productivity-2"].research_trigger = {type = "craft-item", item = "electric-mining-drill", count = 200}
data.raw.technology["mining-productivity-3"].prerequisites = {"mining-productivity-2", "robotics", "processing-unit", "low-density-structure", "advanced-material-processing-2", "productivity-module", "railway"}
data.raw.technology["mining-productivity-3"].research_trigger = {type = "craft-item", item = "electric-mining-drill", count = 300}

data.raw.technology["defender"].prerequisites = {"stone-wall", "military-2"}
data.raw.technology["defender"].research_trigger = {type = "craft-item", item = "piercing-rounds-magazine", count = 200}
data.raw.technology["follower-robot-count-1"].research_trigger = {type = "craft-item", item = "defender-capsule", count = 50}
data.raw.technology["distractor"].research_trigger = {type = "craft-item", item = "defender-capsule", count = 100}
data.raw.technology["follower-robot-count-2"].research_trigger = {type = "craft-item", item = "distractor-capsule", count = 50}
data.raw.technology["destroyer"].research_trigger = {type = "craft-item", item = "distractor-capsule", count = 100}
data.raw.technology["follower-robot-count-3"].research_trigger = {type = "craft-item", item = "destroyer-capsule", count = 50}
data.raw.technology["follower-robot-count-4"].research_trigger = {type = "craft-item", item = "destroyer-capsule", count = 150}

data.raw.technology["refined-flammables-1"].research_trigger = {type = "craft-item", item = "flamethrower-ammo", count = 50}
data.raw.technology["refined-flammables-2"].prerequisites = {"refined-flammables-1"}
data.raw.technology["refined-flammables-2"].research_trigger = {type = "craft-item", item = "flamethrower-ammo", count = 100}
data.raw.technology["refined-flammables-3"].prerequisites = {"refined-flammables-2"}
data.raw.technology["refined-flammables-3"].research_trigger = {type = "craft-item", item = "flamethrower-ammo", count = 200}
data.raw.technology["refined-flammables-4"].prerequisites = {"refined-flammables-3", "robotics", "processing-unit", "low-density-structure"}
data.raw.technology["refined-flammables-4"].research_trigger = {type = "craft-item", item = "flamethrower-ammo", count = 400}
data.raw.technology["refined-flammables-5"].research_trigger = {type = "craft-item", item = "flamethrower-ammo", count = 800}
data.raw.technology["refined-flammables-6"].research_trigger = {type = "craft-item", item = "flamethrower-ammo", count = 1600}

data.raw.technology["exoskeleton-equipment"].research_trigger = {type = "craft-item", item = "electric-engine-unit", count = 400}

data.raw.technology["advanced-combinators"].prerequisites = {"advanced-circuit", "circuit-network"}
data.raw.technology["advanced-combinators"].research_trigger = {type = "craft-item", item = "decider-combinator", count = 15}

data.raw.technology["advanced-material-processing-2"].prerequisites = {"advanced-circuit", "advanced-material-processing"}
data.raw.technology["advanced-material-processing-2"].research_trigger = {type = "craft-item", item = "coal", count = 40000}

data.raw.technology["advanced-oil-processing"].prerequisites = {"advanced-circuit", "sulfur-processing"}
data.raw.technology["advanced-oil-processing"].research_trigger = {type = "craft-item", item = "sulfur", count = 1000}

data.raw.technology["coal-liquefaction"].prerequisites = {"advanced-oil-processing", "advanced-material-processing-2", "productivity-module", "railway"}
data.raw.technology["coal-liquefaction"].research_trigger = {type = "craft-fluid", fluid = "heavy-oil", count = 1000}

data.raw.technology["lubricant"].prerequisites = {"advanced-oil-processing"}
data.raw.technology["lubricant"].research_trigger = {type = "craft-fluid", fluid = "heavy-oil", count = 50}

data.raw.technology["rocket-fuel"].research_trigger = {type = "craft-item", item = "solid-fuel", count = 1000}

data.raw.technology["laser"].prerequisites = {"advanced-circuit", "sulfur-processing", "battery"}
data.raw.technology["laser"].research_trigger = {type = "craft-item", item = "battery", count = 1000}
data.raw.technology["processing-unit"].prerequisites = {"advanced-circuit", "sulfur-processing"}
data.raw.technology["processing-unit"].research_trigger = {type = "craft-item", item = "advanced-circuit", count = 2000}
data.raw.technology["military-3"].prerequisites = {"advanced-circuit", "sulfur-processing", "military-2", "stone-wall"}
data.raw.technology["military-3"].research_trigger = {type = "craft-item", item = "piercing-rounds-magazine", count = 1000}
data.raw.technology["uranium-mining"].prerequisites = {"concrete", "advanced-circuit", "sulfur-processing"}
data.raw.technology["uranium-mining"].research_trigger = {type = "craft-fluid", fluid = "steam", count = 10000000}
data.raw.technology["braking-force-1"].prerequisites = {"railway"}
data.raw.technology["braking-force-1"].research_trigger = {type = "craft-item", item = "rail", count = 500}
data.raw.technology["braking-force-2"].research_trigger = {type = "craft-item", item = "rail", count = 1000}
data.raw.technology["braking-force-3"].prerequisites = {"braking-force-2", "advanced-circuit"}
data.raw.technology["braking-force-3"].research_trigger = {type = "craft-item", item = "rail", count = 2000}
data.raw.technology["braking-force-4"].prerequisites = {"braking-force-3", "advanced-material-processing-2"}
data.raw.technology["braking-force-4"].research_trigger = {type = "craft-item", item = "rail", count = 3000}
data.raw.technology["braking-force-6"].prerequisites = {"braking-force-4", "processing-unit"}
data.raw.technology["braking-force-5"].research_trigger = {type = "craft-item", item = "rail", count = 4000}
data.raw.technology["braking-force-6"].prerequisites = {"braking-force-5", "robotics"}
data.raw.technology["braking-force-6"].research_trigger = {type = "craft-item", item = "rail", count = 5000}
data.raw.technology["braking-force-7"].prerequisites = {"braking-force-5", "low-density-structure"}
data.raw.technology["braking-force-7"].research_trigger = {type = "craft-item", item = "rail", count = 6000}
data.raw.technology["tank"].research_trigger = {type = "craft-item", item = "car", count = 1}
data.raw.technology["uranium-ammo"].research_trigger = {type = "craft-item", item = "uranium-238", count = 1000}
data.raw.technology["kovarex-enrichment-process"].prerequisites = {"nuclear-power"}
data.raw.technology["kovarex-enrichment-process"].research_trigger = {type = "craft-item", item = "uranium-fuel-cell", count = 15}
data.raw.technology["nuclear-power"].research_trigger = {type = "craft-item", item = "uranium-235", count = 1}
data.raw.technology["nuclear-fuel-reprocessing"].prerequisites = {"nuclear-power", "productivity-module"}
data.raw.technology["nuclear-fuel-reprocessing"].research_trigger = {type = "craft-item", item = "depleted-uranium-fuel-cell", count = 150}
data.raw.technology["productivity-module-2"].research_trigger = {type = "craft-item", item = "productivity-module", count = 100}
data.raw.technology["speed-module-2"].research_trigger = {type = "craft-item", item = "speed-module", count = 100}
data.raw.technology["efficiency-module-2"].research_trigger = {type = "craft-item", item = "efficiency-module", count = 100}
data.raw.technology["quality-module-2"].research_trigger = {type = "craft-item", item = "quality-module", count = 100}

data.raw.technology["productivity-module-3"].prerequisites = {"productivity-module-2", "advanced-material-processing-2"}
data.raw.technology["speed-module-3"].prerequisites = {"productivity-module-2", "advanced-material-processing-2"}
data.raw.technology["efficiency-module-3"].prerequisites = {"productivity-module-2", "advanced-material-processing-2"}
data.raw.technology["quality-module-3"].prerequisites = {"productivity-module-2", "advanced-material-processing-2"}
data.raw.technology["productivity-module-3"].research_trigger = {type = "craft-item", item = "productivity-module-2", count = 100}
data.raw.technology["speed-module-3"].research_trigger = {type = "craft-item", item = "speed-module-2", count = 100}
data.raw.technology["efficiency-module-3"].research_trigger = {type = "craft-item", item = "efficiency-module-2", count = 100}
data.raw.technology["quality-module-3"].research_trigger = {type = "craft-item", item = "quality-module-2", count = 100}


data.raw.technology["electric-energy-distribution-2"].prerequisites = {"electric-energy-distribution-1", "advanced-circuit"}
data.raw.technology["electric-energy-distribution-2"].research_trigger = {type = "craft-item", item = "big-electric-pole", count = 500}
data.raw.technology["artillery"].research_trigger = {type = "craft-item", item = "radar", count = 100}

data.raw.technology["electric-engine"].research_trigger = {type = "craft-item", item = "engine-unit", count = 500}

data.raw.technology["automation-3"].prerequisites = {"electric-engine", "advanced-material-processing-2", "productivity-module", "speed-module"}
data.raw.technology["automation-3"].research_trigger = {type = "craft-item", item = "assembling-machine-2", count = 1000}

data.raw.technology["energy-shield-equipment"].prerequisites = {"solar-panel-equipment", "military-2"}
data.raw.technology["energy-shield-equipment"].research_trigger = {type = "craft-item", item = "solar-panel-equipment", count = 2}
data.raw.technology["energy-shield-mk2-equipment"].prerequisites = {"energy-shield-equipment", "military-3", "power-armor", "low-density-structure", "quality-module"}
data.raw.technology["energy-shield-mk2-equipment"].research_trigger = {type = "craft-item", item = {name = "energy-shield-equipment", quality = "uncommon", comparator = ">="}, count = 2}

data.raw.technology["robotics"].research_trigger = {type = "craft-item", item = "electric-engine-unit", count = 100}
data.raw.technology["logistic-robotics"].research_trigger = {type = "craft-item", item = "flying-robot-frame", count = 250}
data.raw.technology["construction-robotics"].research_trigger = {type = "craft-item", item = "flying-robot-frame", count = 100}

data.raw.technology["logistic-system"].prerequisites = {"robotics", "low-density-structure", "processing-unit"}
data.raw.technology["logistic-system"].research_trigger = {type = "craft-item", item = "logistic-robot", count = 100}
data.raw.technology["worker-robots-speed-1"].prerequisites = {"robotics"}
data.raw.technology["worker-robots-speed-1"].research_trigger = {type = "craft-item", item = "logistic-robot", count = 150}
data.raw.technology["worker-robots-storage-1"].prerequisites = {"robotics"}
data.raw.technology["worker-robots-storage-1"].research_trigger = {type = "craft-item", item = "construction-robot", count = 150}
data.raw.technology["worker-robots-speed-2"].prerequisites = {"worker-robots-speed-1", "quality-module"}
data.raw.technology["worker-robots-speed-2"].research_trigger = {type = "craft-item", item = {name ="construction-robot", quality = "uncommon", comparator = ">="}, count = 5}
data.raw.technology["worker-robots-storage-2"].prerequisites = {"worker-robots-storage-1", "advanced-material-processing-2", "processing-unit", "quality-module"}
data.raw.technology["worker-robots-storage-2"].research_trigger = {type = "craft-item", item = {name ="logistic-robot", quality = "uncommon", comparator = ">="}, count = 5}
data.raw.technology["worker-robots-speed-3"].prerequisites = {"worker-robots-speed-2", "processing-unit"}
data.raw.technology["worker-robots-speed-3"].research_trigger = {type = "craft-item", item = {name ="logistic-robot", quality = "rare", comparator = ">="}, count = 10}
data.raw.technology["worker-robots-storage-3"].prerequisites = {"worker-robots-storage-2", "processing-unit", "productivity-module"}
data.raw.technology["worker-robots-storage-3"].research_trigger = {type = "craft-item", item = {name ="construction-robot", quality = "rare", comparator = ">="}, count = 10}
data.raw.technology["worker-robots-speed-4"].prerequisites = {"worker-robots-speed-3", "low-density-structure", "epic-quality"}
data.raw.technology["worker-robots-speed-4"].research_trigger = {type = "craft-item", item = {name ="construction-robot", quality = "epic", comparator = ">="}, count = 15}
data.raw.technology["worker-robots-speed-5"].prerequisites = {"worker-robots-speed-4", "advanced-material-processing-2", "productivity-module", "epic-quality"}
data.raw.technology["worker-robots-speed-5"].research_trigger = {type = "craft-item", item = {name ="logistic-robot", quality = "epic", comparator = ">="}, count = 15}

data.raw.technology["low-density-structure"].prerequisites = {"plastics", "advanced-material-processing"}
data.raw.technology["low-density-structure"].research_trigger = {type = "craft-item", item = "steel-plate", count = 5000}

data.raw.technology["personal-roboport-equipment"].research_trigger = {type = "craft-item", item = "construction-robot", count = 10}
data.raw.technology["personal-roboport-mk2-equipment"].prerequisites = {"processing-unit", "personal-roboport-equipment", "solar-panel-equipment", "low-density-structure", "quality-module"}
data.raw.technology["personal-roboport-mk2-equipment"].research_trigger = {type = "craft-item", item = {name = "personal-roboport-equipment", quality = "uncommon", comparator = ">="}, count = 1}
data.raw.technology["spidertron"].research_trigger = {type = "craft-item", item = "efficiency-module-3", count = 2}
data.raw.technology["rocket-silo"].prerequisites = {"concrete", "rocket-fuel", "electric-energy-accumulators", "solar-energy", "processing-unit", "low-density-structure", "speed-module-3", "productivity-module-3", "radar"}
data.raw.technology["rocket-silo"].research_trigger = {type = "craft-item", item = "concrete", count = 1}

data.raw.technology["epic-quality"].prerequisites = {"quality-module-2"}
data.raw.technology["epic-quality"].research_trigger = {type = "craft-item", item = {name = "quality-module-2", quality = "rare", comparator = "="}, count = 1}
data.raw.technology["legendary-quality"].prerequisites = {"quality-module-3", "epic-quality"}
data.raw.technology["legendary-quality"].research_trigger = {type = "craft-item", item = {name = "quality-module-3", quality = "epic", comparator = "="}, count = 1000}

data.raw.technology["battery-mk2-equipment"].prerequisites = {"power-armor","battery-equipment","low-density-structure","quality-module"}
data.raw.technology["battery-mk2-equipment"].research_trigger = {type = "craft-item", item = {name = "battery-equipment", quality = "uncommon", comparator = ">="}, count = 1}

data.raw.technology["power-armor-mk2"].prerequisites = {"quality-module-2", "speed-module-2", "efficiency-module-2", "low-density-structure", "processing-unit", "military-4"}
data.raw.technology["power-armor-mk2"].research_trigger = {type = "craft-item", item = {name = "power-armor", quality = "uncommon", comparator = ">="}, count = 1}

data.raw.technology["power-armor"].research_trigger = {type = "craft-item", item = "modular-armor", count = 1}

data.raw.technology["laser-turret"].prerequisites = {"laser", "military-2"}
data.raw.technology["laser-turret"].research_trigger = {type = "craft-item", item = "gun-turret", count = 250}

data.raw.technology["personal-laser-defense-equipment"].prerequisites = {"low-density-structure", "military-3", "solar-panel-equipment", "laser-turret", "power-armor"}
data.raw.technology["personal-laser-defense-equipment"].research_trigger = {type = "craft-item", item = "laser-turret", count = 50}

data.raw.technology["effect-transmission"].prerequisites = {"speed-module", "productivity-module", "efficiency-module", "quality-module", "processing-unit", "advanced-material-processing-2"}
data.raw.technology["effect-transmission"].research_trigger = {type = "craft-item", item = {name = "speed-module", quality = "uncommon", comparator = ">="}, count = 10}

data.raw.technology["elevated-rail"].prerequisites = {"railway", "concrete"}
data.raw.technology["elevated-rail"].research_trigger = {type = "craft-item", item = "refined-concrete", count = 500}

data.raw.technology["logistics-3"].prerequisites = {"lubricant", "logistics-2"}
data.raw.technology["logistics-3"].research_trigger = {type = "craft-item", item = "fast-transport-belt", count = 5000}

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
data.raw.technology["laser-weapons-damage-7"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["mining-productivity-4"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["physical-projectile-damage-7"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["refined-flammables-7"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["stronger-explosives-7"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["worker-robots-speed-6"].unit.ingredients = {{"space-science-pack", 1}}
data.raw.technology["space-science-pack"].effects = {{type = "unlock-recipe", recipe = "lab"}}

-- for _, tech in pairs(data.raw.technology) do
-- --     if tech.research_trigger then
-- --         tech.unit = nil
-- --     end
-- --     if tech.prerequisites then
-- -- --     for i = #tech.prerequisites, 1, -1 do
-- -- --       if tech.prerequisites[i] == "space-science-pack" then
-- -- --         tech.prerequisites[i] = "rocket-silo"
-- -- --       elseif tech.prerequisites[i] == "automation-science-pack" then
-- -- --           tech.prerequisites[i] = "electronics"
-- -- --           table.insert(tech.prerequisites, "steam-power"
-- -- --       elseif tech.prerequisites[i] == "logistic-science-pack"
-- -- --           tech.prerequisites[i] = "electronics"
-- -- --           table.insert(tech.prerequisites, "steam-power"
-- -- --       elseif tech.prerequisites[i] == "promethium-science-pack" then
-- -- --         tech.prerequisites[i] = "space-science-pack"
-- --       end
-- --     if tech.prerequisites then
-- --         for i = #tech.prerequisites, 1, -1 do
-- --             if tech.prerequisites[i]
--   end