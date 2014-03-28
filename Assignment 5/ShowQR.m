  function ShowQR()
% Properties of the QR factorization
clc
format short
m = 5;
n = 3;
A = randn(m,n)

% The full factorization...
clc
disp('[Q,R] = qr(A)')
[Q,R] = qr(A)
% Q (mxm) is orthogonal, R (mxn) is upper triangular so A = QR...
fprintf('||  A - Q*R || = %10.3e\n',norm(A - Q*R))
fprintf('|| Q''*Q - I || = %10.3e\n',norm(Q'*Q - eye(m)))
pause

% Column relationships
clc
disp('A(:,j) is in the span of Q(:,1),...Q(:,j)')
for j=1:n
    % A(:,j) is in the span of Q(:,1),...,Q(:,j)..
    fprintf('|| A(:,%1d) - Q(:,1:%1d)*R(1:%1d,%1d) || = %10.3e\n',j,j,j,j,norm(A(:,j) - Q(:,1:j)*R(1:j,j)))
end
pause

% The "thin" QR factorization
clc
disp('[Q1,R1] = qr(A,0)')
A = A
[Q1,R1] = qr(A,0)
% Q1 (mxn) has orthonormal columns, R1 (nxn) is upper triangular so 
% A = Q1*R1...
fprintf('||  A - Q1*R1 || = %10.3e\n',norm(A - Q1*R1))
fprintf('|| Q1''*Q1 - I || = %10.3e\n',norm(Q1'*Q1 - eye(n)))
pause


% Comparing qr(A) and qr(A,0)...
clc
disp('Comparing qr(A) and qr(A,0)')
Q = Q
Q1 = Q1
R = R
R1 = R1