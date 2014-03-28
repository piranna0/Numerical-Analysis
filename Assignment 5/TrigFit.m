function [A,B] = TrigFit(t,y,N,P)
m = length(t);

%Y_n is a m x 2N matrix
Y_n = zeros(m, 2*N);

% yMat is an m x N matrix that is the column y repeated N times
yMat = repmat(y, 1, N);

% Structure of Y_n:
% |cos(t_1, j_1)... cos(t_1, j_N) sin(t_1, j_1)...sin(t_1,j_N)
% |cos(t_2, j_1)... cos(t_2, j_N) sin(t_2, j_1)...sin(t_2,j_N)
% |                         .
% |                         .
% |                         .
for j = 1:N
    Y_n(:, j) = cos(2*pi*j*t/P);
    Y_n(:, N+j) = sin(2*pi*j*t/P);
end

% Solve QR. AB is a 2N x N matrix with the
% upper half the A matrix, lower half B matrix
[Q,R] = qr(Y_n);
AB = R \ (Q' * yMat);

% Extract A and B matrices
A = AB(1:N, 1:N);
B = AB(N+1:2*N, 1:N);