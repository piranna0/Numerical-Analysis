function Y = DCT8(X)
% X is an 8-by-m matrix
% Y = C*X where C is the 8-by-8 DCT matrix

Y=X;

% calculate T1 * x
Y(:,:) = [Y(1,:) + Y(8,:) ; Y(2,:) + Y(7,:) ; Y(3,:) + Y(6,:) ; Y(4,:) + Y(5,:) ;
          Y(1,:) - Y(8,:) ; Y(2,:) - Y(7,:) ; Y(3,:) - Y(6,:) ; Y(4,:) - Y(5,:) ];
 
% calculate T2 * u
Y(1:4,:) = [Y(1,:) + Y(4,:) ; Y(2,:) + Y(3,:) ; Y(1,:) - Y(4,:) ; Y(2,:) - Y(3,:)];
 
% calculate T3 * v
C = cos(pi * (1:7)/16);
row1 = [1 1];
row2 = [C(1) C(3) C(5) C(7)];
row3 = [C(2) C(6)];
row4 = [C(3) -C(7) -C(1) -C(5)];
row5 = [C(4) -C(4)];
row6 = [C(5) -C(1) C(7) C(3)];
row7 = [C(6) -C(2)];
row8 = [C(7) -C(5) C(3) -C(1)];

Y(:,:) = [row1 * Y(1:2, :) ; row2 * Y(5:8, :) ; 
          row3 * Y(3:4, :) ; row4 * Y(5:8, :) ; 
          row5 * Y(1:2, :) ; row6 * Y(5:8, :) ; 
          row7 * Y(3:4, :) ; row8 * Y(5:8, :) ];
end

