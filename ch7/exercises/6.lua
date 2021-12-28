function list(dir)
  local findcmd = io.popen("find "..dir.." -maxdepth 1 -printf '%y %p\n'")
  for line in findcmd:lines() do
    print(line)
  end
end

function mkdir(dir)
  local ok, exit = os.execute("mkdir "..dir)
  if not ok or exit ~= "exit" then
    os.exit(1)
  end
end

function rm(dir)
  local ok, exit = os.execute("rm -r "..dir)
  if not ok or exit ~= "exit" then
    os.exit(1)
  end
end

if arg[1] == "list" then
  list(arg[2])
elseif arg[1] == "mkdir" then
  mkdir(arg[2])
elseif arg[1] == "rm" then
  rm(arg[2])
end
