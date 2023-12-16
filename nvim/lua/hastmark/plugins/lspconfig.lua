local status, lspconfig = pcall(require, "lspconfig")
if not status then
  print("Could not find lspconfig")
  return
end

lspconfig.clangd.setup{}
