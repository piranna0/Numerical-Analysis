function [xStar,yStar,ThetaStar] = Sideline(a,b,d,w)
% a, b, c, d are positive real numbers with the property that goalpost locations
% P1 = (-d,-w/2) and P2 = (-d,w/2) are inside the ellipse (x/a)^2 + (y/b)^2 = 1.
% Q = (xStar,yStar) is a point on the ellipse with the property that
% angle P1-Q-P2 is maximized subject to the constraint that a player standing at Q
% is looking into the goal. ThetaStar is the maximum angle in degrees.

% There can be two local maxima. One on either side (by x coord) of the
% goal post (minimum). Use fminbnd on each side to find the global maximum.
tMin = acos(-d / a);
t1 = fminbnd(@(t) -angle(a,b,d,w,t), 0, tMin);
t2 = fminbnd(@(t) -angle(a,b,d,w,t), tMin, pi);

% Choose t1 or t2. Store maximum in t1
t1Angle = angle(a, b, d, w, t1);
t2Angle = angle(a, b, d, w, t2);
if t1Angle < t2Angle
    t1 = t2;
end

xStar = xCoord(t1, a);
yStar = yCoord(t1, b);
ThetaStar = t1Angle * 180 / pi;

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


function z = xCoord(t, a)
z = a * cos(t);

function z = yCoord(t, b)
z = b * sin(t);