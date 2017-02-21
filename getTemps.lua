-- round [num] to [places] decimal places
function round(num,places)
    local mult = 10^(places or 0)
    return math.floor(num*mult+0.5)/mult
end



getTempReading = function ()
    t = require("ds18b20")
    c = require("Client")

	-- GPIO mapping
    gpio0 = 3
    gpio2 = 4
    t.setup(gpio0)
    addrs = t.addrs()
    if (addrs ~= nil) then
    print("Total DS18B20 sensors: "..table.getn(addrs))
    end

    -- read temperature in C 
    print("Temperature: "..t.read().."'C")

    --reading the temp and rounding it to 2 decimal places
    tempReading = round(t.read(),2)
    
    c.send(tempReading)
    

    -- multiple sensors only
    -- Query the second detected sensor, get temperature in Kelvin
    if (table.getn(addrs) >= 2) then
        print("Second sensor: "..t.read(addrs[2],t.K).."'K")
    end

    -- dealocation
    t = nil
    ds18b20 = nil
    package.loaded["ds18b20"]=nil

end


-- time in minutes between updates
time = 1

tmr.alarm(1,time*60000,tmr.ALARM_AUTO,getTempReading)




