--[[
    Select Input
    SHINE Lab & Aptima | Collaborative VR Flight Sim Research Project

    This file changes state of the simulation on user clicking button (will often toggle selection)
]]

ipc = ipc or {}

local options = ipc.readLvar('L:_ui_options')
local focus_id = ipc.readLvar('L:_ui_focuson') % (options)


local function selectSingle()
    -- If last option, toggle continue indicator
    if focus_id==options-1 then
        ipc.writeLvar('L:_continue', 1) 
    return end

    for i=0, options, 1 do
        ipc.writeLvar('L:_ui_toggle'..i, i==focus_id and 1 or 0)
    end
end

local function selectMultichoice()
    -- If last option, toggle continue indicator
    if focus_id==options-1 then
        ipc.writeLvar('L:_continue', 1) 
    end
    -- Toggle ui element
    local toggle = ipc.readLvar('L:_ui_toggle'..focus_id)
    ipc.writeLvar('L:_ui_toggle'..focus_id, toggle==1 and 0 or 1)
end


if ipc.readLvar('L:_ui_multichoice')==1 then
    selectMultichoice()
else
    selectSingle()
end

return 1