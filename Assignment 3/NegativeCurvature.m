function x = NegativeCurvature(A)
% A is an nxn symmetric matrix. If A is positive definite then
% x is the empty vector. Otherwise, x is a unit 2-norm n-vector with the
% property that x’*Ax <= 0.

[L,D,P,k] = LDLTpiv(A);
n = length(A);

if k == n+1
    x = [];
else
% x'Ax <=0
% A = P'LDL'P
% Since A and D congruent we want:
% x'Ax = x'P'LDL'Px = w'Dw <= 0 and w = L'Px

% We know that D(k,k) <= 0
% To get D(k,k) use I(:, k)' * D * I(:, k)
% Then x = P' * L \ w = P' * (L \ I(:, k))
    I = speye(n,n);
    x = P' * (L \ I(:, k));
    
end