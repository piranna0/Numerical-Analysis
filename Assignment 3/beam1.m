function d = Beam1(n)
% Takes in a integer n and returns the downward displacement of the 
% beam at x = k/n for k = 1:n 
d = ones(n,1)/n^4;

% Compute Ad = b

%y = inv(U') * b
d(n - 1) = 2 * d(n) + d(n - 1);
for i = n-2 : -1 : 2
    d(i) = d(i) + 2 * d(i + 1) - d(i + 2);
end
d(1) = (2 * d(2) - d(3)) / 2;

% d = inv(U) * y
d(1) = d(1) / 2;
d(2) = d(2) + 2 * d(1);
for i = 3 : n
    d(i) = d(i) + 2 * d(i - 1) - d(i-2);
end



% Take the 5x5 case:
%  9 -4  1  0  0
% -4  6 -4  1  0
%  1 -4  6 -4  1
%  0  1 -4  5 -2
%  0  0  1 -2  1
% c = 1/5^4
% 9d(1) - 4d(2) + d(3) = c
% -4d(1) + 6d(2) - 4d(3) + d(4)= c
% d(1) - 4d(2) + 6d(3) - 4d(4) + d(5)= c
% d(2) - 4d(3) + 5d(4) - 2d(5) = c
% d(3) - 2d(4) + d(5) = c

% We can assume that d(k) > 0 because it can't bend up against the force
% Assume that d = d(k) for all k
% From the last equation, assuming that our assumption holds,
% d(5) = d + c which breaks our assumption, so d(5) > d(4), d(3)
% From the second to last, d(4) = d + c/5
% From the third to last, d(3) = d + c/6

% I forgot about this comment til the last second and ran out of time,
% so this logic is not the best...