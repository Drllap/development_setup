local M = {}

local API_key_avalible = function()
  return false
end

M.check = function()
  vim.health.report_start("ChatGPT plugin")

  if API_key_avalible() then
    vim.health.report_ok("OPENAI_API_KEY defined")
  else
    vim.health.report_error("No OPENAI_API_KEY key defined")
  end

end
return M
