% Script: ShowRange2
% Shows what happens when a 2x2 matrix A is applied
% to the set of all vectors that satisfy norm(x,2)<=1

% Ten examples...
%for eg=1:10
   % Generate a random 2x2..
   A = randn(2,2);
 % Display the set S of all vectors x for which norm(x,2)<=1
   subplot(1,2,1)
   theta = linspace(0,pi/2,200);
   tempC = cos(theta).^2;
   tempCrev = tempC(end:-1:1);
   tempS = sin(theta).^2;
   tempSrev = tempS(end:-1:1);
   c = [tempC -tempCrev -tempC tempCrev];
   s = [tempS tempSrev -tempS -tempSrev];
   fill(c,s,'y','linewidth',2)
   hold on
   plot([-1.2 1.2],[0 0],':k',[0 0],[-1.2,1.2],':k')
   hold off
   axis equal
   axis([-2.5 2.5 -2.5 2.5])
   grid on
   title('The Set S_{2}','fontsize',18)
   % Display the set of all vectors y where y = A*x and x is in S
   subplot(1,2,2)
   Z = A*[c;s];
   y1Vals = Z(1,:);
   y2Vals = Z(2,:);
   fill(y1Vals,y2Vals,'c','linewidth',2)
   hold on
   plot([min(y1Vals) max(y1Vals)],[0 0],':k',[0 0],[min(y2Vals),max(y2Vals)],':k')
   hold off
   axis equal
   axis([-2.5 2.5 -2.5 2.5])
   grid on
   title('The Set Im(S_{2})','fontsize',18)
   set(gcf,'position',[100 100 1200 600])
   xlabel(sprintf('A = [%5.2f  %5.2f ; %4.2f  %5.2f]',A(1,1), A(1,2), A(2,1), A(2,2)),'fontsize',14)
   shg
   pause(1)
%end