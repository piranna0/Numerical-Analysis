function xRoots = FindZeros(alpha)
% alpha is a positive real number.
% xRoots is a column that houses all the roots (in left-to-right order) of the function
%
% f(x) sin(alpha*x) - x
%
% that occur in the interval [-1,1].

%Roots should be symmetric
xRoots = 0;

prev = pi / (2 * alpha);
next = 3 * pi / (2 * alpha); 
k = 3;

signPrev = sign(p(prev, alpha));
signNext = sign(p(next, alpha));

while signPrev ~= signNext && signPrev ~= 0
    posRoot = fzero(@(x) p(x,alpha),[prev, next]);
    xRoots = [xRoots; posRoot]; %Should preallocate then shrink
    prev = next; 
    k = k+2;
    next = k * pi / (2 * alpha);
    signPrev = sign(p(prev, alpha));
    signNext = sign(p(next, alpha));
end

xRoots = [-flipud(xRoots(2: length(xRoots), 1)); xRoots];

function z = p(x,a)
z = sin(a * x) - x;