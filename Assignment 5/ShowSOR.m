function ShowSOR()
% Checks out the SOR method on a couple of problems.
Region = {'S','L','C','D','A','H', 'B'} ;
GridSize = 30;
close all
    for k=1:7
        figure
        AnalyzeThis(Region{k},GridSize)
    end
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
%Added code after here

L = tril(A, -1);   %from assignment pdf
D = diag(diag(A)); %from assignment pdf
for i = 1:length(omega)
    M_w = (1. / omega(i)) * D + L;        %lower triangular
    N_w = ((1. / omega(i)) - 1) * D - L';  %upper triangular
    
    %inv(M) * N = Z
    %MZ = N
    %Z = M \ N
    Z = M_w \ N_w;
    rho(i) = max(abs(eig(full(Z))));
end
%End of added code

subplot(1,2,2)
plot(rho)
title('Spectral radii','fontsize',16)
set(gcf,'position',[100 100 1400 600])
end