local Spec = require("common.trigger_spec")

local function surface_names()
  local out = {}
  if game and game.surfaces then
    for name, _ in pairs(game.surfaces) do out[#out+1] = name end
  end

  if #out == 0 then out[1] = "nauvis" end
  return out
end

local function total_item_output(force, item_name)
  if force.get_item_production_statistics then
    local total = 0
    for _, sname in ipairs(surface_names()) do
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

script.on_nth_tick(30, function()
  for _, f in pairs(game.forces) do
    check_all_for_force(f)
  end
end)
