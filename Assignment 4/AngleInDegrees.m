function z = AngleInDegrees(a, b, d, w, t)
angle = Angle(a, b, d, w, t);
z= angle * 180 / pi;


function z = Angle(a, b, d, w, t)
x = xCoord(t, a);
y = yCoord(t, b);
P1 = [-d, -w/2];
P2 = [-d, w/2];
P3 = [x y];

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