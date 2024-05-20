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
gamma = 0.2;

i = 1;
j = 0;

% Our starting points
X0 = [0,0; -1,-1; 1,1;]; 

while i <= 3
    k = 1;
    X(k,:) = X0(i,:);
    f_values = zeros(100,1);
    while norm(double(subs(gradf,[x,y],X(k,:)))) >= e
        h = double(subs(grad2f,[x,y],X(k,:)));
        m = 0;
        H = h + m * eye(size(h));
        while H(1,1) < 0 || H(1,1)*H(2,2) - H(1,2)*H(2,1) <= 0
            m=m+1;
            H = h+m*eye(size(h));
        end
        f_values(k) = f(X(k,1),X(k,2));
        d(k,:) = -double(subs(gradf,[x,y],X(k,:)))/H;
        if j == 1
            % B - minimize
            gamma = min_gamma(X(k,:),d(k,:));
        elseif j == 2
            % C - armijo
            gamma = armijo(X(k,:),d(k,:));
        end
        X(k+1,:) = X(k,:) + gamma*d(k,:);
        k = k + 1;
    end
    
    % Plot
    figure();
    kplot = 1:(k-1);
    plot(kplot,f_values(1:(k-1)));
    ourTitle = sprintf("Levenberg-Marquardt, gamma = %f, x0 = (%d,%d)", gamma, X0(i,1), X0(i,2));
    title(ourTitle);
    xlabel('k');
    ylabel('f(x,y)');

    % If we have finished all questions
    if j == 2 && i == 3
        break
    end

    % If we have searched all starting points then we move to the next
    % question e.g. minimize and armijo
    if i == 3
        j = j + 1;
        i = 1;
        continue
    end
    i = i + 1;
end