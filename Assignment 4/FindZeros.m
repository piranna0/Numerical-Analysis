function xRoots = FindZeros(alpha)
% alpha is a positive real number.
% xRoots is a column that houses all the roots (in left-to-right order) of the function
%
% f(x) sin(alpha*x) - x
%
% that occur in the interval [-1,1].

prev = pi / (2 * alpha);
next = 3 * pi / (2 * alpha); 
k = 3;

%Each zero must fall inbetween a max and min of the sign function
signPrev = sign(p(prev, alpha));
signNext = sign(p(next, alpha));

%Preallocates maximum space needed for xRoots based on 2 * frequency of sine
%wave
xRoots = zeros(ceil((alpha / pi)) + 1, 1);
i = 1;

%If both have the same sign then there are no more zeros
%Uses fzero to find the only root in the range between the local max/min of
%sin(alpha * x) - x
while signPrev ~= signNext && signPrev ~= 0
    posRoot = fzero(@(x) p(x,alpha),[prev, next]);
    i = i + 1;
    xRoots(i, 1) = posRoot;
    
    prev = next;
    k = k + 2;
    next = k * pi / (2 * alpha);
    
    signPrev = signNext;
    signNext = sign(p(next, alpha));
end

%Resizes xRoots to get rid of extra 0 values
xRoots = xRoots(1:i, 1);

%Zeros are symmetric so duplicate zeros on both sides.
xRoots = [-flipud(xRoots(2: length(xRoots), 1)); xRoots];

function z = p(x,a)
z = sin(a * x) - x;