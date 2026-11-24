-- >>> resh >>>
local resh_dir = os.getenv("HOME") .. "/Library/Application Support/resh"
dofile(resh_dir .. "/resh.lua")
rex.exec.start({ resh_dir .. "/resh", "service", "start" },
  { detach = true, stdout = false, stderr = false })
-- <<< resh <<<

rex.unbind("cmd+[KeyS]", "resh") -- Unbind default resh shortcut
rex.bind("cmd+[KeyJ]", "resh") -- Open or close the resh picker

-- kitty cmd+ keybinds, ported from the tmux prefix sequences they sent
local TERMINAL = "com.superlogical.terminal"
local SHELL = "com.superlogical.terminal.shell"

local function foreground(ctx)
  local p = rex.block.call(TERMINAL, "process", { block_id = ctx.block_id })
  return p and p.foreground or nil
end

local function is_vim(ctx)
  local fg = foreground(ctx)
  if not fg or not fg.name then
    return false
  end
  local name = (fg.name:gsub("diff$", ""):gsub("^g", ""))
  return name == "view" or name:match("^n?vim?x?$") ~= nil
end

local function pane_cwd(ctx)
  local fg = foreground(ctx)
  return fg and fg.cwd or os.getenv("HOME")
end

-- Escape as CSI-u: a bare \27 followed by a key is read by Neovim as Alt+key.
local ESC = "\27[27u"

local function vim_action(name, title, keys)
  rex.action({
    name = name,
    title = title,
    run = function(ctx)
      if not is_vim(ctx) then
        return
      end
      rex.block.call(TERMINAL, "write", { block_id = ctx.block_id, data = keys })
    end,
  })
end

local REX_CLI = "/Applications/Rex Beta.app/Contents/Helpers/Rex Server.rex/Contents/MacOS/rex"

local function window_action(name, title, program)
  rex.action({
    name = name,
    title = title,
    run = function(ctx)
      local w, err = rex.session.new_window({
        focus = true,
        window_label = program,
        layout = rex.layout.block({
          flavor = SHELL,
          options = { command = { "/opt/homebrew/bin/" .. program }, cwd = pane_cwd(ctx) },
        }),
      })
      if err ~= nil then
        error(err, 0)
      end
      rex.session.focus_block({ block_id = w.block_ids[1] })
      rex.client.queue("session.select", { session_id = ctx.session_id, window_id = w.window_id })
      -- The client may not know the window yet when the queued select runs; retry once it does.
      rex.exec.start({
        "/bin/sh",
        "-c",
        'sleep 0.3; exec "$0" do session.select session_id="$1" window_id="$2"',
        REX_CLI,
        ctx.session_id,
        w.window_id,
      }, { detach = true, stdout = false, stderr = false })
    end,
  })
end

vim_action("nvim_save", "Neovim: Save Current Buffer", ESC .. ESC .. ":w\r")
vim_action("nvim_smart_picker", "Neovim: Smart Picker", ESC .. " ,")
vim_action("nvim_buffer_close", "Neovim: Close Buffer", ESC .. ":bd\r")
vim_action("nvim_buffer_force_close", "Neovim: Close Buffer Without Saving", ESC .. ":bd!\r")

window_action("lazygit_window", "Lazygit in New Window", "lazygit")
window_action("yazi_window", "Yazi in New Window", "yazi")

rex.bind("cmd+shift+r", "client.config.reload")
rex.bind("cmd+s", "nvim_save")
rex.bind("cmd+p", "nvim_smart_picker")
rex.bind("cmd+b", "nvim_buffer_close")
rex.bind("cmd+shift+b", "nvim_buffer_force_close")
rex.bind("cmd+g", "lazygit_window")
rex.bind("cmd+y", "yazi_window")
