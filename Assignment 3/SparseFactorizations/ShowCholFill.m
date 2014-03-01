  function ShowCholFill()
% Shows the effect of ordering on the density of the Cholesky factor.
% In particular, here is a small example that dramatizes the
% diffence between A = GG^T and PAP' = G1*G1^T for a well chosen
% permutation matrix P...

clc
A = [ 9   5  4  3  2  1;...
      5   8  0  0  0  0;...
      4   0  7  0  0  0;...
      3   0  0  6  0  0;...
      2   0  0  0  5  0;...
      1   0  0  0  0  1]
format short
G = chol(A,'lower')
% Let us swap the first and last rows (and columns)...
P = eye(6,6); 
P([1 6],:) = P([6 1],:)
A1 = P*A*P'
G1 = chol(A1,'lower')