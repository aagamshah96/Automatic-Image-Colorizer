function ans = clamp_v(value)
v_max = 0.436;

ans = max(min(value,v_max),-1*v_max);

end