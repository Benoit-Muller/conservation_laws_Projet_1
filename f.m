function F=f(h,m) 
    g=1;
    F= [m; m.^2./h + 0.5*g*h.^2];
end