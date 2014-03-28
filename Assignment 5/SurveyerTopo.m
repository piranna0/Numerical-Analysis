function A = SurveyorTopo(m,n,p,Noise,E0)
% m,n, and p are positive integers and Noise is a positive scalar.
% A is an (m+1)-by-(n+1) matrix with the property that A(i,j) is an
% estimate of E(x(j),y(i)) where x = linspace(0,3,n+1) and
% y = linspace(0,2,m+1).

N = (m+1)*(n+1);
hx = 3/n; 
hy = 2/m;

% Surveyor point is (0,0)
i0 = 0;
j0 = 0;
SurveyorIndex = 1 + j0 + i0 * (n+1);

% Assistant point is random

S = sparse((m+1)*(n+1)*p,(m+1)*(n+1));
f = zeros((m+1)*(n+1)*p,1);
for k = 1:(m+1)*(n+1)*p
    % Random point for assistant (0 indexed)
    i1 = randi(m+1)-1;
    j1 = randi(n+1)-1;
    AssistantIndex = 1+j1+i1*(n+1);
    
    % Otherwise row is already set to 0, f is already set to 0     
    if (i1 == i0 && j1 == j0)
        S(k, :) = 0;
        f(k) = 0;
    else
        S(k, SurveyorIndex) = -1;
        S(k, AssistantIndex) = 1;
        f(k) = E(j1*hx,i1*hy) - E(j0*hx,i0*hy) + Noise*randn(1);
    end
end
% Normal equations
G = chol(S(:,2:N)'*S(:,2:N), 'lower');

normalEqn = G'\(G\(S(:,2:N)'*(f - E0*S(:,1))));
A = reshape([E0; normalEqn], n+1, m+1)';

function z = E(x,y)
% z is the elevation at (x,y). 
z = 100*exp( -2.4*(x-0.5)^2 - 7.2*(y-0.6)^2 ) +...
    150*exp( -5.2*(x-1.0)^2 - 4.7*(y-1.7)^2 ) +...
    150*exp( -3.2*(x-2.1)^2 - 6.7*(y-0.9)^2 ) +...
    200*exp( -5.8*(x-2.7)^2 - 1.2*(y-0.8)^2 );