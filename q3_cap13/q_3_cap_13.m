% Questão 3, Cap 13 Variational Approximation Methods
p = @(x) 1;
q = @(x) 1;

f = @(x) 1 - x;

% Polinomial functions
phi_1 = @(x) 1;
phi_2 = @(x) x;
phi_3 = @(x) x^2;

phi_1_deriv = @(x) 0;
phi_2_deriv = @(x) 1;
phi_3_deriv = @(x) 2 * x;

A = ones(3,3);
% diagonal
A(1,1) =  quad( @(x) p(x) * phi_1_deriv(x)^2  +  q(x) * phi_1(x)^2,  0, 1);
A(2,2) =  quad( @(x) p(x) * phi_2_deriv(x)^2  +  q(x) * phi_2(x)^2,  0, 1);
A(3,3) =  quad( @(x) p(x) * phi_3_deriv(x)^2  +  q(x) * phi_3(x)^2,  0, 1);

A(2,1) = A(1,2) = quad( @(x) p(x) * phi_1_deriv(x) * phi_2_deriv(x)  +  q(x) * phi_1(x) * phi_2(x), 0, 1);
A(3,1) = A(1,3) = quad( @(x) p(x) * phi_1_deriv(x) * phi_3_deriv(x)  +  q(x) * phi_1(x) * phi_3(x), 0, 1);
A(2,3) = A(3,2) = quad( @(x) p(x) * phi_2_deriv(x) * phi_3_deriv(x)  +  q(x) * phi_2(x) * phi_3(x), 0, 1);

B = [ 0; 0; 0];
B(1) = quad (@(x) f(x) * phi_1(x), 0, 1);
B(2) = quad (@(x) f(x) * phi_2(x), 0, 1);
B(3) = quad (@(x) f(x) * phi_3(x), 0, 1);
disp(['Vector B:']);
disp(B);

c = linsolve(A, B);
disp(['Solution using polinomial functions:']);
disp(c);
disp(['Error:']);
disp(A * c - B);
