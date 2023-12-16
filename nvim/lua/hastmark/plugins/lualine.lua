local status, lualine = pcall(require, "lualine")
if not status then
  print("Could not find lualine")
  return
end

lualine.setup()
