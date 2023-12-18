---Filter directories when searching for test files
---@async
---@param name string Name of directory
---@param rel_path string Path to directory, relative to root
---@param root string Root directory of project
---@return boolean
local filter_dir = function(name, rel_path, root)
  local full_path = root .. '/' .. rel_path
  print('I will filter_dir')
  if root:match('/root/proj/spack') then
    print('root matches')
    if full_path:match('^proj/site/test') then
      return true
    else
      return false
    end
  else
    return name ~= 'node_modules'
  end
end

---Filter files
---@async
---@param file_path string Path of file
---@return boolean
local is_test_file = function(file_path)
  print(file_path)
  return true
end
