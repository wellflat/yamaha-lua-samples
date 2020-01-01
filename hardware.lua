local function alert_cpu_usage(threshold)
    local cpu, cpuerr = rt.hw.open('cpu1')
    if cpu then
        local load = cpu:read()
        cpu:close()
        local msg = 'warning cpu usage: ' .. load.load_1m
        if load.load_1m > threshold then
            print(msg)
            rt.syslog('info', msg)
            local led, lederr = rt.hw.open('status-led1')
            if led then
                local bz, bzerr = rt.hw.open('buzzer1')
                if bz then
                    bz:tone('B2')
                    rt.sleep(1)
                    bz:tone('E3')
                    rt.sleep(1)
                    bz:tone('B3')
                    rt.sleep(1)
                    bz:tone('B4')
                    rt.sleep(1)
                    bz:off()
                    bz:close()
                else
                    print(bzerr)
                end
                led:on()
                rt.sleep(10)
                led:off()
                led:close()
            else
                print(lederr)
            end
        end
    else
        print(cpuerr)
    end
end

-- main
alert_cpu_usage(30)