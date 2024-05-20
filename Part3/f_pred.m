function [f_pred] = f_pred(a,b,const,u1,u2)

% Calculate f prediction  ^
%                         f

f_pred = 0;
for i=1:15
    f_pred = f_pred + a(i)*gaussian(u1,u2,const(i,:));
end
f_pred = f_pred + b;
end
