-- >>> rex-open: a picker for the files, folders, links, commands and SQL in a pane's output.
require("rex_open").setup({
  -- Alt+Cmd+O opens a picker: the focused pane's directory, then the files,
  -- folders, links, commands and SQL in its output. Enter opens to the right,
  -- Ctrl-T in a new tab, Ctrl-D below, and Ctrl-Y copies.
  picker = {
    -- A key, a list of keys, or false to leave it unbound.
    key = "cmd+[KeyO]",
    -- float: a popup over the window, and Enter opens to the right.
    -- right, left, down, up or tab: the picker opens there, and so does Enter.
    open = "float",
    -- How a file opens. By default: in $VISUAL or $EDITOR at the line, or
    -- read-only vim when neither is set. To choose, set view: $1 is the file
    -- and $2 the line. Others: 'nvim -R "+${2:-1}" -- "$1"', 'hx "$1:${2:-1}"'.
    -- view = 'vim -R "+${2:-1}" -- "$1"',
    view = 'nvim "+${2:-1}" -- "$1"',
  },
})
-- <<< rex-open

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

local REX_CLI = "/Applications/Rex.app/Contents/Helpers/Rex Server.rex/Contents/MacOS/rex"

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

-- Lists the existing sessions, then the zoxide directories under $HOME that
-- have no session of the same name. Picking a session switches to it; picking
-- a directory opens it as a session named after its last path segment.
-- $0 is the Rex CLI. List rows are display, kind, id or directory, label.
local SESSIONIZE = [=[
export PATH="/opt/homebrew/bin:$PATH"
rex=$0
fail() { printf '%s\n' "$1"; sleep 2; exit 1; }
sessions=$("$rex" session ls --json | awk -F'"' '
  {
    for (i = 1; i < NF; i++) {
      if ($i == "session_id") id = $(i + 2)
      if ($i == "label") print id "\t" $(i + 2)
    }
  }')
pick=$({
  printf '%s\n' "$sessions" | awk -F'\t' 'NF { printf "\033[32m%s\033[0m  \033[2msession\033[0m\tsession\t%s\t%s\n", $2, $1, $2 }'
  zoxide query -l --base-dir "$HOME" | S="$sessions" awk '
    BEGIN {
      n = split(ENVIRON["S"], rows, "\n")
      for (i = 1; i <= n; i++) { split(rows[i], f, "\t"); if (f[2] != "") have[f[2]] = 1 }
    }
    { name = $0; sub(".*/", "", name); if (!(name in have)) printf "%s\tdir\t%s\t%s\n", $0, $0, name }'
} | fzf --ansi --reverse --no-sort --scheme=path --delimiter='\t' --with-nth=1 --prompt='session> ')
[ -n "$pick" ] || exit 0
kind=$(printf '%s' "$pick" | cut -f2)
target=$(printf '%s' "$pick" | cut -f3)
name=$(printf '%s' "$pick" | cut -f4)
if [ "$kind" = session ]; then
  id=$target
else
  id=$("$rex" session new "$name" -c "$target" --json -- /opt/homebrew/bin/fish -l -i | tr -d ' \n' | sed -n 's/.*"session_id":"\([^"]*\)".*/\1/p')
fi
[ -n "$id" ] || fail "Couldn't create session $name"
i=0
while [ $i -lt 20 ]; do
  "$rex" do session.select session_id="$id" >/dev/null 2>&1 && exit 0
  sleep 0.1
  i=$((i + 1))
done
fail "Couldn't open session $name"
]=]

rex.action({
  name = "zoxide_session",
  title = "New Session from Zoxide Directory",
  run = function()
    local view, err = rex.session.view({})
    if not view then error(err, 0) end
    local r
    r, err = rex.session.new_layer({
      window_id = view.active_window_id,
      bounds = { 0.2, 0.15, 0.6, 0.55 },
      focus = true,
      layout = rex.layout.block({
        flavor = SHELL,
        options = { command = { "/bin/sh", "-c", SESSIONIZE, REX_CLI }, cwd = os.getenv("HOME") },
      }),
    })
    if not r then error(err, 0) end
  end,
})

rex.bind("cmd+shift+r", "client.config.reload")
rex.bind("cmd+s", "nvim_save")
rex.bind("cmd+p", "nvim_smart_picker")
rex.bind("cmd+b", "nvim_buffer_close")
rex.bind("cmd+shift+b", "nvim_buffer_force_close")
rex.bind("cmd+g", "lazygit_window")
rex.bind("cmd+y", "yazi_window")
rex.bind("cmd+shift+j", "zoxide_session")
