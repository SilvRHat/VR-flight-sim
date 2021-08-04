--[[
    Select Input
    SHINE Lab & Aptima | Collaborative VR Flight Sim Research Project

    This file changes state of the simulation on user clicking button (will often toggle selection)
]]

local state = ipc.readLvar('L:_state') or 0
local options = ipc.readLvar('L:_options') or 0
local focus_id = (ipc.readLvar('L:_ui_focus_id') or 0) % (options+1)


local function selectExclusive()
    if focus_id==options then
        ipc.writeLvar('L:_continue', 1) return end
    for i=0, options, 1 do
        ipc.writeLvar('L:_toggle'..i, i==focus_id and 1 or 0)
    end
end

local function selectInclusive()
    if focus_id==options then
        ipc.writeLvar('L:_continue', 1) return end
    local toggle = ipc.readLvar('L:_toggle'..focus_id)
    ipc.writeLvar('L:_toggle'..focus_id, toggle==1 and 0 or 1)
end

local stateFuncMapping = {
    [0] = selectInclusive;      -- Toggles selection
    [1] = selectExclusive;      -- Sets selection to current focus, removing selection on any other elements
}
stateFuncMapping[state]()

return 1