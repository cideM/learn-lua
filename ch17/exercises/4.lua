-- 17.4 Write a searcher that searches for Lua files and C libraries at the same
--    time. Hint: use package.searchpath to find a proper file, then try to load
--    it, first with loadfile and next with package.loadlib.

-- I think it's not ideal that this comes way before C and Lua because I don't
-- yet know how to create an .so file and use it with Lua. But I'd need a file
-- like this to test that this actually work.
function lua_and_c_searcher(modname)
  local path = "./?.lua;./?.so;"
  local fname, err = package.searchpath(modname, path)
  if err then return err end

  local errs = {}

  local loader, err = loadfile(fname)
  if loader then return loader, nil end
  table.insert(errs, err)

  -- > 'require' has one more searcher for loading C submodules
  -- I guess that means I need to take care of replacing dots with underscores
  -- > 'require' translates the dot into another character
  -- This makes it sound as if this was done by require already? Not sure.
  -- I won't implement any of this now since I'd rather continue with the next
  -- chapters.
  local cloader = package.loadlib(fname, modname)
  if cloader then return cloader, nil end

  table.insert(errs, "couldn't find " .. modname)

  return nil, table.concat(errs, ";")
end
