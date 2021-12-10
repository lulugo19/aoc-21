local input = io.open("input.txt", "r")
local one_count = {}
local zero_count = {}
local line_length = 0
for line in input:lines() do
  line_length = #line
  for i=1, line_length do
    local bin = line:sub(i, i)
    if bin == "1" then one_count[i] = (one_count[i] or 0) + 1
    elseif bin == "0"  then zero_count[i] = (zero_count[i] or 0) + 1
    end
  end
end

local gamma = 0
local epsilon = 0
for i=1, line_length do
  gamma = gamma * 2
  epsilon = epsilon * 2
  if one_count[i] > zero_count[i] then gamma = gamma + 1
  else epsilon = epsilon + 1 end
end

local result = epsilon * gamma
print(result)