clear all
clc

% Initialize function
syms x y
f = x^3*exp(-x^2-y^4);

% Create a 3D surface plot
figure();
fsurf(f, [-4 4 -4 4]);

% Create a contour plot
figure();
[x1, y1] = meshgrid(-4:0.1:4, -4:0.1:4);
z1 = (x1.^3).*exp(-x1.^2-y1.^4);
contour(x1, y1, z1);

xlabel('x');
ylabel('y');
title('Function Visualization');
