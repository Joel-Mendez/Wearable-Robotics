function [dfdx] = dfdx(x,f)

% x = x';
x = x(:);
f = f(:);
dfdx   = pchip(0.5*(x(1:end-1)+x(2:end)), diff(f)   ./ diff(x), x);
% figure, hold all
% plot(dfdx)






