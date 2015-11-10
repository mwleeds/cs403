% Author: Dr. Richard Borie

vertex(a).
vertex(b).
vertex(c).
vertex(d).
vertex(e).
vertex(f).

edge(a,b).
edge(a,c).
edge(b,c).
%edge(a,d).
edge(b,d).
edge(c,d).
%edge(b,e).
edge(c,e).
edge(d,e).
%edge(c,f).
edge(d,f).
edge(e,f).

adj(X,Y):- edge(X,Y).
adj(X,Y):- edge(Y,X).

color(red).
color(blue).
color(green).
%color(yellow).

graphcolor(Z):- allcolors(C), initcolors(C,L), allvertices(V), colorvertices(V,L,Z).

initcolors([],[]).
initcolors([H|T],[color(H,[])|Z]):- initcolors(T,Z).

allvertices(V):- vertices(V), not(missingvertex(V)), !.

vertices([]).
vertices([X|L]):- vertices(L), vertex(X), not(member(X,L)).

missingvertex(L):- vertex(X), not(member(X,L)).

allcolors(C):- colors(C), not(missingcolor(C)), !.

colors([]).
colors([X|L]):- colors(L), color(X), not(member(X,L)).

missingcolor(L):- color(X), not(member(X,L)).

colorvertices([],L,L).
colorvertices([X|Y],L,C):- colorvertices(Y,L,B), colorvertex(X,B,C).

colorvertex(X,[color(C,L)|T],[color(C,[X|L])|T]):- notadj(X,L).
colorvertex(X,[H|T],[H|Z]):- colorvertex(X,T,Z).

notadj(X,[]).
notadj(X,[H|T]):- not(adj(X,H)), notadj(X,T).
