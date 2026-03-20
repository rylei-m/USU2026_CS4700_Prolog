% Base case - empty list prints nothing
printList([]).

% Recursive case: print the head, then print the tail.
printList([H|T]) :-
    writeln(H),
    printList(T).

% Succeeds when there's path from enter to exit in Castle thats visited rooms include every room in rooms
solveRooms(Castle, Rooms) :-
    pathToExit(Castle, enter, Path, _Cost),
    containsAll(Rooms, Path),
    printList(Path).

% Succeeds when there is a path from enter to exit in Castle and total cost is within Limit
solveRoomsWithinCost(Castle, Limit) :-
    pathToExit(Castle, enter, Path, Cost),
    Cost =< Limit,
    format('Cost is ~w within limit of ~w~n', [Cost, Limit]),
    printList(Path).

% Path - list of rooms visited starting after CurrentRoom and ending at exit
% Cost - total cost from CurrentRoom to exit
pathToExit(Castle, FromRoom, [ToRoom|RestPath], Cost) :-
    room(Castle, FromRoom, ToRoom, StepCost),
    (   ToRoom = exit
    ->  RestPath = [],
        Cost = StepCost
    ;   pathToExit(Castle, ToRoom, RestPath, RestCost),
        Cost is StepCost + RestCost
    ).

% True when every room in RequiredRooms is somewhere in Path
containsAll([], _).
containsAll([H|T], Path) :-
    member(H, Path),
    containsAll(T, Path).
