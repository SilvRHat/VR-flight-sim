--[[
    Main
    SHINE Lab & Aptima | Collaborative VR Flight Sim Research Project

    Class which abstracts logic for data saving
]]

-- Dependencies
local project_path = ''
local CONFIG = require(project_path..'CONFIG')

-- Class
local MOD = {}

-- Initializes variables
local lvars = {
    ['_continue'] = 0;
    ['_state'] = 0;
    ['_options'] = 0;
    ['_level'] = 0;
    ['_gate'] = 0;
    ['_hit'] = 0;
    ['_ui_focus_id'] = 0;
    ['_last_poll'] = 0;
}
function MOD.initVars()
    for lvar, default in pairs(lvars) do
        varset('L:'..lvar,'number',default)
    end
    for i=0, CONFIG.max_ui_options,1  do
        varset('L:_toggle'..i,'number',0)
    end
end

function MOD.timestamp(string)

end



return MOD