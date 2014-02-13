  function ShowSigUVn()
% Checks out the reliability of SigUVn
% The dimension of the problem. 
n = 200;
% Number of test cases. The bigger this is the more reliable the results.
% This is a small value so things run quickly..
nEg = 10;
clc
fprintf('n = %1d\n\n',n)
fprintf('sigma/sigma_n is always >= 1. The closer to 1 the better.\n')
fprintf('|u''*U(:,n)| = cosine angle betwen u and U(:,n). The closer to 1 the better.\n')
fprintf('|v''*v(:,n)| = cosine angle betwen v and V(:,n). The closer to 1 the better.\n')
fprintf('\n')
fprintf('\nWe fix nRepeat and sigma(n-1)/sigma(n) and then run %1d examples\n',nEg)
fprintf('\n\nsigmaRat = sigma/sigma_n    (largest value over all examples) \n')
fprintf('ucos = |u''*U(:,n)|          (smallest value over all examples) \n')
fprintf('vcos = |v''*V(:,n)|          (smallest value over all examples) \n\n')

disp('sigma(n-1)/sigma(n)    nRepeat     sigmaRat       ucos      vcos')
disp('------------------------------------------------------------------')
for factor = [1.05  1.1  1.5]
   for nRepeat=1:10
      sRatioVec = zeros(nEg,1);
      uCosVec = zeros(nEg,1);
      vCosVec = zeros(nEg,1);
      for eg=1:nEg
         A = randn(n,n);
         [U,S,V] = svd(A);
         S(n,n) = S(n-1,n-1)/factor;
         A = U*S*V';
         [sigma,u,v] = SigUVn(A,nRepeat);
         sRatioVec(eg) = sigma/S(n,n);
         uCosVec(eg) = abs(u'*U(:,n));
         vCosVec(eg) = abs(v'*V(:,n));
      end
      fprintf('  %7.3f       %12d     %10.5f  %10.5f %10.5f\n',...
               factor,nRepeat,max(sRatioVec),min(uCosVec),min(vCosVec))
   end
   fprintf('\n')
end
          
         
 
 