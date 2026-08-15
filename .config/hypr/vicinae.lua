-- Vicinae (window management companion / clipboard history).

o.exec_on_start("vicinae server")

-- Use whatever shortcut floats your boat.
o.bind("SUPER + SPACE", "Vicinae toggle", "vicinae toggle")
o.bind("SUPER + CTRL + C", "Vicinae clipboard history", "vicinae vicinae://launch/clipboard/history")

-- Blur.
hl.layer_rule({
  name = "vicinae-blur",
  match = { namespace = "vicinae" },
  blur = true,
  ignore_alpha = 0,
})

-- Disable animation for vicinae only.
hl.layer_rule({
  name = "vicinae-no-animation",
  match = { namespace = "vicinae" },
  no_anim = true,
})
