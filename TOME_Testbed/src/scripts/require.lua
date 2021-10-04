--[[
    Require Utility Function
    SHINE Lab & Aptima | Collaborative VR Flight Sim Research Project

    Used to import lua scripts
]]

-- Compatibility
    -- Prepar3D Funcs
    varget = varget or function(varname, _) return _G[varname] end
    varset = varset or function(varname, val) _G[varname]=val end

    -- Lua 5.1
    io = io or {}
    load = load or loadstring or {}

    
-- Utility function for importing lua scripts
    -- Improves upon the default require function (sandboxed in prepar3d)
    -- @param filename - File to look for, resolved relatively
function require(filename)
    local user = os.getenv('USERNAME');
    local paths = {
        '',
        string.format('C:\\Users\\%s\\Documents\\Prepar3D v5 Files\\TOME_Testbed\\',user),
    }
    local fileexts = {
        '',
        '.lua'
    }

    local PATHFILE_EXT = 'P3D_PROJECT_PATH.txt'
    local pathfile = io.open(PATHFILE_EXT)
    if pathfile then
        for line in io.lines(PATHFILE_EXT) do table.insert(paths, line) end 
        pathfile:close()
    end

    for _, path in ipairs(paths) do 
    for _, ext in ipairs(fileexts) do
            
        local f = io.open(string.format("%s%s%s", path, filename, ext), 'r')
        if f then
            local src = f:read('*a')
            f:close()
            return load(src)(), path
        end

    end 
    end
end

-- Minature Require
function require(filename)local user=os.getenv('USERNAME');local paths={'',string.format('C:\\Users\\%s\\Documents\\Prepar3D v5 Files\\TOME_Testbed\\',user)};local fileexts={'','.lua'};local PATHFILE_EXT='P3D_PROJECT_PATH.txt';local pathfile=io.open(PATHFILE_EXT);if pathfile then;for line in io.lines(PATHFILE_EXT) do table.insert(paths,line) end;pathfile:close();end;for _,path in ipairs(paths) do;for _,ext in ipairs(fileexts)do;local f=io.open(string.format("%s%s%s",path,filename,ext),'r');if f then;local src=f:read('*a');f:close();return load(src)(),path;end;end;end;end;