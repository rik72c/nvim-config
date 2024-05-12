
M = {}

local fileType = vim.bo.filetype
local filePath = vim.fn.expand('%:p')

local activeLang = function()
    if(fileType)
end

M.code_reformat = function()
    if fileType == "php" then

end

return M
