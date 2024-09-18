local M = {}

local loggr = require("core.loggr")

function M.format_json(json)
    loggr.debug("received string")

    if type(json) ~= "string" then
        loggr.error("Invalid argument: json must be a string")
        return
    end

    -- Create a temporary file to hold the JSON input
    local tmpfile = os.tmpname()
    local outfile = os.tmpname()

    -- Write the JSON input to the temporary file
    local f = io.open(tmpfile, "w")
    if nil == f then
        loggr.error("Failed to open temporary file")
        return
    end

    f:write(json)
    f:close()

    -- return literal string if not json
    local is_json = pcall(vim.fn.json_decode, json)
    if not is_json then
        loggr.debug("Invalid JSON input")
        return json
    end

    -- Run jq to prettify the JSON and write the output to another temporary file
    local cmd = string.format("jq . %s > %s", tmpfile, outfile)
    local success = os.execute(cmd)

    if not success then
        loggr.error("Failed to execute jq command")
        return
    end

    -- Read the prettified JSON from the output file
    local f_out = io.open(outfile, "r")
    if nil == f_out then
        loggr.error("Failed to open output file")
        return
    end

    local prettified_json = f_out:read("*all")
    f_out:close()

    -- Clean up temporary files
    os.remove(tmpfile)
    os.remove(outfile)

    return prettified_json
end


return M
