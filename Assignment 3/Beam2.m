function [d, condA] = Beam2(n)

% Will not work for n = 2 case, but that does not seem to be 
% defined for this problem

%Set up sparse matrix An using spdiags and compute its upper triangular
Bn = zeros(n, 5);
Bn(1:n-2, 1) = 1;
Bn(1:n-2, 2) = -4;
Bn(n-1, 2) = -2;
Bn(2:n, 4) = Bn(1:n-1, 2);
Bn(3:n, 5) = Bn(1:n-2, 1);
Bn(1, 3) = 9;
Bn(2:n-2, 3) = 6;
Bn(n-1 : n, 3) = [5, 1];
d = [-2, -1, 0, 1, 2];

An = spdiags(Bn,d, n, n);
triuAn = triu(An);

%Get the cholesky factorization
R = chol(triuAn);
Rt = R';

d = ones(n,1)/n^4;

%Solve for d. Since R, Rt are triangular we can use \ to solve
d = Rt \ d;
d = R \ d;

%Use condest to estimate condition
condA = condest(An);