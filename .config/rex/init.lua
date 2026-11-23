-- >>> resh >>>
local resh_dir = os.getenv("HOME") .. "/Library/Application Support/resh"
dofile(resh_dir .. "/resh.lua")
rex.exec.start({ resh_dir .. "/resh", "service", "start" },
  { detach = true, stdout = false, stderr = false })
-- <<< resh <<<
