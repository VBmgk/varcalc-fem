%
% BASE FUNCTIONS
%
N = 60;
x = linspace (0, 10, N);
y = linspace (0, 10, N);

[ x_grid, y_grid ] = meshgrid(x,y);

% Base functions
for i = 1:N;
  for j = 1:N;
    if 10 >= sqrt( x_grid(i,j)^2 + y_grid(i,j)^2 )
      phi_1(i,j) = 10 - sqrt( x_grid(i,j)^2 + y_grid(i,j)^2 );
    else
      phi_1(i,j) = 0;
    end
  end
end

phi_2 = phi_1 .* x_grid;
phi_3 = phi_1 .* y_grid;

[ phi_1_x, phi_1_y ] = gradient(phi_1);
[ phi_2_x, phi_2_y ] = gradient(phi_2);
[ phi_3_x, phi_3_y ] = gradient(phi_3);

%
% FIGURE SETUP
%

h = figure();

% phi 1
subplot(2,3,1); surf(x,y, phi_1);
% img setup
view([1 1 1]); axis([0 10 0 10 0 30]); shading interp;
xlabel('x'); ylabel('y'); zlabel('phi_1(x,y)');
% ---> grad
subplot(2,3,4); contour (x_grid, y_grid, phi_1, 20);
hold on
%quiver(x_grid, y_grid, grad_phi_1_x, grad_phi_1_y, 'linestyle','--');
quiver(x_grid, y_grid, phi_1_x, phi_1_y, 0.5);
hold off

% phi 2
subplot(2,3,2); surf(x,y, phi_2);
% img setup
view([1 1 1]); axis([0 10 0 10 0 30]); shading interp;
xlabel('x'); ylabel('y'); zlabel('phi_2(x,y)');
% ---> grad
subplot(2,3,5); contour (x_grid, y_grid, phi_2, 20);
hold on
quiver(x_grid, y_grid, phi_2_x, phi_2_y, 0.5);
hold off

% phi 3
subplot(2,3,3); surf(x,y, phi_3);
% img setup
view([1 1 1]); axis([0 10 0 10 0 30]); shading interp;
xlabel('x'); ylabel('y'); zlabel('phi_3(x,y)');
% ---> grad
subplot(2,3,6); contour (x_grid, y_grid, phi_3, 20);
hold on
quiver(x_grid, y_grid, phi_3_x, phi_3_y, 0.5);
hold off

% file output setup
print(h, 'img/phis.jpg', '-landscape');

%
% Rayleigh-Ritz solution
%
% f = x; p = -1; q = 0
A = ones(3,3);

A(1,1) =  sum( sum( - (phi_1_x .* phi_1_x + phi_1_y .* phi_1_y) ) ) / (N * N);
A(2,2) =  sum( sum( - (phi_2_x .* phi_2_x + phi_2_y .* phi_2_y) ) ) / (N * N);
A(3,3) =  sum( sum( - (phi_3_x .* phi_3_x + phi_3_y .* phi_3_y) ) ) / (N * N);

A(1,2) =  sum( sum( - (phi_1_x .* phi_2_x + phi_1_y .* phi_2_y) ) ) / (N * N); A(2,1) =  A(1,2);
A(1,3) =  sum( sum( - (phi_1_x .* phi_3_x + phi_1_y .* phi_3_y) ) ) / (N * N); A(3,1) =  A(1,3);
A(2,3) =  sum( sum( - (phi_2_x .* phi_3_x + phi_2_y .* phi_3_y) ) ) / (N * N); A(3,2) =  A(2,3);

b = [ 0; 0; 0];

b(1) = sum ( sum ( x_grid .* phi_1 ) ) / (N * N);
b(2) = sum ( sum ( x_grid .* phi_2 ) ) / (N * N);
b(3) = sum ( sum ( x_grid .* phi_3 ) ) / (N * N);

c = linsolve(A, b)

u_sol = c(1) * phi_1 + c(2) * phi_2 + c(3) * phi_3;

% TODO: plot solution
h_u = figure();
surf(x,y, u_sol);
% img setup
view([1 1 -1]); axis([0 10 0 10 min(min(u_sol)) max(max(u_sol))]); shading interp;

% file output setup
print(h_u, 'img/solution.jpg', '-landscape');

% use fbi cmd to view the solution on a pure terminal
% ffmpeg cmd: ffmpeg -framerate 30 -pattern_type glob -i '*.jpg' -c:v mpeg4 out.mp4
