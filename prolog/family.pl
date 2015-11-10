% some Prolog facts and rules incompletely describing the Leeds family
% the code below strives to work with same-sex relationships

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FACTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% parent means biological parent
% generation -1
parent(buppa, davidL).
parent(buppa, greg).
parent(buppa, wendy).
parent(ama, david).
parent(ama, greg).
parent(ama, wendy).
parent(poppi, libet).
parent(poppi, leslie).
parent(poppi, chris).
parent(poppi, tricia).
parent(poppi, davidG).
parent(poppi, michael).
parent(mimi, libet).
parent(mimi, leslie).
parent(mimi, chris).
parent(mimi, tricia).
parent(mimi, david).
parent(mimi, michael).
parent(happi, jason).
parent(happi, josh).
parent(happi, sk).
parent(happi, laura).
% generation 0
parent(davidL, matthew).
parent(davidL, maggie).
parent(davidL, andrew).
parent(libet, matthew).
parent(libet, maggie).
parent(libet, andrew).
parent(tricia, craig).
parent(tricia, franny).

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

% check if Parent1 and Parent2 have had kids together
kids_together(Parent1, Parent2) :- parent(Parent1, Kid), parent(Parent2, Kid).

step_parent(StepParent, Kid) :- parent(Parent, Kid), spouse(Parent, StepParent).

sibling(Kid1, Kid2) :- parent(Parent, Kid1), parent(Parent, Kid2).
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

