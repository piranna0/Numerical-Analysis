function B = IJPEG(A)
% A is mxn JPEG-compressed matrix and B is its JPEG decompressed analog.
% Assumes that both m and n are divisible by 8.

Q = Quant();
 
%Undo division by Q
[m, n] = size(A);
R = kron(ones(m/8,n/8),Q);
B = A .* R;

%B * (C8 inverse transpose)
reshapeB = reshape(B, m*n/8, 8);
B = reshape(IDCT8(reshapeB')', m, n);

%(c8 inverse) * B
reshapeB = reshape(B, 8, m*n/8);
B = reshape(IDCT8(reshapeB), m, n);