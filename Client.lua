--create client

local modname = ...
local M = {}
_G[modname] = M

local net = net
local node = node
local print = print
local gpio = gpio
local type = type
setfenv(1,M)



port = 8082;
server = "homeser.noip.me"
pin = 5
gpio.mode(pin,gpio.OUTPUT)
gpio.write(pin,gpio.LOW)

function heating(value)
    
    if (value == "1\n") then
        print("testing 1")
        gpio.write(pin,gpio.HIGH)
    else
        print("testing 0")
        gpio.write(pin,gpio.LOW)
    end
end
    

function send(temp)
    conn = net.createConnection(net.TCP, 0)
    conn:connect(port,server)
    conn:on("receive",function(sck,c) heating(c) end)
    conn:on("connection",function(sck,c)
        conn:send(temp..":"..node.chipid().."\r\n")end)
    
    conn:close()

 
end

return M
