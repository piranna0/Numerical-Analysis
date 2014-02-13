function B = JPEG(A)
% A is an mxn picture matrix and B is its mxn JPEG-compressed analog.
% Assumes that both m and n are divisible by 8.

Q = Quant();
 
%Reshape A to vectorize
[m, n] = size(A);
reshapeA = reshape(A, 8, m*n/8);

%Perform DCT8 on both columns and rows
dctCol = reshape(DCT8(reshapeA), m, n);
reshapeA = reshape(dctCol, m*n/8, 8);

dctRow = DCT8(reshapeA')';
dctFinal = reshape(dctRow, m, n);
%Get the size of the A matrix to create R
R = kron(ones(m/8,n/8),Q);

B= round(dctFinal ./ R);