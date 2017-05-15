--ngx.say("555555555")
ngx.req.read_body()

local redis = require "resty.redis"
local red = redis.new()
red.connect(red, '192.168.1.62', '6379')

local myIP = ngx.req.get_headers()["X-Real-IP"]
if myIP == nil then
   myIP = ngx.req.get_headers()["x_forwarded_for"]
end
if myIP == nil then
   myIP = ngx.var.remote_addr
end
        
if ngx.re.match(ngx.var.uri,"^(/api/).*$") then
    local method = ngx.var.request_method
    if method == 'POST' then
        local args = ngx.req.get_post_args()
        
        local hasIP = red:sismember('black.ip',myIP)
        local hasIMSI = red:sismember('black.imsi',args.imsi)
        local hasTEL = red:sismember('black.tel',args.tel)
        ngx.say(hasIP)
        if hasIP==1 or hasIMSI==1 or hasTEL==1 then
            ngx.say("This is 'Black List' request")
            ngx.exit(ngx.HTTP_FORBIDDEN)
        end
    else
        ngx.say("This is 'GET' request")
        ngx.exit(ngx.HTTP_FORBIDDEN)
    end
end
