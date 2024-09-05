local M = {}

local API_key_avalible = function()
  return nil ~= os.getenv("OPENAI_API_KEY")
end

M.check = function()
  vim.health.start("ChatGPT plugin")

  if API_key_avalible() then
    vim.health.ok("OPENAI_API_KEY defined")
  else
    vim.health.error("No OPENAI_API_KEY key defined")
  end

end
return M
