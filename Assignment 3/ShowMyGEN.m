function ShowMyGEN()
% Illustrates Matlab's sparse LU capabilities using examples
% from the UF sparse matrix collection.

% Assumes that the .mat files associated with these examples are
% in the current working directory.
% Get the matrix, which will be in sparse format...
A = GetMatrix('MyGEN.mat');
[n,n] = size(A);
fprintf('UFID: %1d\n', 371)
fprintf('n: %1d\n', n);
x = ones(n,1);
AOnes = A * x;
thresh = [.1 .001];
% Compute the factorization P*inv(D)*A*Q = LU where L is unit lower
% triangular, U is upper triangular, P is a permutation,
% Q is a permutation, and D is a diagonal scaling matrix
% A = DP'LUQ'
tic;
[L,U,P,Q,D] = lu(A,thresh);
tLUPivotFactor = toc;

tic
xLUPivot = Q * (U \ (L \(P * (D \ AOnes))));
tLUPivotSolve = toc;

err = norm(x - xLUPivot)/norm(x);
fprintf('LU Factorization threshold pivoting: relativeError = %10.3e\n',err);
fprintf('LU Factorization threshold pivoting: timeToFactor = %10.3e\n',tLUPivotFactor);
fprintf('LU Factorization threshold pivoting: timeToSolve = %10.3e\n',tLUPivotSolve);

% Each output matrix is in sparse format.
% Display A, PAQ, L and U...
subplot(2,2,1), spy(A), title(sprintf('A  UFid = %1d',371),'FontSize',14)
set(gca,'yticklabel',[],'xticklabel',[])
set(get(gca,'xlabel'),'fontsize',16)
subplot(2,2,2), spy(P*A*Q), title(sprintf('P*A*Q'),'FontSize',14)
set(gca,'yticklabel',[],'xticklabel',[])
set(get(gca,'xlabel'),'fontsize',16)
subplot(2,2,3), spy(L), title(sprintf('L'),'FontSize',14)
set(gca,'yticklabel',[],'xticklabel',[])
set(get(gca,'xlabel'),'fontsize',16)
subplot(2,2,4), spy(U),title(sprintf('U'),'FontSize',14)
set(gca,'yticklabel',[],'xticklabel',[])
set(get(gca,'xlabel'),'fontsize',16)
shg
pause