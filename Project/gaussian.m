function [G] = gaussian(u1,u2,const)

c1 = const(1);
c2 = const(2);
s1 = const(3);
s2 = const(4);

% Calculate Gaussian based on formula
G = exp(-(((u1 - c1)^2)/(2*s1^2) + ((u2 - c2)^2)/(2*s2^2)));

end