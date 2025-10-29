% ---------------------------------------------------------------
% Guía de ejercicios – Programación simbólica en Prolog
% ---------------------------------------------------------------

% Sumar cero a la izquierda no altera el resultado.
simplifica(+(0, X), X).
% Sumar cero a la derecha tampoco cambia el valor.
simplifica(+(X, 0), X).
% Multiplicar por uno a la izquierda mantiene el factor original.
simplifica(*(1, X), X).
% Multiplicar por uno a la derecha produce el mismo efecto.
simplifica(*(X, 1), X).
% Multiplicar por cero a la izquierda fuerza el resultado a cero.
simplifica(*(0, _), 0).
% Multiplicar por cero a la derecha tambien produce cero.
simplifica(*(_, 0), 0).
% Regla por defecto: si nada se reduce, la expresion se queda igual.
simplifica(X, X).

% Ejemplo interactivo:
% ?- simplifica(*(1, +(0, X)), R).
% R = X.


% -------------------------------------------------------------------
% 2. DERIVACION SIMBOLICA
% -------------------------------------------------------------------
% Calcula derivadas basicas siguiendo las reglas de derivacion para
% suma, producto y resta. Las expresiones son simbolicas, por lo que
% no se simplifican automaticamente tras aplicar las reglas.

% La derivada de una variable respecto de si misma es 1.
derivada(X, X, 1).
% La derivada de una constante respecto de cualquier variable es 0.
derivada(C, _, 0) :- number(C).
% Regla de derivacion para la suma: (A + B)' = A' + B'.
derivada(A + B, X, DA + DB) :-
    derivada(A, X, DA),
    derivada(B, X, DB).
% Regla del producto: (A * B)' = A * B' + B * A'.
derivada(A * B, X, A*DB + B*DA) :-
    derivada(A, X, DA),
    derivada(B, X, DB).
% Regla de la resta: (A - B)' = A' - B'.
derivada(A - B, X, DA - DB) :-
    derivada(A, X, DA),
    derivada(B, X, DB).

% + la regla extra de resta/3:

resta(frac(A, B), frac(C, D), frac(N, M)) :-
    N is A*D - C*B,
    M is B*D.

% ---------------------------------------------------------------
% CONSULTAS Y RESULTADOS
% ---------------------------------------------------------------
% simplifica(*(1, +(0, X)), R).      → R = X.
% simplifica(*(0, +(X, 3)), R).      → R = 0.
% simplifica(+(X, 0), R).            → R = X.
% simplifica(*(1, +(Y, 0)), R).      → R = Y.
%
% derivada(x*x + 3*x + 2, x, D).     → D = x*1 + x*1 + 3*1 + 0.
% derivada(x*x*x, x, D).             → D = x*x*1 + x*x*1 + x*x*1.
% derivada(x*x - 4*x + 1, x, D).     → D = x*1 + x*1 - (4*1 + 0).
% derivada(2*x*x*x + 5*x + 7, x, D). → D = 2*(x*x*1 + x*x*1 + x*x*1) + 5*1 + 0.
%
% evalua(x*x + 3*x + 2, x, 3, R).    → R = 20.
% evalua(x*x - 4*x + 4, x, 2, R).    → R = 0.
% derivada(x*x + 3*x + 2, x, D), evalua(D, x, 2, R). → R = 7.
%
% suma(frac(1,2), frac(1,3), R).     → R = frac(5,6).
% suma(frac(2,5), frac(3,10), R).    → R = frac(7,10).
% resta(frac(3,4), frac(1,2), R).    → R = frac(1,4).
%
% resuelve(x + 3 = 7, x, V).         → V = 4.
% resuelve(5 + x = 10, x, V).        → V = 5.
% resuelve(2 + x = 9, x, V).         → V = 7.
