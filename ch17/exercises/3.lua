-- 17.3 Can a fixed component in a search path be useful?

--[[
Hm, a fixed component would mean that, if it exists, that module will always be
loaded regardless of the module name. The searcher would then be called with the
module name and the name of the file. You could then load the requested module
or something else. This could be useful for loading a different module for
development mode. Actually this sounds quite interesting. I think Ocaml has a
really good module system, at least so I've heard. And Haskell folks have tried
to build something similarish with Backpack (I think; I haven't used Ocaml nor
Backpack).
I could have a fixed component that loads module from a ./dev prefix for local
development, while the codebase is not aware of this and just calls
require"email" or something.
--]]
