  function [L,D,P,k] = LDLTpiv(A)
% A is an nxn symmetric matrix.
% k is an integer that satisfies 1<=k<=n.
% If k==n+1, then A is positive definite and PAP' = LDL' where P is a permutation
%    matrix, L is unit lower triangular, and D is diagonal.
% Otherwise, A is not positive definite and PAP' = LDL' where P is a
%    permutation matrix, L is unit lower triangular with L(k:n,k:n) = eye(n-k+1,n-k+1);
%    and D(1:k-1,1:k-1) is diagonal with positive diagonal entries and D(k,k)<=0.

n = length(A);
P = eye(n,n);
k=1;
[alfa,tau] = max(diag(A));
while k<n && alfa>0
    % Move the largest of the remaining diagonal entries into the (k,k)
    % position..
    j = tau+k-1; 
    P([k j],:) = P([j k],:);
    A([k j],:) = A([j k],:);
    A(:,[k j]) = A(:,[j k]);
    % Perform the rank-1 update...
    alfa = A(k,k);
    rows = k+1:n;
    v = A(rows,k);
    A(rows,k) = v/alfa;
    A(rows,rows) = A(rows,rows) - v*v'/alfa;
    k = k+1;
    [alfa,tau] = max(diag(A(k:n,k:n)));
end
% Extract L and D from A...
L = eye(n,n);
for j=1:k-1
    L(j+1:n,j) = A(j+1:n,j);
end
D = diag(diag(A));
if k==n && A(n,n)>0
   k=n+1;
else
   D(k:n,k:n) = A(k:n,k:n);
end