  function ShowTrigFit()
% Checks out TrigFit
% Generate an example...
P = 365;
m = 1000;
N = 6;
t = linspace(0,P,m)';
y = 6*cos((2*pi/P)*t) - 5*sin((7*pi/P)*t) + ...
    2*cos((3*pi/P)*t) + 3*sin((5*pi/P)*t) + .1*randn(m,1);
% Solve the LS problem...
[A,B] = TrigFit(t,y,N,P);
% Display the fits...
C = cos((2*pi/P)*t*(1:N));
S = sin((2*pi/P)*t*(1:N));
close all
for n=1:N
    figure
    plot(t,y,'k',t,C(:,1:n)*A(1:n,n)+S(:,1:n)*B(1:n,n),'r',[0 365],[0 0],'b')
    title(sprintf('n = %1d',n),'fontsize',14) 
end
% and the coefficients...
clc
format short
A = A
B = B
