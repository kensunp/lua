--ngx.say("**************")
--ngx.print("333333333")

local redis = require("resty.redis")
local cjson = require("cjson")
local cjson_encode = cjson.encode
local ngx_log = ngx.log
local ngx_ERR = ngx.ERR
local ngx_exit = ngx.exit
local ngx_print = ngx.print
local ngx_re_match = ngx.re.match
local ngx_var = ngx.var

local function close_redis(red)
    if not red then
        return
    end
    --释放链接(连接池实现)
    local pool_max_idle_time = 10000 --毫秒
    local pool_size = 100 --链接池大小
    local ok,err = red:set_keepalive(pool_max_idle_time,pool_size)
    
    if not ok then
        ngx_log(ngx_ERR,"set redis keepalive error:",err)
    end
end

local function read_redis(id)
    local red = redis:new()
    red:set_timeout(4000)
    local ip = "192.168.1.62"
    local port = 6379
    local ok,err = red:connect(ip,port)
    if not ok then
        ngx_log(ngx_ERR,"connect to redis error : ",err)
        return close_redis(red)
    end

    local resp,err = red:get(id)
    if not resp then
        ngx_log(ngx_ERR,"get redis content error :111111111 ",err)
        return close_redis(red)
    end
        --得到的数据为空处理

    if resp == ngx.null then
        resp = nil
    end
    close_redis(red)

    return resp
end

--获取id
local id = ngx_var.id
--ngx_print(id)

--从Redis获取
local content = read_redis(id)

if not content then 
    ngx_log(ngx_ERR,"http not fond content ,id : ",id)
    return ngx_exit(404)
end

local obj=cjson.decode(content)
local cjson_safe = require("cjson.safe") 
--ngx.say(cjson_safe.encode(obj))

--输出内容
--ngx.print("show_ad(")
ngx.print(cjson_safe.encode(obj))
--ngx.print(")")

