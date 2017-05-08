if ngx.var.remote_addr == "192.168.1.7" then
    ngx.exit(ngx.HTTP_FORBIDDEN)
end

if ngx.var.remote_addr == "192.168.1.208" then
    ngx.exec("@zl")
end
