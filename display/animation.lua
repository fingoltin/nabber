local anim8 = {
   _VERSION = "anim8 v2.3.1",
   _DESCRIPTION = "An animation library for LÖVE",
   _URL = "https://github.com/kikito/anim8",
   _LICENSE = [[
    MIT LICENSE

    Copyright (c) 2011 Enrique García Cota

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  ]],
}

---@class Grid
---@field frameWidth integer
---@field frameHeight integer
---@field imageHeight integer
---@field imageWidth integer
---@field left number
---@field top number
---@field border number
---@field width integer
---@field height integer
---@field _key integer
---
---@field getFrames fun(self: Grid, ...:number|string): love.Quad

---@type Grid
---@diagnostic disable-next-line: missing-fields
local Grid = {}

---@type love.Quad[]
local _frames = {}

---@param value any
---@param name any
local function assertPositiveInteger(value, name)
   if type(value) ~= "number" then
      error(("%s should be a number, was %q"):format(name, tostring(value)))
   end
   if value < 1 then error(("%s should be a positive number, was %d"):format(name, value)) end
   if value ~= math.floor(value) then
      error(("%s should be an integer, was %f"):format(name, value))
   end
end

---@param self Grid
---@param x number
---@param y number
---@return love.Quad
local function createFrame(self, x, y)
   local fw, fh = self.frameWidth, self.frameHeight
   return love.graphics.newQuad(
      self.left + (x - 1) * fw + x * self.border,
      self.top + (y - 1) * fh + y * self.border,
      fw,
      fh,
      self.imageWidth,
      self.imageHeight
   )
end

---@vararg any
---@return string
local function getGridKey(...)
   return table.concat({ ... }, "-")
end

---@param self Grid
---@param x number
---@param y number
---@return love.Quad
local function getOrCreateFrame(self, x, y)
   if x < 1 or x > self.width or y < 1 or y > self.height then
      error(("There is no frame for x=%d, y=%d"):format(x, y))
   end
   local key = self._key
   _frames[key] = _frames[key] or {}
   _frames[key][x] = _frames[key][x] or {}
   _frames[key][x][y] = _frames[key][x][y] or createFrame(self, x, y)
   return _frames[key][x][y]
end

---@param ... number|string
---@return love.Quad[]
function Grid:getFrames(...)
   local result, args = {}, { ... }
   local minx, maxx, stepx, miny, maxy, stepy

   for i = 1, #args, 2 do
      minx, maxx, stepx = parseInterval(args[i])
      miny, maxy, stepy = parseInterval(args[i + 1])
      for y = miny, maxy, stepy do
         for x = minx, maxx, stepx do
            result[#result + 1] = getOrCreateFrame(self, x, y)
         end
      end
   end

   return result
end

local Gridmt = {
   __index = Grid,
   __call = Grid.getFrames,
}

---@param frameWidth integer
---@param frameHeight integer
---@param imageWidth integer
---@param imageHeight integer
---@param left? number
---@param top? number
---@param border? number
---@return Grid
local function newGrid(frameWidth, frameHeight, imageWidth, imageHeight, left, top, border)
   assertPositiveInteger(frameWidth, "frameWidth")
   assertPositiveInteger(frameHeight, "frameHeight")
   assertPositiveInteger(imageWidth, "imageWidth")
   assertPositiveInteger(imageHeight, "imageHeight")

   left = left or 0
   top = top or 0
   border = border or 0

   local key = getGridKey(frameWidth, frameHeight, imageWidth, imageHeight, left, top, border)

   ---@type Grid
   local grid = setmetatable({
      frameWidth = frameWidth,
      frameHeight = frameHeight,
      imageWidth = imageWidth,
      imageHeight = imageHeight,
      left = left,
      top = top,
      border = border,
      width = math.floor(imageWidth / frameWidth),
      height = math.floor(imageHeight / frameHeight),
      _key = key,
   }, Gridmt)
   return grid
end

-----------------------------------------------------------

-----------------------------------------------------------

anim8.newGrid = newGrid
anim8.newAnimation = newAnimation

return anim8
