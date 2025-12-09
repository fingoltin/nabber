local palette = require "display.palette"
local Drawable = prism.components.Drawable
local default = Drawable { index = 1, background = palette[17] }

--- @class PipeAutoTile : AutoTile
local PipeAutoTile = prism.components.AutoTile:extend("PipeAutoTile")

PipeAutoTile.id = 9
PipeAutoTile.default = default

PipeAutoTile.drawables = {
   ["top"] = default,
   ["top-left"] = Drawable { index = 130, color = palette[17], background = palette[5] },
   ["bottom-left"] = Drawable { index = 146, color = palette[17], background = palette[5] },
   ["bottom-right"] = Drawable { index = 147, color = palette[17], background = palette[5] },
   ["top-right"] = Drawable { index = 131, color = palette[17], background = palette[5] },
   ["single"] = Drawable { index = 304, color = palette[17], background = palette[5] },
   ["bottom"] = Drawable { index = 239, color = palette[17], background = palette[6] },
   ["middle"] = Drawable { index = 159, color = palette[6], background = palette[17] },
   ["wall"] = Drawable { index = 1, background = palette[25] },
}

-- stylua: ignore start
PipeAutoTile.rules = {
  {
    drawable = "wall",
    pattern = {
      0, 0, 0,
      4, 3, 4,
      0, 0, 0,
    }
  },
  {
    drawable = "middle",
    pattern = {
      0, 2, 0,
      0, 3, 2,
      0, 2, 0
    },
    mirrorX = true
  },
  {
    drawable = "middle",
    pattern = {
      0, 2, 0,
      2, 3, 2,
      0, 0, 0
    },
    mirrorY = true
  },
  {
    drawable = "middle",
    pattern = {
      0, 0, 0,
      0, 3, 0,
      4, 2, 4
    }
  },
  {
    drawable = "middle",
    pattern = {
      0, 2, 0,
      2, 3, 2,
      0, 2, 0
    }
  },
  {
    drawable = "single",
    pattern = {
      0, 1, 0,
      1, 3, 1,
      0, 1, 0
    }
  },
  {
    drawable = "top-left",
    pattern = {
      0, 1, 0,
      1, 3, 2,
      0, 2, 0
    }
  },
  {
    drawable = "bottom-right",
    pattern = {
      0, 2, 0,
      2, 3, 1,
      0, 1, 0
    }
  },
  {
    drawable = "top-right",
    pattern = {
      0, 1, 0,
      2, 3, 1,
      0, 2, 0
    }
  },
  {
    drawable = "top",
    pattern = {
      0, 1, 0,
      0, 3, 0,
      0, 0, 0
    }
  },
  {
    drawable = "bottom-left",
    pattern = {
      0, 2, 0,
      1, 3, 2,
      0, 1, 0
    }
  },
  {
    drawable = "top",
    pattern = {
      0, 0, 0,
      0, 3, 0,
      0, 1, 0
    }
  },
  {
    drawable = "top-right",
    pattern = {
      0, 1, 0,
      2, 3, 1,
      0, 2, 0
    }
  },
  {
    drawable = "top",
    pattern = {
      0, 0, 0,
      0, 3, 0,
      0, 2, 0
    }
  },
  {
    drawable = "top",
    pattern = {
      0, 2, 0,
      0, 3, 0,
      0, 0, 0
    }
  },
}
-- stylua: ignore end

return PipeAutoTile
