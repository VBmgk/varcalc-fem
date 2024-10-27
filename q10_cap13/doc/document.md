# Cap 13

## Variational Approximation Methods

\pagebreak

### Questão 10
Construct a three-term Rayleigh-Ritz approximate solution to

\begin{align*}
    u_{xx} + u_{yy} &= x ; x,y \in \Omega          \\
                  u &= 0 ; x,y \in \partial \Omega \\
          u_x(0, y) &= 0 ; 0 < y < 100             \\
          u_y(x, 0) &= 0 ; 0 < x < 100             \\
\end{align*}

Base functions:

$$  \phi_1 = 10 - (x^2 + y^2)^{1/2} $$
$$  \phi_2 = 10 * x - x * (x^2 + y^2)^{1/2} $$
$$  \phi_3 = 10 * y - y * (x^2 + y^2)^{1/2} $$


# Solution

## Numerical Integration Method Used
The numerical integration use to solve this problem is very
naive. Basicly, a mesh is computed for each function to be
integrated over the domain and then all the elements of this
mesh are summed. The resolution is then used to correct the
scaling of the integral. The function used to do this is
__sum__.

There are other approches that can be used to solve this problem.
One is to use the __quad__ functions that use Gauss quadrature to
compute the integral. The problem with this is that it needs a
function handler as an input. As the Rayleigh-Ritz method needs
the gradient of the base functions, one needs to compute manually
all the gradient of these base functions. If one does not bother
with this, as these functions are know __a priori__, this is a good
approch.

## Boundaries
Other problem with the current solution is that the boundary is
very different from the specified in the original problem:

$$ x^2 + x^2 < 100, x,y > 0 $$

As oppose to the one use in the solution:

$$ x < 10, y < 10 $$
