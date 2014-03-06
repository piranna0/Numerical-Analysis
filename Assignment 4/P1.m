function P1()
% Plots the function f(x) = sin(alpha*x) - x for various alpha
for alpha = 1:30
    x = linspace(-1,1,200);
    y = MyF(x,alpha);
    plot(x,y,[-1 1],[0 0],'r')
    title(sprintf('f(x) = sin(alpha*x) - x ,  alpha = %1d',alpha),'fontsize',16)
    grid on
    shg
    pause(1)
end

function y = MyF(x,alpha)
y = sin(alpha*x) - x;