local function request(params)
    local res = rt.httprequest(params)
    if res.rtn1 == true and res.code == 200 then
        print(res.header)
        print(res.body)
    else
        print(res.err)
    end
end

-- main
local params = {
    url = "http://www.rtpro.yamaha.co.jp/RT/docs/lua/tutorial/index.html",
    method = "GET"
}
request(params)