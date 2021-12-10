function build_array(...)
  local arr = {}
  for v in ... do
    arr[#arr + 1] = v
  end
  return arr
end

table.filter = function(t, filterIter)
  local out = {}

  for k, v in pairs(t) do
    if filterIter(v, k, t) then out[#out+1] = v end
  end

  return out
end

local input = io.open("input.txt", "r")

local codes = build_array(input:lines())

function get_rating(type)
  local remaining = codes
  local line_length = #remaining[1] - 1

  for i=1, line_length do
    local one_count = {}
    local zero_count = {}
    for _, code in ipairs(remaining) do
      local bin = code:sub(i, i)
      if bin == "1" then one_count[i] = (one_count[i] or 0) + 1
      elseif bin == "0"  then zero_count[i] = (zero_count[i] or 0) + 1
      end
    end
    one_count[i] = one_count[i] or 0
    zero_count[i] = zero_count[i] or 0
    local b = one_count[i] >= zero_count[i] and "1" or "0"
    b = type == "oxygen" and b or (b == "1" and "0" or "1")
    remaining = table.filter(remaining, function(c) return c:sub(i, i) == b end)
    if #remaining == 1 then 
      return tonumber(remaining[1], 2)
    end
  end
end

local oxygen_rating = get_rating("oxygen")
local co2_scrubber_rating = get_rating("co2 scrubber")

local result = oxygen_rating * co2_scrubber_rating
print(result)