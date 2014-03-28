function RandonSurveyor()

close all
% The True Topo Map...
m = 200;
n = 300;
A = TrueTopo(m,n);
contour(linspace(0,3,n+1),linspace(0,2,m+1),A,linspace(min(min(A)),max(max(A)),20))
title('The True Topo Map','fontsize',14)

% The Surveyor's Topo Map...
m = 30;
n = 45;
p = 50;
noise = 0.01;
%A = SurveyerTopo(m,n,p,noise,E(0,0));
A = TrueTopo(m,n);
MaxDiff = max(max(abs(A-TrueTopo(m,n))));
figure
contour(linspace(0,3,n+1),linspace(0,2,m+1),A,linspace(min(min(A)),max(max(A)),20))
title(sprintf('The Surveyor''s Topo Map    MaxDiff = %10.2e',MaxDiff),'fontsize',14)      
xlabel(sprintf('m = %1d     n = %1d     p=%1d     Noise = %5.3f',m,n,p,noise),'fontsize',14)

% Show the surveyor points...
figure(1)
hold on
m = 8; n = 12; hx = 3/n; hy = 2/m;
k = 0;
for i=0:m
    for j=0:n
        k = k+1;
        % The unknown elevation at this ooint is the kth unknown.
        plot(j*hx,i*hy,'*k','markersize',10)
    end
end
hold off
set(gca,'xtick',[0 .5 1 1.5 2 2.5 3],'ytick',[0 .5 1 1.5 2])
title('             ','fontsize',14)
shg


  function A = TrueTopo(m,n)
% A is an (m+1)-by-(n+1) matrix with the property that Elevation(x(j),y(i)) 
% is stored in A(i,j) where
x = linspace(0,3,n+1);
y = linspace(0,2,m+1);
A = zeros(m+1,n+1);
for i = 1:m+1
   for j=1:n+1
      A(i,j) = E(x(j),y(i));
   end
end
   
  function z = E(x,y)
% z is the elevation at (x,y). 
z = 100*exp( -2.4*(x-0.5)^2 - 7.2*(y-0.6)^2 ) +...
    150*exp( -5.2*(x-1.0)^2 - 4.7*(y-1.7)^2 ) +...
    150*exp( -3.2*(x-2.1)^2 - 6.7*(y-0.9)^2 ) +...
    200*exp( -5.8*(x-2.7)^2 - 1.2*(y-0.8)^2 );
  
    
  
    