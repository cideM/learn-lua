# This is the fastest but at the cost of memory
echo "whole file"
command time lua ch7/exercises/3_whole.lua < (head -c 1G </dev/urandom | psub) > /dev/null

echo "8kb chunks"
command time lua ch7/exercises/3_8kb.lua < (head -c 1G </dev/urandom | psub) > /dev/null

echo "byte by byte"
command time lua ch7/exercises/3_byte.lua < (head -c 1G </dev/urandom | psub) > /dev/null

# This doesn't really do linewise reading since the output from /dev/urandom
# isn't well behaved linewise
echo "linewise"
command time lua ch7/exercises/3_line.lua < (head -c 1G </dev/urandom | psub) > /dev/null
