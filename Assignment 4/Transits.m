function [StartTime,Duration] = Transits(i,j,T)
% i is the inner planet
% j is the outer plant

% Starting location and period from Location.m
phi = [ 77.45645; 131.53298; 102.94719; 336.04084];
Y   = [  87.968; 224.695; 365.242; 686.930]; %Days per 360 degrees

phi = phi([i j]);
Z   = 360 ./ Y([i j]);  % Degrees per day

% Z = Degrees per day
% Phi = degrees at start
% I will assume circular orbits for my bounding interval
% So every day the planets will get approximately Z(i) - Z(j) degrees
% closer in orbit. Since the orbits are not circular, I assume I am off by
% at most 1/4 of these days in either direction,  to get my bounding interval.

degreesToGo = phi(2) - phi(1);
if degreesToGo < 0
    degreesToGo = 360 + degreesToGo;
end

k = 1;
sameT = 0; %Time that orbits are in same line

% Find transits until sameT > T
while true
    timeToGo = degreesToGo / (Z(1) - Z(2));
    sameT = fzero(@(t) transit(i, j, t, true),[sameT + timeToGo* 3./4., sameT + timeToGo* 5./4.]);
    if sameT > T
        break;
    end
    StartTime(k,1) = sameT;
    EndTime = fzero(@(t) transit(i, j, t, false),[sameT - 1, sameT + 1]);
    Duration(k,1) = (EndTime - sameT) * 24.;
    
    degreesToGo = 360;
    k = k+1;
end



% Function used by fzero
% i, j are the planet indices
% t is the time in number of days
% l is a boolean: true = left transit, false = right transit
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

% Calculate sin(theta)
function sinTheta = sinXY(x, y)
sinTheta = (x(1)*y(2)-x(2)*y(1))/(norm(x)*norm(y));


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