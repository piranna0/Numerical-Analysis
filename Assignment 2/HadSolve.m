function x = HadSolve(b)
% b is a columnn-vector and n is a power of 2.
% Solves the nxn Hadamard system Hn*x = b
s = length(b);
if s == 1
    x = b;
else
    xLeft = HadSolve(b(1:s/2))./2;
    xRight = HadSolve(b(s/2+1:s))./2;
    x = [xLeft + xRight; xLeft - xRight];
end