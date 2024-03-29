function alfa = ChebyInterp(x,y)
% x and y are column n-vectors and x(1)<x(2)<...<x(n).
% alfa is a column n-vector with the property that if
% f(x) = alfa(1)B_{1}(x) +...+alfa(n)B_{n}(x)
% where the B_{1}(x),...,B_{n}(x) is the Chebyschev polynomial
% basis with respect to [a,b], then f(x(i)) = y(i), i=1:n.

%Alter x as seen in pdf
n = length(x);
xCheb = -1 + 2 *( (x-x(1)) ./ (x(n) - x(1)));
M = zeros(n, n);

%Create M matrix
for j = 1:n
    if j== 1
        M(:,j) = ones(length(xCheb), 1);
    elseif j == 2
        M(:,j) = xCheb;
    else
        M(:,j) = (2 * (xCheb) .* M(:,j-1) - M(:,j-2));
    end
end

%lu decomposition
[L, U] = lu(M);
b = L \ y;
alfa = U \ b;