local M = {}

-- todo: factory implmentation for previewr, we're using float for now
local previewr = require('core.previewr.float')

function M.preview_text(text, opts)
  previewr.preview_text(text, opts)
end

return M
