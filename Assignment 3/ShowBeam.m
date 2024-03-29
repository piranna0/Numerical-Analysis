  function ShowBeam()
 % Checks out the implementations of Beam1 and Beam2
 n = 1000;
 d1 = Beam1(n);
 [d2,condA] = Beam2(n);
 err = norm(d1-d2)/norm(d1);
 close all
 plot([0 1],[0 0],'r',linspace(0,1,n)',-d2)
 axis([0 1 -max(abs(d2)) +max(abs(d2))])
 title(sprintf('n = %1d         || d1 - d2 || / || d1 ||  =  %10.3e       condest(A) = %10.2e',n,err,condA),'fontsize',14)
 xlabel(sprintf('d1(n) = %12.8f    d2(n) = %12.8f',d1(n),d2(n)),'fontsize',14)
 ylabel('Negative Displacement','fontsize',14)
 set(gcf,'position',[100,100,1000,700])
 shg
