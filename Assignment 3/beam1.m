function d = beam1(n)

d = ones(n,1)/n^4;

%y = inv(U') * b
d(n - 1) = 2 * d(n) + d(n - 1);
for i = n-2 : -1 : 2
    d(i) = d(i) + 2 * d(i + 1) - d(i + 2);
end
d(1) = (2 * d(2) - d(3)) / 2;

% x = inv(U) * y
d(1) = d(1) / 2;
d(2) = d(2) + 2 * d(1);
for i = 3 : n
    d(i) = d(i) + 2 * d(i - 1) - d(i-2);
end