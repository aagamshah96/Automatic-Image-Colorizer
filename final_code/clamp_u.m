function ans = clamp_u(value)
u_max = 0.436;

ans = max(min(value,u_max),-1*u_max);

end