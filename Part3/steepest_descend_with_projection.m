clear all
clc

% Initialize function
syms x y
f(x,y) = (1/3)*x^2 + 3*y^2;
gradf = jacobian(f, [x,y]);

% Initialize variables
X = zeros(1000,2);
d = zeros(1000,2);

e = 0.01;
gamma = 0.5;
s = 5;

% Our starting point
X0 = [5,-5]; 

k = 1;
X(k,:) = X0;
f_values = zeros(1000,1);
    
while norm(double(subs(gradf,[x,y],X(k,:)))) >= e && k < 100
    f_values(k) = f(X(k,1),X(k,2));
    temp = X(k,:) - s*double(subs(gradf,[x,y],X(k,:)));
    x_bar = projection(temp);
    X(k+1,:) = X(k,:) + gamma*(x_bar - X(k,:));
    k = k + 1;
end

% Plot
figure();
kplot = 1:(k-1);
plot(kplot, f_values(1:(k-1)));
ourTitle = sprintf("Steepest Descend with projection, gamma = %.2f, s = %.1f, x0 = (%d,%d)", gamma, s, X0(1), X0(2));
title(ourTitle);
xlabel('k');
ylabel('f(x,y)');