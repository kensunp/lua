local function urlDecode(s)  
    s = string.gsub(s, '%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)  
    return s  
end  

local function urlEncode(s)  
     s = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)  
    return string.gsub(s, " ", "+")  
end

function string.split(str, delimiter)
    if str==nil or str=='' or delimiter==nil then
        return nil
    end
    
    local result = {}
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

function string_split(str, split_char)
    local sub_str_tab = {};
    while (true) do
        local pos = string.find(str, split_char);
        if (not pos) then
            sub_str_tab[#sub_str_tab + 1] = str;
            break;
        end
        local sub_str = string.sub(str, 1, pos - 1);
        sub_str_tab[#sub_str_tab + 1] = sub_str;
        str = string.sub(str, pos + 1, #str);
    end
 
    return sub_str_tab;
end

local uri = ngx.var.uri
local tburi = string_split(uri,"/")

--[[
local str = "你有新的消息，【验证码】为：123456，本验证码30分钟内有效，编号：90"
local str_Arr = string_split(str, "，")
ngx.say(#str_Arr)
for i = 1, #str_Arr do
    ngx.say(str_Arr[i])
end
 
local str_lenght = #str_Arr[2]
local code = string.sub(str_Arr[2], str_lenght-5, str_lenght)
 
ngx.say("验证码："..code)

--]]
--
for key,value in pairs(tburi) do
    
    ngx.say(key,value)
 end

--ngx.say(tburi)

ngx.say(table.getn(tburi),"<br/>")
ngx.say(tburi[1],"<br/>")
ngx.say(tburi[2],"<br/>")
ngx.say(tburi[3],"<br/>")
ngx.say(tburi[4],"<br/>")
ngx.say(tburi[5],"<br/>")
ngx.say(tburi[6],"<br/>")


