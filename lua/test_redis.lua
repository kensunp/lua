local redis = require "resty.redis"
local red = redis:new()

red:set_timeout(1000) --1 sec

local ok,err = red:connect("192.168.1.63",6379)
if not ok then
    ngx.say("failed to connect:",err)
    return
end

local res,err = red:get("dog")
if not res then
    ngx.say("failed to get dog:",err)
    return
end

if res == ngx.null then
    ngx.say("dog not found.")
    return
end

ngx.say("dog:",res)
red:init_pipeline()
red:set("cat","Marry")
red:set("horse","Bob")
red:get("cat")
red:get("horse")
local results,err = red:commit_pipeline()
if not results then
    ngx.say("failed to commit the pipeline requests:",err)
    return
end

for i,res in ipairs(results) do
    if type(res) == "table" then
        if res[1] == false then
            ngx.say("failed to run command",i,":",res[2])
        else
            --process the table value
        end
    else
        --process the table value
    end
end

local ok,err = red:set_keepalive(10000,100)
if not ok then
    ngx.say("failed to set keepalive:",err)
    return
end
