local palette = require "display.palette"
local Drawable = prism.components.Drawable
local default = Drawable(1, nil, palette[17])

--- @class PipeAutoTile : AutoTile
local PipeAutoTile = prism.components.AutoTile:extend("PipeAutoTile")

PipeAutoTile.id = 6
PipeAutoTile.default = default

PipeAutoTile.drawables = {
   ["top"] = default,
   ["top-left"] = Drawable(130, palette[17], palette[5]),
   ["bottom-left"] = Drawable(146, palette[17], palette[5]),
   ["bottom-right"] = Drawable(147, palette[17], palette[5]),
   ["top-right"] = Drawable(131, palette[17], palette[5]),
   ["single"] = Drawable(304, palette[17], palette[5]),
   ["bottom"] = Drawable(239, palette[17], palette[6]),
   ["middle"] = Drawable(159, palette[6], palette[17]),
   ["wall"] = Drawable(1, nil, palette[25]),
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
