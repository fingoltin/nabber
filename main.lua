require "debugger"
require "prism"

prism.loadModule("prism/spectrum")
prism.loadModule("prism/extra/sight")
prism.loadModule("prism/extra/inventory")
prism.loadModule("modules/autotile")
prism.loadModule("modules/nabber")

love.graphics.setBackgroundColor(require("display.palette")[17]:decompose())
love.graphics.setDefaultFilter("nearest", "nearest")
love.keyboard.setKeyRepeat(true)

local utf8 = require "utf8"
print(utf8.codepoint("⇒"))

prism.logger.setOptions({ level = "trace" })

-- Grab our level state and sprite atlas.
local GameLevelState = require "gamestates.gamelevelstate"

-- Load a sprite atlas and configure the terminal-style display,
local spriteAtlas = spectrum.SpriteAtlas.fromASCIIGrid("display/tileset.png", 8, 8)
local display = spectrum.Display(35, 20, spriteAtlas, prism.Vector2(8, 8))
local overlay = spectrum.Display(81, 60, spriteAtlas, prism.Vector2(8, 8))

-- spin up our state machine
--- @type GameStateManager
local manager = spectrum.StateManager()

-- we put out levelstate on top here, but you could create a main menu
--- @diagnostic disable-next-line
function love.load()
   manager:push(GameLevelState(display, overlay))
   manager:hook()
end
