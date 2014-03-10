function [xStar,yStar,ThetaStar] = Sideline(a,b,d,w)
% a, b, c, d are positive real numbers with the property that goalpost locations
% P1 = (-d,-w/2) and P2 = (-d,w/2) are inside the ellipse (x/a)^2 + (y/b)^2 = 1.
% Q = (xStar,yStar) is a point on the ellipse with the property that
% angle P1-Q-P2 is maximized subject to the constraint that a player standing at Q
% is looking into the goal. ThetaStar is the maximum angle in degrees.

% There can be two local maxima. One on either side (by x coord) of the
% goal post. The goal post must be the global minimum. 
% Use fminbnd on each side to find the global maximum.
tMin = acos(-d / a);
t1 = fminbnd(@(t) -angle(a,b,d,w,t), 0, tMin);
t2 = fminbnd(@(t) -angle(a,b,d,w,t), tMin, pi);

% Choose t1 or t2 based on largest angle. Store maximum in t1 and t1Angle
t1Angle = angle(a, b, d, w, t1);
t2Angle = angle(a, b, d, w, t2);
if t1Angle < t2Angle
    t1 = t2;
    t1Angle = t2Angle;
end

xStar = xCoord(t1, a);
yStar = yCoord(t1, b);
ThetaStar = t1Angle * 180 / pi;

% Function used in fminbnd calculation. Calculates angle created with goal
% using input t. Computes theta using acos(dot(a,b) / |a||b|)
function z = angle(a, b, d, w, t)
x = xCoord(t, a);
y = yCoord(t, b);
P1 = [-d, -w/2];
P2 = [-d, w/2];
P3 = [x, y];

P31 = P3 - P1;
P32 = P3 - P2;

dotProd = dot(P31, P32);
magP31 = norm(P31);
magP32 = norm(P32);

z = acos(dotProd / (magP31 * magP32));

% Calculates the x coordinate along the elipse
function x = xCoord(t, a)
x = a * cos(t);

% Calculates the y coordinate along the elipse
function y = yCoord(t, b)
y = b * sin(t);