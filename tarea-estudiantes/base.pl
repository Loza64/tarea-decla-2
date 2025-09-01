estudiante(kelvin).
estudiante(raul).
estudiante(florens).
estudiante(mauricio).
estudiante(melisa).

%- 1. Saber si Ellacuria no es estudiante
no_es_estudiante(Nombre) :-
    \+ estudiante(Nombre).

%- Consulta: no_es_estudiante(ellacuria)

%- 2. Mostrar el primer estudiante de la lista
primero(X) :- estudiante(X), !.

%- Consulta: primero(X)

%- 3. Mostrar estudiantes
mostrar_estudiantes:-
    estudiante(Nombre),
    write('Estudiante: '), write(Nombre), nl,
    fail.
mostrar_estudiante.

%- Consulta: mostrar_estudiantes.

%- 4. Verificar si es un estudiante o no

verificar_estudiante :-
    write('Digite un nombre: '), read(Nom),
    (   estudiante(Nom)
    ->  write('Si es un estudiante')
    ;   write('No es un estudiante')
    ).

%- Consulta: verificar_estudiante