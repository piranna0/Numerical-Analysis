  function HadCheck()
% Checks out HadSolve and HadSolveFlops
% Explicitly generate H_{32}...
H = 1;
p = 5;
for k=1:p
    H = [H H; H -H];
end
% Generate a random right hand side...
b = randn(2^p,1);
% Solve using H, solve using HadSO\olve and compare
clc
fprintf('Error = %10.3e\n\n\n',norm(H\b - HadSolve(b)));

% Examine flop counts...
fprintf('        n          #Flops    #Flops/(nlog2(n))  \n')
fprintf('---------------------------------------------------------\n')
for q=1:20
    n = 2^q;
    fprintf('%10d   %10d         %5.2f\n',n,HadSolveFlops(n),HadSolveFlops(n)/(n*log2(n)))
end


