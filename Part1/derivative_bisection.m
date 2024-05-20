clear all
clc

% Define an array of functions
functions = {@(x) (x - 1)^3 + ((x - 4)^2)*cos(x), @(x) exp((-2)*x) + (x - 2)^2, @(x) (x^2)*log(0.5*x) + sin((0.2*x)^2)};

% Iterate through each function
for j = 1:length(functions)
    figure(j)
    % Initialize parameter
    l = 0.01;

    a = zeros(100, 1);
    b = zeros(100, 1);

    % Define initial interval [a, b]
    a(1) = 0;
    b(1) = 3;

    syms x;
    
    f = functions{j};
    ff = diff(f,x);
    n = 0;
    while 0.5^n > l/(b(1)-a(1))
        n = n + 1;
    end
    
    X = zeros(100, 1);
    
    % Derivative bisection method
    for k = 1:n
        % Update the interval [a, b] and store the values
        X(k) = (a(k) + b(k))/2;
        fder_Xk = double(vpa(subs(ff, x, X(k)))); 
        if fder_Xk > 0
            a(k+1) = a(k);
            b(k+1) = X(k);
        elseif fder_Xk < 0
            a(k+1) = X(k);
            b(k+1) = b(k);
        else
            fprintf('Derivative found 0\n');
            break;
        end
    end
    
    fprintf('For function %d, the minimum value belongs to the interval [a, b] = [%f, %f]\n', j, a(k), b(k));
    
    % Variation of l
    l = 0.0021:0.0001:0.02;
    
    a = 0; 
    b = 3;
    
    n = zeros(length(l), 1);
    for i = 1:length(l)
        while 0.5^n(i) > l(i)/(b-a)
            n(i) = n(i) + 1;
        end
    end
    number_of_calculations = n;
    
    subplot(1,2,1);
    plot(l, number_of_calculations);
    hold on;
    xlabel('l');
    ylabel('Total calculations');
    
    % Plot interval against k for different l values
    l = [0.005, 0.01, 0.1];
    
    a = zeros(100, 3);
    b = zeros(100, 3);

    a(1, :) = [0, 0, 0]; 
    b(1, :) = [3, 3, 3];
    
    syms x;
    
    n = zeros(3, 1);
    for i = 1:3
        while 0.5^n(i) > l(i)/(b(1,1)-a(1,1))
            n(i) = n(i) + 1;
        end
    end
    
    X = zeros(100, 3);
    
    for i = 1:3
        for k = 1:n(i)
            % Update the interval [a, b] and store the values
            X(k, i) = (a(k,i) + b(k,i))/2;
            fder_Xk = double(vpa(subs(ff, x, X(k,i))));
            if fder_Xk > 0
                a(k+1,i) = a(k,i);
                b(k+1,i) = X(k,i);
            elseif fder_Xk < 0
                a(k+1,i) = X(k,i);
                b(k+1,i) = b(k,i);
            else
                fprintf('Derivative found 0\n');
                break;
            end
        end
    end
    
    % Indices for plotting intervals [a(k), b(k)]
    K1 = (1:1:n(1))';
    K2 = (1:1:n(2))';
    K3 = (1:1:n(3))';
    
    subplot(1,2,2);    
    plot(K1, a(1:n(1),1));
    hold on;
    plot(K1, b(1:n(1),1));
    plot(K2, a(1:n(2),1));
    plot(K2, b(1:n(2),1));
    plot(K3, a(1:n(3),1));
    plot(K3, b(1:n(3),1));
    
    xlabel('k');
    ylabel('[a(k), b(k)]');
    legend({'a, l=0.001','b, l=0.001','a, l=0.01','b, l=0.01','a, l=0.1','b, l=0.1'});
end