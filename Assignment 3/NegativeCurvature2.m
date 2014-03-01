  function x = NegativeCurvature2(A)
% A is an nxn symmetric matrix. If A is positive definite then
% x is the empty vector. Otherwise, x is a unit 2-norm n-vector with the
% property that x'*Ax <= 0.

  [n,n] = size(A);
  [L,D,P,k] = LDLTpiv(A);
  if k==n+1
      x = [];
  else
      % Since A = P'LDL'P we want to find a vector z so that
      %    z'*A*z = z'P'LDL'Pz = u'Du < 0 where u = L'Pz. 
      % Since ek'*D*ek = D(k,k) < 0 where ek = I(:,k), we want to
      % solve L'Pz = ek for z.
      z = P'*[L(1:k,1:k)\[zeros(k-1,1);1];zeros(n-k,1)];
      I = eye(n,n);
      ek = I(:,k);
      z = P'*(L'\ek);
      
      x = z/norm(z);
  end