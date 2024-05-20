function Y = crossover(P,n)

% n is the number of pairs of chromosomes to be crossovered

[x1, y1] = size(P);
Z = zeros(2*n,y1);
for i = 1:n
    % Select 2 different random chromosomes
    r1 = randi(x1,1,2);
    while r1(1) == r1(2)
        r1 = randi(x1,1,2);
    end
    A1 = P(r1(1),:);
    A2 = P(r1(2),:);
    % Select a random crossover point
    r2 = 1 + randi(y1 - 1);
    % Perform crossover
    B1 = A1(1,r2:y1);
    A1(1,r2:y1) = A2(1,r2:320);
    A2(1,r2:320) = B1;
    Z(2*i - 1,:) = A1;
    Z(2*i,:) = A2;
end
Y = Z;
end