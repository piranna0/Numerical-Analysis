function TestTime(i,j,t)
locI = Location(t, i)
locJ = Location(t, j)

[L, R] = TP(locJ, .6955)

vecJSL = [locJ.x - L.x, locJ.y - L.y]
vecJI = [locJ.x - locI.x, locJ.y - locI.y]

vecJSL / norm(vecJSL)
vecJI / norm(vecJI)



function z = transit(i, j, t, l)
locI = Location(t, i);
locJ = Location(t, j);

vecJI = [locJ.x - locI.x, locJ.y - locI.y];
[L, R] = TP(locJ, .6955);
if l
    vecJS = [locJ.x - L.x, locJ.y - L.y];
else
    vecJS = [locJ.x - R.x, locJ.y - R.y];
end

z = sinXY(vecJI, vecJS);

function theta = sinXY(x, y)
theta = (x(1)*y(2)-x(2)*y(1))/(norm(x)*norm(y));


function [L,R] = TP(E,r)
% Let C be the circle x^2+y^2 = r^2.
% E is a point outside of C
% L is a point on C with the property that the line through E and L is
% tangent to C.
% R is a point on C with the property that the line through E and R is
% tangent to C.
% To an observer at E, L is to the left of R.

d = sqrt(E.x^2+E.y^2); s = r/d; c = sqrt(1-s^2);
alfa = -(c*E.x-s*E.y); beta = -(+s*E.x+c*E.y);
f = sqrt(d^2-r^2)/sqrt(alfa^2+beta^2);
L = MakePoint(f*alfa+E.x,f*beta+E.y);
alfa = -(c*E.x+s*E.y); beta = -(-s*E.x+c*E.y);
f = sqrt(d^2-r^2)/sqrt(alfa^2+beta^2);
R = MakePoint(f*alfa+E.x,f*beta+E.y);

      
 function E = Location(t,k)
 % E is a length-n structure array with the property that
 % planet k is located at (E.x(i),E.y(i)) at time t(i), i=1:n.
 % (Time is in earth days.) 
 % If k=1, then Mercury's location is specified.
 % If k=2, then Venus's   location is specified.
 % If k=3, then Earth's   location is specified.
 % If k=4, then Mars's    location is specified.
 
 % Orbit parameters of the inner 4 planets...
 P = [  46.0032; 107.4819; 147.1053; 206.6782];
 A = [  69.8200; 108.9441; 152.1053; 249.2205];
 phi = [ 77.45645; 131.53298; 102.94719; 336.04084];
 Y   = [  87.968; 224.695; 365.242; 686.930];
 x = (P(k) - A(k))/2 + ((P(k)+A(k))/2)*cos(t*2*pi/Y(k));
 y = sqrt(P(k)*A(k))*sin(t*2*pi/Y(k));
 c = cos(phi(k)*pi/180);
 s = sin(phi(k)*pi/180);
 E = MakePoint(c*x-s*y,s*x+c*y);
 
function P = MakePoint(x,y)
% P is a 2-field structure with x assigned to P.x and y assigned to P.y.
P = struct('x',x,'y',y);