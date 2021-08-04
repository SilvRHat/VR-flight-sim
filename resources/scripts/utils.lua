--[[
    Main
    SHINE Lab & Aptima | Collaborative VR Flight Sim Research Project

    Class which abstracts logic for data saving
]]

-- Dependencies
local project_path = ''
local CONFIG = require(project_path..'CONFIG')

-- Class
local utils = {}

-- Initializes variables
local lvars = {
    ['_continue'] = 0;
    ['_state'] = 1;
    ['_options'] = 2;
    ['_level'] = 0;
    ['_gate'] = 0;
    ['_hit'] = 0;
    ['_ui_focus_id'] = 2*200;
    ['_last_poll'] = 0;
}
function utils.init()
    for lvar, default in pairs(lvars) do
        varset('L:'..lvar, default)
    end
    for i=0, 15,1  do
        varset('L:_toggle'..i, 0)
    end
end

function utils.timestamp(string)

end

utils.init()



return true