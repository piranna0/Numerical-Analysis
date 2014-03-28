function [A,B] = TrigFit(t,y,N,P)
m = length(t)

%Y_n is a m x 2N matrix
Y_n = zeros(m, 2*N);

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

[Q,R] = qr(Y_n);