function X = projection(point)
    % Initialize variables
    x_floor = -10;
    x_ceil = 5;
    y_floor = -8;
    y_ceil = 12;
    
    X = zeros(size(point));

    % Ensure X is inside the bounds [floor, ceil]
    X(1) = min(max(point(1), x_floor), x_ceil);
    X(2) = min(max(point(2), y_floor), y_ceil);
end