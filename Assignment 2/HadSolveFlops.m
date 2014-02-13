function N = HadSolveFlops(n)
% n is a power of 2.
% N is the number of flops required to solve an order-n Hadamard system.
if(n == 1)
    N = 0;
else
    % solveLeft/Right will be a 1xn/2  vector.
    % divide each element of solveLeft, solveRight by 2 (n work)
    % add solveLeft and solveRight (n/2 work)
    % subtract solveLeft and solveRight (n/2 work)
    N = 2 * HadSolveFlops(n/2) + 2*n;
end
    