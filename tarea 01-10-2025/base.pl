cocina(ana).
estudia(juan).
trabaja(maria).
juega(pedro).
descansa(sofia).

hermano(ana, pedro).
hermano(pedro, ana).
primo(maria, sofia).
primo(sofia, maria).

amigo(ana, juan).
amigo(juan, ana).
amigo(juan, maria).
amigo(maria, juan).

trabajan_juntos(pedro, sofia).
trabajan_juntos(sofia, pedro).
estudian_juntos(maria, juan).
estudian_juntos(juan, maria).

dia(lunes).
dia(martes).
dia(miercoles).
dia(jueves).
dia(viernes).
dia(sabado).
dia(domingo).

cansada(ana).


actividad(X) :- cocina(X).
actividad(X) :- estudia(X).
actividad(X) :- trabaja(X).
actividad(X) :- juega(X).


descansa(X) :- \+ cocina(X), \+ estudia(X), \+ trabaja(X), \+ juega(X).

parentesco_directo(X, Y) :- hermano(X, Y).
parentesco_directo(X, Y) :- primo(X, Y).

no_cocina(ana) :- cansada(ana).

% AMISTAD RECURSIVA
% Caso base: amistad directa
es_amigo(X, Y) :- amigo(X, Y).

% Caso general: amistad indirecta mediante una tercera persona
% Usamos una lista de visitados para evitar bucles infinitos
es_amigo(X, Y) :- es_amigo_aux(X, Y, [X]).

% Auxiliar con lista de visitados
es_amigo_aux(X, Y, _) :- amigo(X, Y).
es_amigo_aux(X, Y, Visitados) :- 
    amigo(X, Z), 
    \+ member(Z, Visitados),
    es_amigo_aux(Z, Y, [Z|Visitados]).

% Caso base: X es miembro si está en la cabeza de la lista
miembro(X, [X|_]).

% Caso general: X es miembro si está en la cola de la lista
miembro(X, [_|T]) :- miembro(X, T).

% Ana: cocina todos los días salvo cuando está cansada
actividad(ana, X, cocinar) :- 
    dia(X), 
    \+ cansada(ana).
actividad(ana, X, descansar) :- 
    dia(X), 
    cansada(ana).

% Juan: estudia entre semana y descansa fines de semana
actividad(juan, dia_semana, estudiar).
actividad(juan, fin_de_semana, descansar).

% Pedro: trabaja lunes a viernes, juega sábados, descansa domingos
actividad(pedro, dia_semana, trabajar).
actividad(pedro, sabado, jugar).
actividad(pedro, domingo, descansar).

% Sofía: trabaja en tienda y estudia idiomas por las noches
actividad(sofia, X, trabajar) :- 
    member(X, [lunes, martes, miercoles, jueves, viernes, sabado]).
actividad(sofia, X, estudiar) :- 
    member(X, [lunes, martes, miercoles, jueves, viernes, sabado, domingo]).

% María: estudia en universidad y descansa domingos
actividad(maria, X, estudiar) :- 
    member(X, [lunes, martes, miercoles, jueves, viernes, sabado]).
actividad(maria, domingo, descansar).


% Caso base: la inversa de la lista vacía es []
invertir([], []).

% Caso general: invierto la cola y agrego la cabeza al final
% Para invertir [H|T], invierto T obteniendo RT, luego concateno RT con [H]
invertir([H|T], R) :-
    invertir(T, RT),
    append(RT, [H], R).


% Nuevo personaje: Carlos
cocina(carlos).
trabaja(carlos).
amigo(carlos, ana).
amigo(ana, carlos).
hermano(carlos, sofia).
hermano(sofia, carlos).

% Rutinas de Carlos: trabaja lunes a viernes, cocina fines de semana
actividad(carlos, X, trabajar) :- 
    member(X, [lunes, martes, miercoles, jueves, viernes]).
actividad(carlos, X, cocinar) :- 
    member(X, [sabado, domingo]).


% Caso base: familia directa
familia(X, Y) :- hermano(X, Y).
familia(X, Y) :- primo(X, Y).

% Caso general: familia indirecta
% Si X es familia de Z y Z es familia de Y, entonces X es familia de Y
familia(X, Y) :- 
    familia(X, Z), 
    familia(Z, Y),
    X \= Y.

% REGLA COMBINADA: Personas que hacen la misma actividad en el mismo día
hacen_lo_mismo(X, Y, Dia, Actividad) :-
    actividad(X, Dia, Actividad),
    actividad(Y, Dia, Actividad),
    X \= Y.


% CONSULTAS
% ?- cocina(ana).
% ?- es_amigo(ana, maria).
% ?- miembro(estudiar, [cocinar, estudiar, jugar]).
% ?- invertir([cocinar, estudiar, jugar], R).
% ?- actividad(pedro, sabado, A).

% Consultas creativas
% ?- hacen_lo_mismo(X, Y, lunes, trabajar).
% ?- actividad(carlos, domingo, A).



% REGLA es_amigo/2:
% - Caso base: amigo(X, Y) - amistad directa ya definida en hechos
% - Caso general: amigo(X, Z), es_amigo(Z, Y) - si X es amigo de Z y Z es amigo de Y,
%   entonces X es amigo de Y (transitividad de amistad)

% REGLA miembro/2:
% - Caso base: miembro(X, [X|_]) - X es miembro si es la cabeza de la lista
% - Caso general: miembro(X, [_|T]) :- miembro(X, T) - X es miembro si está en la cola

% REGLA invertir/2:
% - Caso base: invertir([], []) - la inversa de lista vacía es lista vacía
% - Caso general: invertir([H|T], R) - para invertir [H|T], invertimos T y agregamos H al final

% REGLA familia/2:
% - Caso base: hermano(X, Y) o primo(X, Y) - relación familiar directa
% - Caso general: familia(X, Z), familia(Z, Y) - relación familiar transitiva

% MODELADO DE RUTINAS POR DÍA:
% Las rutinas se modelaron usando hechos actividad(Persona, Dia, Actividad) que permiten
% consultar qué hace cada persona en un día específico. Se usaron reglas con member/2
% para días repetitivos y hechos individuales para casos específicos. Esto permite
% flexibilidad para consultas como "¿qué hace Pedro el sábado?" o "¿quién trabaja el lunes?"
