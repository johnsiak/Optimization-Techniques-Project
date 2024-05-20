clear all
clc

% Initialize function
syms x y
f(x,y) = (1/3)*x^2 + 3*y^2;
gradf = jacobian(f, [x,y]);

% Initialize variables
X = zeros(1000,2);
d = zeros(1000,2);
e = 0.001;

% Different values for gamma
gamma = [0.1; 0.3; 3; 5];

% Our starting point
X0 = [5,-5]; 

for i = 1:4
    k = 1;
    X(k,:) = X0;
    f_values = zeros(1000,1);
    
    while norm(double(subs(gradf,[x,y],X(k,:)))) >= e
        f_values(k) = f(X(k,1),X(k,2));
        d(k,:) = -double(subs(gradf,[x,y],X(k,:)));
        X(k+1,:) = X(k,:) + gamma(i)*d(k,:);
        k = k + 1;
    end
    
    % Plot
    subplot(2,2,i);
    kplot = 1:(k-1);
    plot(kplot, f_values(1:(k-1)));
    ourTitle = sprintf("Steepest Descend, gamma = %.2f, x0 = (%d,%d)", gamma(i), X0(1), X0(2));
    title(ourTitle);
    xlabel('k');
    ylabel('f(x,y)');
end