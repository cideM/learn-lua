-- Compute volume of right circular cone, given height and angle between a generatrix and the axis.
function volume(height, generatrix_axis_angle)
  -- math.tan and friends work with radians
  local angle_radians = generatrix_axis_angle * math.pi / 180

  r = height * math.tan(angle_radians)

  return (math.pi * (r ^ 2) * height) / 3
end

print(volume(6, 30))
