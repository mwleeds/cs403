% some Prolog facts and rules incompletely describing the Leeds family
% the code below strives to work with same-sex relationships

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FACTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% parent means biological parent
% generation -1
parent(buppa, ama, davidL).
parent(buppa, ama, greg).
parent(buppa, ama, wendy).
parent(poppi, mimi, libet).
parent(poppi, mimi, leslie).
parent(poppi, mimi, chris).
parent(poppi, mimi, tricia).
parent(poppi, mimi, davidG).
parent(poppi, mimi, michael).
parent(larry, happi, jason).
parent(larry, happi, josh).
parent(larry, happi, sk).
parent(larry, happi, laura).
% generation 0
parent(davidL, libet, matthew).
parent(davidL, libet, maggie).
parent(davidL, libet, andrew).
parent(tricia, craigSr, craig).
parent(tricia, craigSr, franny).

female(maggie).
female(kathleen).
female(heather).
female(mimi).
female(wendy).
female(ama).
female(libet).
female(leslie).
female(tricia).
female(happi).
female(sk).
female(laura).
female(emily).
male(michael).
male(chris).
male(poppi).
male(greg).
male(davidL).
male(davidG).
male(jason).
male(josh).
male(buppa).
male(matthew).
male(andrew).

spouse(libet, jason).
spouse(kathleen, buppa).
spouse(heather, greg).
spouse(davidL, carol).
spouse(josh, emily).
spouse(eddie, sk).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RULES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

husband(Husband, Spouse) :- male(Husband), spouse(Husband, Spouse).
wife(Wife, Spouse) :- female(Wife), spouse(Wife, Spouse).

parent(Parent, Child) :- parent(Parent, _, Child).
parent(Parent, Child) :- parent(_, Parent, Child).

son(Parent, Son) :- male(Son), parent(Parent, Son).
daughter(Parent, Daughter) :- female(Daughter), parent(Parent, Daughter).

step_parent(StepParent, Kid) :- parent(Parent, Kid), spouse(Parent, StepParent).

sibling(Kid1, Kid2) :- parent(Parent, Kid1), parent(Parent, Kid2), Kid1 =\= Kid2.
step_sibling(Kid1, Kid2) :- parent(Parent, Kid1), step_parent(Parent, Kid2).
step_sibling(Kid2, Kid1) :- parent(Parent, Kid1), step_parent(Parent, Kid2).

brother(Kid1, Kid2) :- male(Kid1), sibling(Kid1, Kid2).
step_brother(Kid1, Kid2) :- male(Kid1), parent(StepParent, Kid1), step_parent(StepParent, Kid2).

sister(Kid1, Kid2) :- female(Kid1), sibling(Kid1, Kid2).
step_sister(Kid1, Kid2) :- female(Kid1), parent(StepParent, Kid1), step_parent(StepParent, Kid2).

grandparent(GrandParent, GrandChild) :- parent(GrandParent, Parent), parent(Parent, GrandChild).

ancestor(Ancestor, Descendant) :- parent(Ancestor, Descendant).
ancestor(Ancestor, Descendant) :- parent(Ancestor, Intermediary), ancestor(Intermediary, Descendant).

cousin(Kid1, Kid2) :- parent(Parent, Kid1), parent(ParentSibling, Kid2), sibling(Parent, ParentSibling).

parents_sibling(Adult, Kid) :- sibling(Adult, Parent), parent(Parent, Kid).
aunt(Aunt, Kid) :- female(Aunt), parents_sibling(Aunt, Kid).
uncle(Uncle, Kid) :- male(Uncle), parents_sibling(Uncle, Kid).

niece(Niece, Adult) :- female(Niece), parents_sibling(Adult, Niece).
nephew(Nephew, Adult) :- male(Nephew), parents_sibling(Adult, Nephew).
