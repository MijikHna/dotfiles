-- wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder() -- create config object with default values

local function recompute_padding(window, pane)
  local window_dims = window:get_dimensions()
  local current_config = window:effective_config()
  local overrides = window:get_config_overrides()
  local pane_dims = pane:get_dimensions()

  if not current_config.window_padding then
    return
  end

  -- font_size is in points, 96dpi <-> font_size * 1.333333 = font_size in pixels
  local font_line_height = pane_dims.pixel_height / (pane_dims.viewport_rows - 1)
  local gap = window_dims.pixel_height % font_line_height
  local y_padding = gap / 2
  local new_padding = {
    right = 0,
    left = 0,
    top = math.floor(y_padding),
    bottom = gap - y_padding,
  }

  if overrides and overrides.window_padding and new_padding.left == overrides.window_padding.top then
    return -- padding is same, avoid triggering further changes
  end

  if not overrides then
    overrides = { window_padding = nil }
  end

  overrides.window_padding = new_padding
  window:set_config_overrides(overrides)
end

-- General
config.automatically_reload_config = true -- reload config when it changes

-- Appearance
config.font = wezterm.font_with_fallback({
  -- {
  --   family = "CaskaydiaCove Nerd Font Mono",
  --   weight = "Regular",
  --   harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  -- },
  {
    family = "FiraCode Nerd Font Mono",
    weight = "Regular",
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  },
  -- {
  --   family = "M+1 Code Nerd Font Mono",
  --   weight = "Regular",
  --   harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  -- },
  -- {
  --   family = "RecMonoCasual Nerd Font",
  --   weight = "Regular",
  --   harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
  -- },
})

-- config.window_background_image = os.getenv("HOME") .. "/.dotfiles/term-backgrounds/dec/AOA3-scaled.png"
-- config.window_background_image_hsb = { brightness = 0.88 }
-- config.window_background_image = os.getenv("HOME") .. "/.dotfiles/term-backgrounds/dec/AOA6.png"
-- config.window_background_image_hsb = { brightness = 0.36 }
-- config.window_background_image = os.getenv("HOME") .. "/.dotfiles/term-backgrounds/dec/BESTie.png"
-- config.window_background_image_hsb = { brightness = 0.50 }
-- config.window_background_image = os.getenv("HOME") .. "/.dotfiles/term-backgrounds/dec/red-velvet1.jpg"
-- config.window_background_image_hsb = { brightness = 0.027 }
config.window_background_image = os.getenv("HOME") .. "/.dotfiles/term-backgrounds/dec/red-velvet2.jpg"
config.window_background_image_hsb = { brightness = 0.036 }
-- config.window_background_image = os.getenv("HOME") .. "/.dotfiles/term-backgrounds/dec/sunmi1.png"
-- config.window_background_image_hsb = { brightness = 0.31 }
-- config.window_background_image = os.getenv("HOME") .. "/.dotfiles/term-backgrounds/dec/sunmi2.png"
-- config.window_background_image_hsb = { brightness = 0.32 }
-- config.window_background_image = os.getenv("HOME") .. "/Pictures/Wallpapers/Rescene/RESCENE-1.jpeg"
-- config.window_background_image_hsb = { brightness = 0.016 }
-- config.window_background_image = os.getenv("HOME") .. "/Pictures/Wallpapers/Rescene/RESCENE-2-darken.png"
-- config.window_background_image_hsb = { brightness = 0.36 }
-- config.window_background_image = os.getenv("HOME") .. "/Pictures/Wallpapers/4 minute/4minute-2_16-9.png"
-- config.window_background_image_hsb = { brightness = 0.38 }
-- config.window_background_image = os.getenv("HOME") .. "/Pictures/Wallpapers/4 minute/4minute-2_16-10.png"
-- config.window_background_image_hsb = { brightness = 0.38 }

-- # initial padding otherwise resizing doesn't work properly (Who knows why?)
config.window_padding = {
  left = 0,
  right = 0,
}

config.font_size = 10

config.hide_tab_bar_if_only_one_tab = true

config.window_decorations = "TITLE | RESIZE"

config.max_fps = 120
config.animation_fps = 120

-- Key bindings
config.keys = {
  {
    key = "F11",
    action = wezterm.action.ToggleFullScreen,
  },
  { key = "h", mods = "ALT", action = wezterm.action({ SendKey = { key = "h", mods = "ALT" } }) },
  { key = "j", mods = "ALT", action = wezterm.action({ SendKey = { key = "j", mods = "ALT" } }) },
  { key = "k", mods = "ALT", action = wezterm.action({ SendKey = { key = "k", mods = "ALT" } }) },
  { key = "l", mods = "ALT", action = wezterm.action({ SendKey = { key = "l", mods = "ALT" } }) },
}

config.colors = { cursor_bg = "#c4c4c6" }

config.force_reverse_video_cursor = false -- cursor color

wezterm.on("window-resized", function (window, pane)
  recompute_padding(window, pane)
end)

wezterm.on("window-config-reloaded", function (window, pane)
  recompute_padding(window, pane)
end)

return config
