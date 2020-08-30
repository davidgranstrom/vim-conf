--- Randomness utilities.
-- @module random
-- @author David Granström
-- @license GPLv3

local M = {}
local api = vim.api
local float_formatter = "%.4f"

-- seed the random number generator on nvim startup
math.randomseed(os.time())

local function frand(min, max)
  min = min or 0
  max = max or 1
  return math.random() * (max - min) + min
end

local function irand(min, max)
  min = min or 0
  max = max or 1
  return math.random(min, max)
end

local function array(size, min, max, f)
  size = size or 1
  local arr = {}
  for i = 1, size do
    table.insert(arr, f(min, max))
  end
  return arr
end

local function float_array(size, min, max)
  return array(size, min, max, frand)
end

local function int_array(size, min, max)
  return array(size, min, max, irand)
end

-- API

--- A random floating point number.
-- @param min The minimum value.
-- @param max The maximum value.
-- @see float_formatter for floating point precision.
function M.float(min, max)
  return string.format(float_formatter, frand(min, max))
end

--- A random integer number.
-- @param min The minimum value.
-- @param max The maximum value.
function M.int(min, max)
  return tostring(irand(min, max))
end

--- An array of random floats.
-- @param size The size fo the array.
-- @param min The minimum value.
-- @param max The maximum value.
-- @see float_formatter for floating point precision.
function M.float_array(size, min, max)
  local data = float_array(size, min, max)
  local str = '['
  for i,v in ipairs(data) do
    str = str .. string.format(float_formatter, v)
    if i < #data then
      str = str .. ', '
    end
  end
  return str .. ']'
end

--- An array of integers.
-- @param size The size fo the array.
-- @param min The minimum value.
-- @param max The maximum value.
function M.int_array(size, min, max)
  local data = int_array(size, min, max)
  local str = '['
  for i,v in ipairs(data) do
    str = str .. v
    if i < #data then
      str = str .. ', '
    end
  end
  return str .. ']'
end

return M
