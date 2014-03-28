  function Show2CholInc()
% Illustrates pcg with various incomplete Cholesky preconditioners
close all

% Generate an example...
m = 60;
A = delsq(numgrid('L',m));
[n,n] = size(A);
b = randn(n,1);

% If A approx GG' then inv(G)*A*inv(G)' approx I . This fact can
% be used to accelerate the method of congugate gradient. In this context,
% G is said to be a preconditioner. Let's check this out.

% Key parameters for the preconditioned congugate gradient method...
% Maximum number of iterations...
itMax = 100;
% Stop if || Ax - b||/||b| <= tol
tol = .00000000001;

for p = [0 5 10 20]
   G  = cholincMem(A,p);
   figure
   spy(G)
   title(sprintf('G = cholincMem(A,%1d)  n = %1d   nnz(G) = %1d',p,n,nnz(G)),'fontsize',14)
   tic
   [x,flag,relres,itLast,resVec] = pcg(A,b,tol,itMax,G,G');
   t = toc;
   xlabel(sprintf('itLast = %1d    t = %5.3f',itLast,t),'fontsize',14)
end

% Without any preconditioner (i.e., G = I)
G  = speye(n);
figure
spy(G)
title('G = I','fontsize',14)
tic
[x,flag,relres,itLast,resVec] = pcg(A,b,tol,1000,G,G');
t = toc;
xlabel(sprintf('itLast = %1d    t = %5.3f',itLast,t),'fontsize',14)

clc
% Compare the times for computing G two ways
m = 30;
A = delsq(numgrid('L',m));
[n,n] = size(A);
fprintf('n = %1d\nnnz(A) = %1d\n\n',n,nnz(A))
tic 
G  = cholincMem(A,8);
kappa = condest(G\(G\A)');
tMem = toc;
fprintf('G  = cholincMem(A,8)\n')
fprintf('  time = %5.3f\n  nnz(G) = %1d\n  condest(inv(G)*A*inv(G)'') = %5.2f \n\n',tMem,nnz(G),kappa)

tic 
G  = cholincDrop(A,.001);
kappa = condest(G\(G\A)');
tDrop = toc;
fprintf('G  = cholincDrop(A,.001)\n')
fprintf('  time = %5.3f\n  nnz(G) = %1d\n  condest(inv(G)*A*inv(G)'') = %5.2f\n\n',tDrop,nnz(G),kappa)


  function G = cholincDrop(A,delta)
% A is nxn, symmetric, and positive definite in sparse format
% G is an incomplete lower triangular cholesky factor in sparse format
% If delta = '0' then spy(G) and spy(tril(A)) look the same.
% Otherwise, delta>0 and insignificant G(i,j) are set to zero.
[n,n] = size(A);
v = zeros(n,1);
G = sparse(n,n);
for j=1:n
    % Compute the j-th column of G...
    v(j:n) = A(j:n,j) - G(j:n,1:j-1)*G(j,1:j-1)';
    G(j,j) = v(j)/sqrt(v(j));
    if isstr(delta)
        % delta is '0' and so G should inherit A's sparsity...
        for i=j+1:n
           if A(i,j) ~=0
              G(i,j) = v(i)/G(j,j);
           end
        end
    else
        % tau is the "definition" of being insignificant where...
        tau = delta*norm(A(j:n,j))/G(j,j);
        for i=j+1:n
           Gij = v(i)/G(j,j);
           if abs(Gij)>=tau
              % Gij is not insignificant...
              G(i,j) = Gij;
           end
        end
    end
end
   
   





