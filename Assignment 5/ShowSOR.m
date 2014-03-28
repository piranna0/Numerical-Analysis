  function ShowSOR()
% Checks out the SOR method on a couple of problems.
Region = {'S','L','C','D','A','H', 'B'} ; 
GridSize = 20;
close all
for k=1:7
    figure
    AnalyzeThis(Region{k},GridSize)
end
    
  function AnalyzeThis(R,g)
% Displays how omega affects the spectral radius associated with the SOR
% iteration when it is applied to the Laplacian defined by region R and 
% gridsize g. Possible values for R are 'S','L','C','D','A','H', or 'B'
m = 20;
omega = linspace(1,2,m);
rho = zeros(1,m);
G = numgrid(R,g);
subplot(1,2,1)
spy(G)
title('The Region','fontsize',16)
A = delsq(G);
subplot(1,2,2)
spy(A)
title('The Matrix','fontsize',16)
set(gcf,'position',[100 100 1400 600])

