#!lua
-- Lua (Defintion: the glue of programming - where roblox game developers have set its bar above what another other industry has) 

-- Tested on base lua 5.1 with success
-- May be a possible method of data saving in P3D if there interpreter doesn't sandbox io & if javascript is able to successfully write S-Vars.

-- Lua write to file from Prepar3D test script
function writeFunc(filepath, filename, outtext)
    local file = io.open(filepath..filename, 'w')
    io.output(file)
    io.write(outtext)
    io.close(file)
end
writeFunc('../', 'testoutput.txt', 'Hello world from lua io\n')
