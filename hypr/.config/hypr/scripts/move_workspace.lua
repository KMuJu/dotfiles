local direction = ...

local active_ws = hl.get_active_workspace()
local current_monitor = hl.get_active_monitor()
local monitors = hl.get_monitors()

if not current_monitor then
	return
end

table.sort(monitors, function(a, b)
	return a.x < b.x
end)

local current_index = 1
for i, monitor in ipairs(monitors) do
	if monitor.id == current_monitor.id then
		current_index = i
	end
end

local target_index
if direction == "right" then
	target_index = current_index == #monitors and 1 or current_index + 1
else
	target_index = current_index == 1 and #monitors or current_index - 1
end
local target_monitor = monitors[target_index]

hl.dispatch(hl.dsp.workspace.move({ workspace = active_ws, monitor = target_monitor }))
