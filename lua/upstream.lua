--ngx.say("************888","<br/>")
--ngx.say(remoteip)
--
local remoteip=ngx.var.remote_addr

--ngx.say(remoteip)
if remoteip == "192.168.1.201" then
    ngx.exec("@nginx")
else
    ngx.exec("@zxx")
end
