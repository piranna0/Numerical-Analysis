  function ShowNegCurve()
% Checks out NegativeCurvature
clc
% Generate a random symmetric matrix..G
n = 100;
A = randn(n,n);
A = A' + A;
x = NegativeCurvature(A);
x2 = NegativeCurvature2(A);
if length(x) == n;
    alfa = x'*A*x;
end
if length(x2) == n;
    alfa = x2'*A*x2;
end
fprintf('If x = NegativeCurvature(A), then x''Ax = %10.3f\n',alfa)
fprintf('If x2 = NegativeCurvature(A), then x2''Ax2 = %10.3f\n',alfa)
