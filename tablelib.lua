function table.length(t) 
  local count = 0
  for _ in pairs(t) do 
      count = count + 1 
  end
  return count
end

function table.slice(t, start_i, end_i)
    local result = {}
    for i = start_i or 1, end_i or table.length(t) do
        table.insert(result, t[i])
    end
    return result
end