function [gamma] = armijo(xk,d)
    
    % Initialize function
    syms x y
    f(x,y) = x^3*exp(-x^2-y^4);
    gradf = jacobian(f,[x,y]);
    
    % Initialize variables
    s = 1; 
    a = 0.01; 
    b = 0.3;
    m = 0;
    gamma = s*b^m;
    delta_xk = double(subs(gradf,[x,y],xk));
    while f(xk(1),xk(2))-f(xk(1)+gamma*d(1),xk(2)+gamma*d(2))<(-a*(b^m)*s*d'*delta_xk)
        m = m + 1;
        gamma = s*b^m;
    end
end