local loggr = {
    debug = function(...)
        local log_from_file = debug.getinfo(2, 'S').source
        print('debug:', log_from_file, ...)
    end,
    error = function(...)
        local log_from_file = debug.getinfo(2, 'S').source
        print('error:', log_from_file, ...)
    end,
}

return loggr
