local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Enable the native IME on both macOS and Linux.
config.use_ime = true

-- Linux-only input settings. macOS uses its native input method.
if wezterm.target_triple:find("linux") then
  config.enable_wayland = true
  config.xim_im_name = "ibus"
end

-- =========================================================
-- Theme
-- =========================================================
config.color_scheme = "rose-pine-moon"

-- =========================================================
-- Font
-- =========================================================
config.font = wezterm.font_with_fallback({
  {
    family = "JetBrainsMono Nerd Font Mono",
    weight = "Medium",
  },
  "Noto Sans Mono CJK KR",
  "Noto Sans Mono CJK JP",
  "Noto Color Emoji",
})

config.font_size = 13.0
config.line_height = 1.30

-- =========================================================
-- Window
-- =========================================================
config.initial_cols = 120
config.initial_rows = 32

config.window_padding = {
  left = 15,
  right = 15,
  top = 13,
  bottom = 13,
}

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.adjust_window_size_when_changing_font_size = false
config.enable_scroll_bar = false

config.window_background_opacity = 1.0
config.text_background_opacity = 1.0

-- =========================================================
-- Rosé Pine gradient
-- =========================================================
config.window_background_gradient = {
  orientation = {
    Linear = {
      angle = -35.0,
    },
  },

  colors = {
    "#38363f",
    "#33323a",
    "#2e3037",
    "#292c33",
    "#24282f",
    "#20242b",
  },

  interpolation = "CatmullRom",
  blend = "Oklab",
  noise = 64,
}

-- =========================================================
-- Compact tab bar
-- =========================================================
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false

-- fancy 탭바 대신 작고 직선적인 retro 탭바 사용
config.use_fancy_tab_bar = false

config.tab_bar_at_bottom = false
config.show_tab_index_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = true

-- 긴 폴더명으로 탭이 지나치게 커지는 것을 방지
config.tab_max_width = 24

config.colors = {
  tab_bar = {
    -- 탭바 전체 배경
    background = "#181b20",

    -- format-tab-title에서 실제 활성 탭 색을 다시 지정함
    active_tab = {
      bg_color = "#a9b39f",
      fg_color = "#181b20",
      intensity = "Bold",
    },

    inactive_tab = {
      bg_color = "#24282f",
      fg_color = "#8f929a",
    },

    inactive_tab_hover = {
      bg_color = "#31353c",
      fg_color = "#e0def4",
    },

    new_tab = {
      bg_color = "#181b20",
      fg_color = "#a9b39f",
    },

    new_tab_hover = {
      bg_color = "#31353c",
      fg_color = "#e0def4",
    },
  },
}

-- =========================================================
-- Compact tab title
-- 홈에서는 "~", 폴더에서는 마지막 폴더명만 표시
-- 예: "1: projects"
-- =========================================================
local function get_tab_directory(tab)
  local cwd = tab.active_pane.current_working_dir

  if not cwd then
    return "terminal"
  end

  local path = cwd.file_path or tostring(cwd)
  path = path:gsub("/$", "")

  if path == wezterm.home_dir then
    return "~"
  end

  return path:match("([^/]+)$") or "~"
end

wezterm.on("format-tab-title", function(tab)
  local index = tab.tab_index + 1
  local directory = get_tab_directory(tab)
  local title = index .. ": " .. directory

  local bg
  local fg

  if tab.is_active then
    bg = "#a9b39f"
    fg = "#181b20"
  else
    bg = "#24282f"
    fg = "#8f929a"
  end

  local result = {
    {
      Background = {
        Color = bg,
      },
    },
    {
      Foreground = {
        Color = fg,
      },
    },
  }

  if tab.is_active then
    table.insert(result, {
      Attribute = {
        Intensity = "Bold",
      },
    })
  end

  -- 탭 내부 좌우 여백만 유지
  -- 탭과 탭 사이의 외부 공백은 제거
  table.insert(result, {
    Text = "  " .. title .. "  ",
  })

  return result
end)

-- =========================================================
-- Integrated window buttons
-- =========================================================
config.integrated_title_buttons = {
  "Hide",
  "Maximize",
  "Close",
}

config.integrated_title_button_alignment = "Right"
config.integrated_title_button_style = "Windows"
config.integrated_title_button_color = "Auto"

config.window_frame = {
  active_titlebar_bg = "#181b20",
  inactive_titlebar_bg = "#181b20",

  active_titlebar_fg = "#e0def4",
  inactive_titlebar_fg = "#8f929a",

  active_titlebar_border_bottom = "#181b20",
  inactive_titlebar_border_bottom = "#181b20",

  button_fg = "#e0def4",
  button_bg = "#181b20",

  button_hover_fg = "#181b20",
  button_hover_bg = "#a9b39f",
}

-- =========================================================
-- Cursor
-- =========================================================
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 600

-- =========================================================
-- General
-- =========================================================
config.scrollback_lines = 10000
config.audible_bell = "Disabled"
config.check_for_updates = false
config.window_close_confirmation = "NeverPrompt"

-- =========================================================
-- Key bindings
-- =========================================================
config.keys = {
  {
    key = "C",
    mods = "CTRL|SHIFT",
    action = wezterm.action.CopyTo("Clipboard"),
  },
  {
    key = "V",
    mods = "CTRL|SHIFT",
    action = wezterm.action.PasteFrom("Clipboard"),
  },
  {
    key = "T",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "W",
    mods = "CTRL|SHIFT",
    action = wezterm.action.CloseCurrentTab({
      confirm = true,
    }),
  },
  {
    key = "+",
    mods = "CTRL",
    action = wezterm.action.IncreaseFontSize,
  },
  {
    key = "-",
    mods = "CTRL",
    action = wezterm.action.DecreaseFontSize,
  },
  {
    key = "0",
    mods = "CTRL",
    action = wezterm.action.ResetFontSize,
  },
}

return config
