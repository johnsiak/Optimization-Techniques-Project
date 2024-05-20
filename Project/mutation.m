function Y = mutation(P,n)

% n is the number of chromosomes to be mutated

[x1, y1] = size(P);
Z = zeros(n,y1);
for i = 1:n
    r1 = randi(x1);
    % Random parent
    A1 = P(r1,:);       
    r2 = randi(y1);
    if A1(1,r2) == 1
        % Change the bit
        A1(1,r2) = 0;   
    else
        A1(1,r2) = 1;
    end
    Z(i,:) = A1;
end
Y = Z; 
end