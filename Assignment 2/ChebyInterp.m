function alfa = ChebyInterp(x,y)
% x and y are column n-vectors and x(1)<x(2)<...<x(n).
% alfa is a column n-vector with the property that if
% f(x) = alfa(1)B_{1}(x) +...+alfa(n)B_{n}(x)
% where the B_{1}(x),...,B_{n}(x) is the Chebyschev polynomial
% basis with respect to [a,b], then f(x(i)) = y(i), i=1:n.

%Alter x as seen in pdf
n = length(x);
xCheb = -1 + 2 *( (x-x(1)) ./ (x(n) - x(1)));
xCheb = xCheb';
M = zeros(n, n);

%Create M matrix
for i = 1:n
    if i== 1
        M(i,:) = ones(1, length(xCheb));
    elseif i == 2
        M(i,:) = xCheb;
    else
        M(i,:) = (2 * (xCheb) .* M(i-1, :) - M(i-2, :));
    end
end

%lu decomposition
[L, U] = lu(M);
b = L \ y;
alfa = U \ b;


%Helper function for creating M matrix
function B_j = B(x, i, M)
if i== 1
    B_j = ones(1, length(x));
elseif i == 2
    B_j = x';
else
    B_j = (2 * (x') .* M(i-1, :) - M(i-2, :));
end