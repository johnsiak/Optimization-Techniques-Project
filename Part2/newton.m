clear all
clc

% Initialize function
syms x y
f(x,y) = x^3*exp(-x^2-y^4);
gradf = jacobian(f,[x,y]);
grad2f = hessian(f,[x,y]);

% Initialize variables
X = zeros(100,2);
d = zeros(100,2);

e = 0.001;
gamma = 0.6;

% Our starting points
X0 = [0,0; -1,-1; 1,1;]; 

for i = 1:3
    k = 1;
    X(k,:) = X0(i,:);
    f_values = zeros(100,1);
    while norm(double(subs(gradf,[x,y],X(k,:)))) >= e
        h = double(subs(grad2f,[x,y],X(k,:)));
        if h(1,1) < 0 || h(1,1)*h(2,2)-h(1,2)*h(2,1) < 0
            disp('Error. The hessian is not positive definite');
            break
        end
        f_values(k) = f(X(k,1),X(k,2));
        d(k,:) = -inv(h)*(double(subs(gradf,[x,y],X(k,:)))).';
        X(k+1,:) = X(k,:) + gamma*d(k,:);
        k = k + 1;
    end
    
    % Plot
    figure(i);
    kplot = 1:(k-1);
    plot(kplot,f_values(1:(k-1)));
    ourTitle = sprintf("Newton, gamma = %f, x0 = (%d,%d)", gamma, X0(i,1), X0(i,2));
    title(ourTitle);
    xlabel('k');
    ylabel('f(x,y)');
end