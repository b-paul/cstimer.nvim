local api = vim.api

local buffer, window, mid, time = 0, lines, spaces

local function draw_timer(time)
    local centiseconds = time % 100
    local seconds = math.floor(time/100)%60
    local minutes = math.floor(time/6000)

    spaces = ' '

    for i=0,math.floor(vim.o.columns/2) do
        spaces = spaces .. ' '
    end

    if (minutes == 0) then
        lines = {spaces .. seconds .. '.' .. centiseconds}
    else
        lines = {spaces .. minutes .. ':' .. seconds .. '.' .. centiseconds}
    end

    api.nvim_buf_set_lines(buffer, mid, mid, false, lines)
end

local function init()

    buffer = api.nvim_create_buf(false, true)
    api.nvim_buf_set_name(buffer, "Cstimer")

    mid = math.floor(vim.o.lines/2)

    window = api.nvim_open_win(buffer, false, {
        relative = "editor", style = "minimal", focusable=false,
        row = 0, col = 0,
        width = vim.o.columns, height = vim.o.lines-2
    })

    api.nvim_win_set_option(window, 'winhl', 'Normal:Normal')

    for i=0,vim.o.lines-2 do
        api.nvim_buf_set_lines(buffer, 0, 0, false, {''})
    end

    draw_timer(0)
end

return {
    init = init
}
