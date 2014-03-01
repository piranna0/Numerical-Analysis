  function ShowNegCurve()
% Checks out NegativeCurvature
clc
% Generate a random symmetric matrix..G
n = 100;
A = randn(n,n);
A = A' + A;
x = NegativeCurvature(A);
if length(x) == n;
    alfa = x'*A*x;
end
fprintf('If x = NegativeCurvature(A), then x''Ax = %10.3f\n',alfa)
