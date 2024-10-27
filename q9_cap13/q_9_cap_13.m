% Questão 9, Cap 13 Variational Approximation Methods
p = @(x) 1;
q = @(x) (1 + x^2);

f = @(x) x^2;
tol = 1.0e-9;
% boundary conditions
% u'(0) = u'(1) = 0

%
% Polinomial functions using quad to integrate
%
phi_1 = @(x) 1;
phi_2 = @(x) x;
phi_3 = @(x) x^2;

phi_1_deriv = @(x) 0;
phi_2_deriv = @(x) 1;
phi_3_deriv = @(x) 2 * x;

A = ones(3,3);
% diagonal
A(1,1) =  quad( @(x) p(x) * phi_1_deriv(x)^2  +  q(x) * phi_1(x)^2,  0, 1, tol );
A(2,2) =  quad( @(x) p(x) * phi_2_deriv(x)^2  +  q(x) * phi_2(x)^2,  0, 1, tol );
A(3,3) =  quad( @(x) p(x) * phi_3_deriv(x)^2  +  q(x) * phi_3(x)^2,  0, 1, tol );

A(2,1) = A(1,2) = quad( @(x) p(x) * phi_1_deriv(x) * phi_2_deriv(x) + q(x) * phi_1(x) * phi_2(x), 0, 1, tol );
A(3,1) = A(1,3) = quad( @(x) p(x) * phi_1_deriv(x) * phi_3_deriv(x) + q(x) * phi_1(x) * phi_3(x), 0, 1, tol );
A(2,3) = A(3,2) = quad( @(x) p(x) * phi_2_deriv(x) * phi_3_deriv(x) + q(x) * phi_2(x) * phi_3(x), 0, 1, tol );

B = [ 0; 0; 0];
B(1) = quad ( @(x) f(x) * phi_1(x), 0, 1, tol );
B(2) = quad ( @(x) f(x) * phi_2(x), 0, 1, tol );
B(3) = quad ( @(x) f(x) * phi_3(x), 0, 1, tol );

c = linsolve(A, B);
disp(['Solution using polinomial functions:']);
disp(c);
disp(['Error:']);
disp(A * c - B);

%
% Trigonometric functions
%
phi_1 = @(x)                 1;
phi_2 = @(x) cos(   pi * x   );
phi_3 = @(x) cos( 2 * pi * x );

phi_1_deriv = @(x)                        0;
phi_2_deriv = @(x)     pi * sin(  pi * x  );
phi_3_deriv = @(x) 2 * pi * sin(2 * pi * x);

A = ones(3,3);
% diagonal
A(1,1) =  quad( @(x) p(x) * phi_1_deriv(x)^2  +  q(x) * phi_1(x)^2,  0, 1, tol );
A(2,2) =  quad( @(x) p(x) * phi_2_deriv(x)^2  +  q(x) * phi_2(x)^2,  0, 1, tol );
A(3,3) =  quad( @(x) p(x) * phi_3_deriv(x)^2  +  q(x) * phi_3(x)^2,  0, 1, tol );

A(2,1) = A(1,2) = quad( @(x) p(x) * phi_1_deriv(x) * phi_2_deriv(x) + q(x) * phi_1(x) * phi_2(x), 0, 1, tol );
A(3,1) = A(1,3) = quad( @(x) p(x) * phi_1_deriv(x) * phi_3_deriv(x) + q(x) * phi_1(x) * phi_3(x), 0, 1, tol );
A(2,3) = A(3,2) = quad( @(x) p(x) * phi_2_deriv(x) * phi_3_deriv(x) + q(x) * phi_2(x) * phi_3(x), 0, 1, tol );

B = [ 0; 0; 0];
B(1) = quad (@(x) f(x) * phi_1(x), 0, 1, tol );
B(2) = quad (@(x) f(x) * phi_2(x), 0, 1, tol );
B(3) = quad (@(x) f(x) * phi_3(x), 0, 1, tol );

c = linsolve(A, B);
disp(['Solution using cossine functions:']);
disp(c);
disp(['Error:']);
disp(A * c - B);


%
% Polinomial functions using poly functions
%
_p = [ 0 0 1 ]; % p = 1
_q = [ 1 0 1 ]; % q = 1 * x^2 + 0 * x + 1 * 1
_f = [ 1 0 0 ]; % f = 1 * x^2 + 0 * x + 0 * 1

N = 3;
pi = zeros(N,N);
for i = 1:N
  pi(i, N - i + 1 ) = 1; 
endfor
% phi_1 = 1 * 1
% phi_2 = 1 * x + 0 * 1
% phi_3 = 1 * x^2 + 0 * x + 0 * 1
% ...

% product of polynoms a and b: conv(a,b)

A = ones(N,N);
% diagonal
% p * polyder(phi_1) * polyder(phi_1) + q * phi_1 * phi_1
% --> polyint( conv( p , conv(polyder(phi_1), polyder(phi_1)) ) ) +
%     polyint( conv( q , conv(phi_1, phi_1)                   ) )
B = ones(N,1);

for i = 1:N
  for j = i:N
    A(j,i) = polyval( polyint( conv( _p , conv(polyder(pi(i,:)), polyder(pi(j,:))) ) ), 1 ) + polyval( polyint( conv( _q , conv(pi(i,:), pi(j,:))                   ) ), 1 );
    A(i,j) = A(j,i);
  endfor
 B(i) = polyval( polyint( conv(_f, pi(i,:)) ), 1 );
endfor

c = linsolve(A, B);

disp(['Solution using polinomial functions:']);
disp(c');
%disp(['Error:']);
%disp((A * c - B)');
