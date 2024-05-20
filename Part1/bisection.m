clear all
clc

% Define an array of functions
functions = {@(x) (x - 1)^3 + ((x - 4)^2)*cos(x), @(x) exp((-2)*x) + (x - 2)^2, @(x) (x^2)*log(0.5*x) + sin((0.2*x)^2)};

% Iterate through each function
for j = 1:length(functions)
    figure(j)
    % Initialize parameters
    l = 0.01;
    e = 0.001;

    a = zeros(100, 1);
    b = zeros(100, 1);

    x1 = zeros(100, 1);
    x2 = zeros(100, 1);

    % Define initial interval [a, b]
    a(1) = 0;
    b(1) = 3;
    k = 1;

    f = functions{j};

    % Bisection method
    while (b(k) - a(k)) >= l
        % Update the interval [a, b] and store the values
        x1(k) = (a(k) + b(k))/2 - e;
        x2(k) = (a(k) + b(k))/2 + e;

        if f(x1(k)) < f(x2(k))
            a(k + 1) = a(k);
            b(k + 1) = x2(k);
        else
            a(k + 1) = x1(k);
            b(k + 1) = b(k);
        end
        k = k + 1;
    end

    fprintf('For function %d, the minimum value belongs to the interval [a, b] = [%f, %f]\n', j, a(k), b(k));

    % Additional optimizations with different parameter variations and plot results
    l = 0.01;
    e = 0.0001:0.0001:0.0049;

    a = zeros(100, 1);
    b = zeros(100, 1);

    x1 = zeros(100, 1);
    x2 = zeros(100, 1);

    a(1) = 0; 
    b(1) = 3;

    N = zeros(length(e), 1);

    for i = 1:length(e)
        k = 1;
        while (b(k) - a(k)) >= l 
            % Update the interval [a, b] and store the values
            x1(k) = (a(k) + b(k))/2 - e(i);
            x2(k) = (a(k) + b(k))/2 + e(i);

            if f(x1(k)) < f(x2(k))
                a(k+1) = a(k);
                b(k+1) = x2(k);
            else
                a(k+1) = x1(k);
                b(k+1) = b(k);
            end
            k = k + 1;
        end
        N(i) = k;
    end
    number_of_calculations = 2*N;
    
    % Plot the total number of calculations
    subplot(1,3,1);
    plot(e, number_of_calculations);
    hold on;
    xlabel('ε');
    ylabel('Total calculations');
    
    % Variation of l
    e = 0.001;
    l = 0.0021:0.0001:0.02;
    
    a = zeros(100, 1);
    b = zeros(100, 1);
    
    x1 = zeros(100, 1);
    x2 = zeros(100, 1);
    
    a(1) = 0; 
    b(1) = 3;
    
    N = zeros(length(l), 1);
    
    for i = 1:length(l)
        k = 1;
        while ( b(k) - a(k) ) >= l(i)
            % Update the interval [a, b] and store the values
            x1(k) = (a(k) + b(k))/2 - e;
            x2(k) = (a(k) + b(k))/2 + e;
    
            if f(x1(k)) < f(x2(k))
                a(k+1) = a(k);
                b(k+1) = x2(k);
            else
                a(k+1) = x1(k);
                b(k+1) = b(k);
            end
            k = k + 1;
        end
        N(i) = k;
    end
    number_of_calculations = 2*N;
    
    subplot(1,3,2);
    plot(l, number_of_calculations);
    hold on;
    xlabel('l');
    ylabel('Total calculations');
    
    % Plot interval against k for different l values
    l = [0.005, 0.01, 0.1];
    
    a = zeros(100, 3);
    b = zeros(100, 3);
    
    x1 = zeros(100, 3);
    x2 = zeros(100, 3);
    
    a(1,:) = [0, 0, 0];
    b(1,:) = [3, 3, 3];
    
    k = zeros(1, 3);
    
    for i = 1:3
        k(i) = 1;
        while (b(k(i), i) - a(k(i), i)) >= l(i) 
            % Update the interval [a, b] and store the values
            x1(k(i), i) = (a(k(i), i) + b(k(i), i))/2 - e;
            x2(k(i), i) = (a(k(i), i) + b(k(i), i))/2 + e; 
    
            if f(x1(k(i), i)) < f(x2(k(i), i))
                a(k(i)+1, i) = a(k(i), i);
                b(k(i)+1, i) = x2(k(i), i);
            else
                a(k(i)+1, i) = x1(k(i), i);
                b(k(i)+1, i) = b(k(i), i);
            end
    
            k(i) = k(i) + 1;
        end
    end
    
    % Indices for plotting intervals [a(k), b(k)]
    K1 = (1:1:k(1))';
    K2 = (1:1:k(2))';
    K3 = (1:1:k(3))';
    
    subplot(1,3,3);
    plot(K1, a(1:k(1),1));
    hold on;
    plot(K1, b(1:k(1),1));
    plot(K2, a(1:k(2),1));
    plot(K2, b(1:k(2),1));
    plot(K3, a(1:k(3),1));
    plot(K3, b(1:k(3),1));
    
    xlabel('k');
    ylabel('[a(k), b(k)]');
    legend({'a, l=0.005','b, l=0.005','a, l=0.01','b, l=0.01','a, l=0.1','b, l=0.1'});
end