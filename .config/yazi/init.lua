local handle = io.popen("uname -s")
local osname = handle and handle:read("*l")
if handle then
  handle:close()
end
if osname ~= "Darwin" then
  require("sshfs"):setup()
end