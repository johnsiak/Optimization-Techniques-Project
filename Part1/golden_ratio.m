clear all
clc

% Define an array of functions
functions = {@(x) (x - 1)^3 + ((x - 4)^2)*cos(x), @(x) exp((-2)*x) + (x - 2)^2, @(x) (x^2)*log(0.5*x) + sin((0.2*x)^2)};

% Iterate through each function
for j = 1:length(functions)
    figure(j)
    % Initialize parameters
    l = 0.01;
    gamma = 0.618;
    
    a = zeros(100, 1);
    b = zeros(100, 1);

    x1 = zeros(100, 1);
    x2 = zeros(100, 1);

    % Define initial interval [a, b]
    a(1) = 0; 
    b(1) = 3;

    x1(1) = a(1) + (1-gamma)*(b(1) - a(1));
    x2(1) = a(1) + gamma*(b(1) - a(1));

    k = 1;    
    f = functions{j};

    % Golden ratio method
    while (b(k) - a(k)) >= l   
        % Update the interval [a, b] and store the values
        if f(x1(k)) > f(x2(k))
            a(k+1) = x1(k);
            b(k+1) = b(k);
            x2(k+1) = a(k+1) + gamma*(b(k+1) - a(k+1));
            x1(k+1) = x2(k);
        else
            a(k+1) = a(k);
            b(k+1) = x2(k);
            x2(k+1) = x1(k);
            x1(k+1) = a(k+1) + (1-gamma)*(b(k+1) - a(k+1));
        end
        k = k + 1;
    end
    
    fprintf('For function %d, the minimum value belongs to the interval [a, b] = [%f, %f]\n', j, a(k), b(k));
    
    % Variation of l
    l = 0.0021:0.0001:0.02;

    a = zeros(100, 1);
    b = zeros(100, 1);

    x1 = zeros(100, 1);
    x2 = zeros(100, 1);

    a(1) = 0; 
    b(1) = 3;

    x1(1) = a(1) + (1-gamma)*(b(1) - a(1));
    x2(1) = a(1) + gamma*(b(1) - a(1));
    
    N = zeros(length(l), 1);
    
    for i = 1:length(l)
        k = 1;
        while b(k)-a(k) >= l(i)   
            % Update the interval [a, b] and store the values
            if f(x1(k)) > f(x2(k))
                a(k+1) = x1(k);
                b(k+1) = b(k);
                x2(k+1) = a(k+1) + gamma*(b(k+1) - a(k+1));
                x1(k+1) = x2(k);
            else
                a(k+1) = a(k);
                b(k+1) = x2(k);
                x2(k+1) = x1(k);
                x1(k+1) = a(k+1) + (1-gamma)*(b(k+1) - a(k+1));
            end
            k = k + 1;
        end
        N(i) = k;
    end
    number_of_calculations = 2*N;
    
    subplot(1,2,1);
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

    t1 = a(1) + (1-gamma)*(b(1) - a(1));
    t2 = a(1) + gamma*(b(1) - a(1)); 

    x1(1, :) = [t1, t1, t1];
    x2(1, :) = [t2, t2, t2]; 
    
    k = zeros(1, 3); 
    
    for i = 1:3
        k(i) = 1;
        while (b(k(i), i) - a(k(i), i)) >= l(i)
            % Update the interval [a, b] and store the values
            if f(x1(k(i), i)) > f(x2(k(i), i))
                a(k(i)+1,i) = x1(k(i),i);
                b(k(i)+1,i) = b(k(i),i);
                x2(k(i)+1,i) = a(k(i)+1,i) + gamma*(b(k(i)+1,i) - a(k(i)+1,i));
                x1(k(i)+1,i) = x2(k(i),i);
            else
                a(k(i)+1,i) = a(k(i),i);
                b(k(i)+1,i) = x2(k(i),i);
                x2(k(i)+1,i) = x1(k(i),i);
                x1(k(i)+1,i) = a(k(i)+1,i) + (1-gamma)*(b(k(i)+1,i) - a(k(i)+1,i));
            end
            k(i) = k(i) + 1;
        end
    end
    
    % Indices for plotting intervals [a(k), b(k)]
    K1 = (1:1:k(1))';
    K2 = (1:1:k(2))';
    K3 = (1:1:k(3))';
    
    subplot(1,2,2);
    plot(K1, a(1:k(1),1));
    hold on;
    plot(K1, b(1:k(1),1));
    plot(K2, a(1:k(2),1));
    plot(K2, b(1:k(2),1));
    plot(K3, a(1:k(3),1));
    plot(K3, b(1:k(3),1)); 
    
    xlabel('k');
    ylabel('[a(k), b(k)]');
    legend({'a, l=0.001','b, l=0.001','a, l=0.01','b, l=0.01','a, l=0.1','b, l=0.1'});
end