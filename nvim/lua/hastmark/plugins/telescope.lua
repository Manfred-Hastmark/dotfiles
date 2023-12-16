local status, telescope = pcall(require, "telescope")
if not status then
  print("Could not find telescope")
  return
end

telescope.setup()
