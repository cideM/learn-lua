-- 9.4 Using the geometric functions draw a waxing crescent moon as seen from the northern hemisphere

function disk (cx, cy, r)
  return function (x,y)
           return (x - cx)^2 + (y - cy)^2 <= r^2
         end
end

function translate (r, dx, dy)
  return function (x, y)
           return r(x - dx, y - dy)
         end
end

function difference (r1, r2)
  return function (x, y)
           return r1(x, y) and not r2(x, y)
         end
end

function plot (r, M, N)
  io.write("P1\n", M, " ", N, "\n")
  for i = 1, N do
    local y = (N - i*2)/N -- this maps the drawing area to the viewport
    for j = 1, M do
      local x = (j*2 - M)/M
      io.write(r(x,y) and "1" or "0")
    end
    io.write("\n")
  end
end

-- Southern hemisphere
c1 = disk(0, 0, 1)
plot(difference(c1, translate(c1, 0.3, 0)), 30, 30)

-- Northern hemisphere
plot(difference(c1, translate(c1, -0.3, 0)), 30, 30)
