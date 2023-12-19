local status, autoclose = pcall(require, "autoclose")
if not status then
    print("Could not find autoclose")
    return
end

autoclose.setup()
