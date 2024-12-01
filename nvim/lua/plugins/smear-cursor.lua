return {
  "sphamba/smear-cursor.nvim",

  opts = {
    -- Smear cursor when switching buffers or windows.
    smear_between_buffers = true,

    -- Smear cursor when moving within line or to neighbor lines.
    smear_between_neighbor_lines = false,

    -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
    -- Smears will blend better on all backgrounds.
    legacy_computing_symbols_support = true,

    stiffness = 0.8,
    trailing_stiffness = 0.6,
    trailing_exponent = 0,
    distance_stop_animating = 0.5,
    hide_target_hack = false,
  },
}
