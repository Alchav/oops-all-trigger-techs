local Spec = require("common.trigger_spec")

-- Iterate surface NAMES safely (works during on_init)
local function surface_names()
  local out = {}
  if game and game.surfaces then
    for name, _ in pairs(game.surfaces) do out[#out+1] = name end
  end
  -- just in case some exotic scenario has none yet
  if #out == 0 then out[1] = "nauvis" end
  return out
end

local function total_item_output(force, item_name)
  -- Newer API: per-surface getter requires name/index
  if force.get_item_production_statistics then
    local total = 0
    for _, sname in ipairs(surface_names()) do
      -- guard with pcall so old saves/modpacks don’t explode
      local ok, stats = pcall(function() return force.get_item_production_statistics(sname) end)
      if ok and stats and stats.get_input_count then
        total = total + (stats.get_input_count(item_name) or 0)
      end
    end
    return total
  end

end

local function total_fluid_output(force, fluid_name)
  if force.get_fluid_production_statistics then
    local total = 0
    for _, sname in ipairs(surface_names()) do
      local ok, stats = pcall(function() return force.get_fluid_production_statistics(sname) end)
      if ok and stats and stats.get_input_count then
        total = total + (stats.get_input_count(fluid_name) or 0)
      end
    end
    return total
  end

end


local function current_count(force, c)
  if c.type == "craft-item"  and c.item  then return total_item_output(force, c.item) end
  if c.type == "craft-fluid" and c.fluid then return total_fluid_output(force, c.fluid) end
  return 0
end

local function all_conditions_met(force, def)
  for _, c in ipairs(def or {}) do
    if current_count(force, c) < (c.count or 1) then
      return false
    end
  end
  return true
end

local function check_and_trigger(force, tech_name, def)
  local tech = force.technologies[tech_name]
  if not tech or tech.researched or not tech.enabled then return end
  local proto = tech.prototype
  if not (proto and proto.research_trigger and proto.research_trigger.type == "scripted") then
    return
  end
  if all_conditions_met(force, def) then
    force.script_trigger_research(tech_name)
  end
end

local function check_all_for_force(force)
  for tech_name, def in pairs(Spec) do
    check_and_trigger(force, tech_name, def)
  end
end

-- script.on_init(function()
--   -- Immediate catch-up on existing saves: if counts already satisfy a tech, unlock it now
--   for _, f in pairs(game.forces) do
--     check_all_for_force(f)
--   end
-- end)
--
-- script.on_configuration_changed(function(_)
--   for _, f in pairs(game.forces) do
--     check_all_for_force(f)
--   end
-- end)

-- -- Optional: still listen to events just to re-check sooner than your next tick
-- script.on_event(defines.events.on_player_crafted_item, function(e)
--   local force = game.get_player(e.player_index).force
--   check_all_for_force(force)
-- end)
script.on_nth_tick(30, function()
  for _, f in pairs(game.forces) do
    check_all_for_force(f)
  end
end)

-- script.on_event(defines.events.on_built_entity, function(e)
--   local ent = e.created_entity or e.entity
--   if ent and ent.valid then check_all_for_force(ent.force) end
-- end)
--
-- script.on_event(defines.events.on_robot_built_entity, function(e)
--   local ent = e.created_entity or e.entity
--   if ent and ent.valid then check_all_for_force(ent.force) end
-- end)
