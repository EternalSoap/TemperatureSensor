--setting up and connecting to wifi network


ssid = "B.net_99598"
pass = "5665isus22"

wifi.setmode(wifi.STATION)



--wifi.sta.config(ssid,pass)
--wifi.sta.connect()
print("test")

tmr.alarm(0,1000,tmr.ALARM_AUTO,function() 
    if wifi.sta.getip() == nil then
        print ("IP Unavailable")
        else
        tmr.stop(0)
        tmr.unregister(0)
        print("Connected")
        dofile("getTemps.lua")
        end
        end)

    
