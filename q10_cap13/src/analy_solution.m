%
% BASE FUNCTIONS
%

p1 = @(x,y) 10 - sqrt( x.^2 + y.^2 );
p2 = @(x,y) x .* p1(x,y);
p3 = @(x,y) y .* p1(x,y);

% partial derivatives
p1x = @(x,y) - x ./ sqrt( x.^2 + y.^2 );
p1y = @(x,y) - y ./ sqrt( x.^2 + y.^2 );

p2x = @(x,y) p1(x,y) + x .* p1x(x,y);
p2y = @(x,y) x .* p1y(x,y);

p3x = @(x,y) y .* p1x(x,y);
p3y = @(x,y) p1(x,y) + y .* p1y(x,y);

%
% Rayleigh-Ritz solution
%
% f = x; p = -1; q = 0, x,y in [0,10]
A = ones(3,3);

A(1,1) =  dblquad( @(x,y) - (p1x(x,y) .^2 + p1y(x,y) .^2) , 0,10, 0,10 );
A(2,2) =  dblquad( @(x,y) - (p2x(x,y) .^2 + p2y(x,y) .^2) , 0,10, 0,10 );
A(3,3) =  dblquad( @(x,y) - (p3x(x,y) .^2 + p3y(x,y) .^2) , 0,10, 0,10 );

A(1,2) =  dblquad( @(x,y) - (p1x(x,y) .* p2x(x,y) + p1y(x,y) .* p2y(x,y)) , 0,10, 0,10 ); A(2,1) =  A(1,2);
A(1,3) =  dblquad( @(x,y) - (p1x(x,y) .* p3x(x,y) + p1y(x,y) .* p3y(x,y)) , 0,10, 0,10 ); A(3,1) =  A(1,3);
A(2,3) =  dblquad( @(x,y) - (p2x(x,y) .* p3x(x,y) + p2y(x,y) .* p3y(x,y)) , 0,10, 0,10 ); A(3,2) =  A(2,3);

b = [ 0; 0; 0];

b(1) = dblquad ( @(x,y) x .* p1(x,y) , 0,10, 0,10 );
b(2) = dblquad ( @(x,y) x .* p2(x,y) , 0,10, 0,10 );
b(3) = dblquad ( @(x,y) x .* p3(x,y) , 0,10, 0,10 );

c = linsolve(A, b)

%
% Now using a quarter of the circle set for x,y
%
N = 100;
dy = 10/N;
_y = 0:dy:10;
bf_11 = bf_22 = bf_33 = zeros(1,N+1);
bf_12 = bf_13 = bf_23 = zeros(1,N+1);
bf_b1 = bf_b2 = bf_b3 = zeros(1,N+1);

for i = 0:N
  vy = dy * i;
  bf = sqrt(100 - vy^2);

  bf_11(i+1) = quad( @(x) -( p1x(x, vy) .^2 + p1y(x, vy) .^2 ) , 0, bf );
  bf_22(i+1) = quad( @(x) -( p2x(x, vy) .^2 + p2y(x, vy) .^2 ) , 0, bf );
  bf_33(i+1) = quad( @(x) -( p3x(x, vy) .^2 + p3y(x, vy) .^2 ) , 0, bf );

  bf_12(i+1) = quad( @(x) -(p1x(x, vy) .* p2x(x, vy) + p1y(x, vy) .* p2y(x, vy)), 0, bf );
  bf_13(i+1) = quad( @(x) -(p1x(x, vy) .* p3x(x, vy) + p1y(x, vy) .* p3y(x, vy)), 0, bf );
  bf_23(i+1) = quad( @(x) -(p2x(x, vy) .* p3x(x, vy) + p2y(x, vy) .* p3y(x, vy)), 0, bf );

  bf_b1(i+1) = quad( @(x) x .* p1(x, vy) , 0, bf );
  bf_b2(i+1) = quad( @(x) x .* p2(x, vy) , 0, bf );
  bf_b3(i+1) = quad( @(x) x .* p3(x, vy) , 0, bf );
end

A(1,1) = trapz( bf_11, _y);
A(2,2) = trapz( bf_22, _y);
A(3,3) = trapz( bf_33, _y);

A(1,2) = A(2,1) = trapz( bf_12, _y);
A(1,3) = A(3,1) = trapz( bf_13, _y);
A(2,3) = A(3,2) = trapz( bf_23, _y);

b(1) = trapz( bf_b1, _y);
b(2) = trapz( bf_b2, _y);
b(3) = trapz( bf_b3, _y);

c = linsolve(A, b)

% use fbi cmd to view the sol(x,y)ution on a pure terminal
% ffmpeg cmd: ffmpeg -framerate 30 -pattern_type glob -i '*.jpg' -c:v mpeg4 out.mp4
