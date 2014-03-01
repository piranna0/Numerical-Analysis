function ShowMySPD()
% Illustrates Matlab's sparse Cholesky capabilities using examples
% from the UF sparse matrix collection.

SPD_Indices = [1 2 3 4 35 36 45 67 219];
% Assumes that the .mat files associated with these examples are
% in the current working directory.
% Get the matrix, which will be in sparse format.
A = GetMatrix('MySPD.mat');
[n,n] = size(A);
fprintf('UFID: %1d\n', 1214);
fprintf('n: %1d\n', n);
x = ones(n,1);
AOnes = A * x;

% Cholesky....
tic;
G = chol(A,'lower');
tCholFactor= toc;
% A = G*G' where G is lower triangular and in sparse format.
tic;
xChol = G'\(G\AOnes);
tCholSolve = toc;

err = norm(x - xChol)/norm(x);
fprintf('Cholesky Factorization: relativeError = %10.3e\n',err);
fprintf('Cholesky Factorization: timeToFactor = %10.3e\n',tCholFactor);
fprintf('Cholesky Factorization: timeToSolve = %10.3e\n',tCholSolve);

% Cholesky with approximate minimum degree pre-ordering...
tic;
[G1,flag,P1] = chol(A,'lower');
tCholPivotFactor = toc;

% P1'*A*P1 = G1*G1'  where G1 is lower triangular and P1 is a
% A = P1*G1*G1'*P1'
% permutation. G1 and P1 are in sparse format. (flag can signals
% indefiniteness--ignore.)
tic;
xCholPivot = P1* (G1'\(G1\(P1' * AOnes)));
tCholPivotSolve = toc;

err = norm(x - xCholPivot)/norm(x);
fprintf('Cholesky Factorization Pivot: relativeError = %10.3e\n',err);
fprintf('Cholesky Factorization Pivot: timeToFactor = %10.3e\n',tCholPivotFactor);
fprintf('Cholesky Factorization Pivot: timeToSolve = %10.3e\n',tCholPivotSolve);

% Cholesky with reverse Cuthill--McKee preordering...
% Get the ordering...
tic
q = symrcm(A);
% Represent in sparse format...
I = speye(n); P2 = I(:,q);
% Compute P2'*A*P2 = G2*G2'
G2 = chol(P2'*A*P2,'lower');
tCholCMFactor = toc;

tic;
xCholCM = P2*(G2'\(G2\(P2' * AOnes)));
tCholCMSolve = toc;

err = norm(x - xCholCM)/norm(x);
fprintf('Cholesky Factorization Chuthill-McKee: relativeError = %10.3e\n',err);
fprintf('Cholesky Factorization Chuthill-McKee: timeToFactor = %10.3e\n',tCholCMFactor);
fprintf('Cholesky Factorization Chuthill-McKee: timeToSolve = %10.3e\n',tCholCMSolve);


% Now display the associated sparsity patterns..
subplot(2,3,1), spy(A), title(sprintf('A       UFid = %1d',1214),'FontSize',14)
set(gca,'yticklabel',[],'xticklabel',[])
set(get(gca,'xlabel'),'fontsize',16)
subplot(2,3,4), spy(G), title('Cholesky Factor','FontSize',14)
set(gca,'yticklabel',[],'xticklabel',[])
set(get(gca,'xlabel'),'fontsize',16)
subplot(2,3,2), spy(P1*A*P1'), title('P''AP via amd','FontSize',14)
set(gca,'yticklabel',[],'xticklabel',[])
set(get(gca,'xlabel'),'fontsize',16)
subplot(2,3,5), spy(G1), title('Cholesky Factor','FontSize',14)
set(gca,'yticklabel',[],'xticklabel',[])
set(get(gca,'xlabel'),'fontsize',16)
subplot(2,3,3), spy(A(q,q)), title('P''AP via symrcm','FontSize',14)
set(gca,'yticklabel',[],'xticklabel',[])
set(get(gca,'xlabel'),'fontsize',16)
subplot(2,3,6), spy(G2), title('Cholesky Factor','FontSize',14)
set(gca,'yticklabel',[],'xticklabel',[])
set(get(gca,'xlabel'),'fontsize',16)
shg
pause(1)



