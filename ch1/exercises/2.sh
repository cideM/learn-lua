#!/bin/sh

lua -e 'dofile("./ch1/factorial.lua")'

LUA_PATH=./ch1/factorial.lua lua -lfactorial -i
