function CheckCheby(n)
x = sort(rand(n, 1));
y = sort(rand(n, 1));
tic
M = zeros(n, n);
for j = 1:n
    for i=1:n
        M(i,j) = B_i (x, i, j, M);
    end
end
alfa = M\y;
tslow = toc
tic
alfa2 = ChebyInterp(x,y);
tfast = toc

fprintf('Error = %10.3e\n\n\n',norm(M\y - ChebyInterp(x, y)));

function B = B_i(x, i, j, M)
n = length(x);
x2 = -1 + 2 * ((x(i) - x(1)) / (x(n)-x(1)));
B = T_k(x2, i, j, M);

function T = T_k(x, i, j, M)
if j == 1
    T = 1;
elseif j == 2
    T = x;
else
    T = 2 * x * M(i, j-1) - M(i, j-2);
end


%Helper function for creating M matrix
function B_j = B(x, j, M)
if j== 1
    B_j = ones(length(x), 1);
elseif j == 2
    B_j = x;
else
    B_j = (2 * (x) .* M(:,j-1) - M(:,j-2));
end