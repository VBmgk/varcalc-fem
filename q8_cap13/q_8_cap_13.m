% Questão 13.8, Cap 13 Variational Approximation Methods
phi_1 = @(x) x * (1 - x);
phi_2 = @(x) x^2 * (1 - x);

phi_1_deriv = @(x) 1 - 2 * x;
phi_2_deriv = @(x) 2 * x - 3 * x^2;

p = @(x) 1;
q = @(x) -x;

f = @(x) x;


A = ones(2,2);
A(1,1) =  quad( @(x) phi_1_deriv(x)^2 + q(x) * phi_1(x)^2,
                0, 1
              );
A(2,1) =  quad( @(x) phi_1_deriv(x) * phi_2_deriv(x) - x * phi_1(x) * phi_2(x),
                0, 1
              );
A(1,2) =  A(2,1);
A(2,2) =  quad( @(x) phi_2_deriv(x)^2 + x * phi_2(x)^2,
                0, 1
              );

B = [ 0; 0];
B(1) = quad (@(x) f(x) * phi_1(x), 0, 1);
B(2) = quad (@(x) f(x) * phi_2(x), 0, 1);

c = linsolve(A, B);
disp(c);
