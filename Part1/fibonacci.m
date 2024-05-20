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
    
    f = functions{j};
    n = 0;
    while (b(1)-a(1))/fib(n) >= l
        n = n + 1;
    end
    
    x1(1) = a(1) + (fib(n-2)/fib(n))*(b(1)-a(1));
    x2(1) = a(1) + (fib(n-1)/fib(n))*(b(1)-a(1));
    
    % Fibonacci method
    for k = 1:n-2
        % Update the interval [a, b] and store the values
        if f(x1(k)) > f(x2(k))
            a(k+1) = x1(k);
            b(k+1) = b(k);
            x1(k+1) = x2(k);
            x2(k+1) = a(k+1)+(fib(n-k-1)/fib(n-k))*(b(k+1)-a(k+1));
        else
            a(k+1) = a(k);
            b(k+1) = x2(k);
            x2(k+1) = x1(k);
            x1(k+1) = a(k+1)+(fib(n-k-2)/fib(n-k))*(b(k+1)-a(k+1));
        end
    end
    
    x1(n) = x1(n-1);
    x2(n) = x1(n-1)+e;
    if f(x1(n)) > f(x2(n))
        a(n) = x1(n);
        b(n) = b(n-1);
    else
        a(n) = a(n-1);
        b(n) = x1(n);
    end
    
    fprintf('For function %d, the minimum value belongs to the interval [a, b] = [%f, %f]\n', j, a(n), b(n));

    % Variation of l
    l = 0.0021:0.0001:0.02;

    a = 0; 
    b = 3;
    
    n = zeros(length(l), 1);
    for i = 1:length(l)
        while (b-a)/fib(n(i)) >= l(i)
            n(i) = n(i) + 1;
        end
    end
    number_of_calculations = 2 * (n-2) + 2;
    
    subplot(1,2,1);
    plot(l, number_of_calculations);
    hold on;
    xlabel('l');
    ylabel('Total calculations');

    % Plot interval against k for different l values
    l = [0.005, 0.01, 0.1];

    a = zeros(100,3);
    b = zeros(100,3);

    x1 = zeros(100,3);
    x2 = zeros(100,3);

    a(1,:) = [0, 0, 0]; 
    b(1,:) = [3, 3, 3];

    n = zeros(3,1);
    for i = 1:3
        while (b(1,1)-a(1,1))/fib(n(i)) >= l(i)
            n(i) = n(i) + 1;
        end
        x1(1,i) = a(1,i) + (fib(n(i)-2)/fib(n(i)))*(b(1,i)-a(1,i));
        x2(1,i) = a(1,i) + (fib(n(i)-1)/fib(n(i)))*(b(1,i)-a(1,i));
    end
    
    for i = 1:3
        for k = 1:n(i)-2
            % Update the interval [a, b] and store the values
            if f(x1(k,i)) > f(x2(k,i))
                a(k+1,i) = x1(k,i);
                b(k+1,i) = b(k,i);
                x1(k+1,i) = x2(k,i);
                x2(k+1,i) = a(k+1,i)+(fib(n(i)-k-1)/fib(n(i)-k))*(b(k+1,i)-a(k+1,i));
            else
                a(k+1,i) = a(k,i);
                b(k+1,i) = x2(k,i);
                x2(k+1,i) = x1(k,i);
                x1(k+1,i) = a(k+1,i)+(fib(n(i)-k-2)/fib(n(i)-k))*(b(k+1,i)-a(k+1,i));
            end

            x1(n(i),i) = x1(n(i)-1,i);
            x2(n(i),i) = x1(n(i)-1,i)+e;
            if f(x1(n(i),i)) > f(x2(n(i),i))
                a(n(i),i) = x1(n(i),i);
                b(n(i),i) = b(n(i)-1,i);
            else
                a(n(i),i) = a(n(i)-1,i);
                b(n(i),i) = x1(n(i),i);
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

    xlabel('k')
    ylabel('[a(k), b(k)]');
    legend({'a, l=0.001','b, l=0.001','a, l=0.01','b, l=0.01','a, l=0.1','b, l=0.1'});
end