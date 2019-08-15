/*
 *This file reads in a prolog file
 *and outputs a clp(constraint logic programming) file
 */
:- use_module(library(clpfd)).
:- use_module(library(ansi_term)).
:- use_module(library(type_check)).

:- op(1150, fx, infer).
:- op(1150, fx, type).
:- op(1130, xfx, ---> ).
:- op(1150, fx, pred).
:- op(1150, fx, trust_pred).
:- op(500,yfx,::).
:- op(500,yfx,:<).

:- dynamic have_type/1.

main :-
	write('Please enter file name and end with period.\n'),
	read(FileName), type_check(FileName),
    open(FileName, read, InStream),
	open('clpfile.pl', write, OutStream),
	writeln(OutStream, ':- use_module(library(clpfd)).'),
    writeln(OutStream, ':- use_module(library(type_check)).'),
    infer_file_types(InStream, Types), printlist(Types),
    close(InStream), open(FileName, read, InStream2),
	read_file(InStream2, OutStream, _), close(InStream2), close(OutStream).

read_file(InStream, _, []) :-
	at_end_of_stream(InStream).

read_file(InStream, OutStream, [Clause|TrailingClauses]) :-
	\+ at_end_of_stream(InStream),
	read_clause(InStream, Clause, [variable_names(_)]),
	Clause =.. ClauseList,
    %ansi_format([bold,fg(yellow)], '@@@@@@@@@@@@@@@@@@@@@ ~w @@@@@@@@@@@@@@@@@@@@@', [level_1]), nl,
	process(NewClauseList, ClauseList, VarsList),
	sort(VarsList, NewVarsList),
	insert_def(NewerClauseList, NewClauseList, NewVarsList, OutStream), 
    NewerClause =.. NewerClauseList, numbervars(NewerClause, 0, _N),
	write(OutStream, NewerClause), writeln(OutStream, '.'),
	read_file(InStream, OutStream, TrailingClauses).

/*process first omits the facts in the original program*/	
process([:-|NewTail], [:-|Tail], VarsList) :-
    %ansi_format([bold,fg(green)], '@@@@@@@@@@@@@@@@@@@@@ ~w @@@@@@@@@@@@@@@@@@@@@', [level_2]), nl,
	process2(NewTail, Tail, VarsList).
process(List, List, []).

/*for derivatives, NewTail would be empty?
 *for rules, the head of the rule is omitted.
 */
process2([NewHead|NewTail], [Head|Tail], VarsList) :-
	%numbervars(Head, 0, _N),
    writeln(Head), compound(Head), 
    processCompound(NewHead, Head, HeadVarsList),
    %ansi_format([bold,fg(magenta)], '@@@@@@@@@@@@@@@@@@@@@ ~w @@@@@@@@@@@@@@@@@@@@@', [level_3]), nl,
	process3(NewTail, Tail, TailVarsList),
    append(HeadVarsList, TailVarsList, VarsList).
	
/*
 *process3 invokes the transfer rule,
 *which transfers operators in prolog into operators in clp
 */
process3([], [], []).

/*
 * In this case, both Tail and NewTail should be [].
 */
process3([NewHead|NewTail], [Head|Tail], VarsList) :-
	compound(Head),
    Head =.. [(',')|HeadClause],
    process3(NewTail, Tail, TailVarsList),
	process3(NewHeadClause, HeadClause, HeadVarsList),
    NewHead =.. [(',')|NewHeadClause],
	append(HeadVarsList, TailVarsList, VarsList).

process3([NewHead|NewTail], [Head|Tail], VarsList) :-
    compound(Head),
    processCompound(NewHead, Head, HeadVarsList), 
    process3(NewTail, Tail, TailVarsList),
    append(HeadVarsList, TailVarsList, VarsList).

process3([Head|NewTail], [Head|Tail], VariableList) :-
    \+ compound(Head), var(Head), 
	process3(NewTail, Tail, VariableList).

process3([NewHead|NewTail], [Head|Tail], VariableList) :-
	\+ compound(Head), nonvar(Head), 
    transfer(Head, NewHead, _Flag),
	process3(NewTail, Tail, VariableList).

/*
 * processCompound deals with compound predicates
 * first, it reads type derivables generated in infer_file_types
 * then, it tries to unify the predicate with its type derivables
 * finally, variables unified with integer or natural are recorded
 */
processCompound((NewPred1->NewPred2;NewPred3), (Pred1->Pred2;Pred3), VarsList) :-
    Pred1 =.. List1, process3(NewList1, List1, VarsList1), 
    Pred2 =.. List2, process3(NewList2, List2, VarsList2),
    Pred3 =.. List3, process3(NewList3, List3, VarsList3),
    NewPred1 =.. NewList1, NewPred2 =.. NewList2, NewPred3 =.. NewList3,
    append(VarsList2, VarsList1, VarsList1n2),
    append(VarsList3, VarsList1n2, VarsList).

processCompound(Pred, Pred, VarsList) :-
    find_inferred(Pred, PredType),
    Pred =.. [Head|BodyList],
    PredType =.. [Head|BodyTypeList],
    get_intvars_list(BodyList, BodyTypeList, VarsList).

get_intvars_list([],[],[]).

get_intvars_list([BodyHead|BodyTail], [_BodyTypeHead|BodyTypeTail], VarsList) :-
    compound(BodyHead),
    processCompound(_NewBodyHead, BodyHead, VarsHeadList),
    get_intvars_list(BodyTail, BodyTypeTail, VarsTail),
    append(VarsHeadList, VarsTail, VarsList).

get_intvars_list([BodyHead|BodyTail], [integer|BodyTypeTail], [(int, BodyHead)|VarsTail]) :-
    \+ compound(BodyHead), var(BodyHead), %writeln('Gotcha!'),
    get_intvars_list(BodyTail, BodyTypeTail, VarsTail).

get_intvars_list([BodyHead|BodyTail], [natural|BodyTypeTail], [(int, BodyHead)|VarsTail]) :-
    \+ compound(BodyHead), var(BodyHead), %writeln('Gotcha!'),
    get_intvars_list(BodyTail, BodyTypeTail, VarsTail).

get_intvars_list([BodyHead|BodyTail], [list(integer)|BodyTypeTail], [(intlist, BodyHead)|VarsTail]) :-
    \+ compound(BodyHead), var(BodyHead), %writeln('Gotcha!'),
    get_intvars_list(BodyTail, BodyTypeTail, VarsTail).

get_intvars_list([BodyHead|BodyTail], [list(natural)|BodyTypeTail], [(intlist, BodyHead)|VarsTail]) :-
    \+ compound(BodyHead), var(BodyHead), %writeln('Gotcha!'),
    get_intvars_list(BodyTail, BodyTypeTail, VarsTail).

get_intvars_list([_BodyHead|BodyTail], [_BodyTypeHead|BodyTypeTail], VarsList) :-
    get_intvars_list(BodyTail, BodyTypeTail, VarsList).

/*
 *There are three cases
 *case1: variable list is empty so there is nothing to do
 *case2: we need to insert the varibales into the body of a rule
 *case3: we don't need to insert the variables into a fact
 */
insert_def(List, List, [], _).
insert_def([:-|NewTail], [:-|Tail], VariableList, OutStream) :-
	insert_def2(NewTail, Tail, VariableList, OutStream).
	%This is used to omit the :- in prolog clauses
	%considering (parent(X, Y) :- father(X,Y)) =.. L. 
	%will yield L = [:-, parent(X, Y), father(X, Y)].
insert_def(List, List, _, _).
%There is no :- before the list, so it is a fact rather than a rule
%For instance, father(john,peter) =.. L. will yield L = [father, john, peter].

/*
 *Here Head stands for the head of the rule
 *This predicate invokes insert_def3 which deals with the body of the rule
 */
insert_def2(NewList, [Head|Tail], VariableList, OutStream) :-
	insert_def3(NewTail, Tail, VariableList, OutStream),
	NewTailClause =.. NewTail, 
	append([Head], [NewTailClause], NewList).
	%append([Head], NewTail, NewList).
	
/*
 *The trick is the '' below
 *Here _ is actually an empty list		
 */
insert_def3([''|NewList], List, VariableList, OutStream) :-
	%compound(Head), Head ^=.. HeadList,
	%Head here should be the body of the rule
	List = [ListHead|ListTail],
	ListHead == ',',
	%write(S2, X), write(S2, '*****'), write(S2, L),
	insert_def4(NewList, ListTail, VariableList, OutStream).

insert_def3([''|NewList], List, VariableList, OutStream) :-
	%compound(H), H ^=.. L,
	insert_def4(NewList, List, VariableList, OutStream).

/*
 * The final stage which insert 0..100 for variables
 * These variables should have the type of integers	
 * XSB-Prolog doesn't support sup..inf so we tentatively use 0..100		
 */
insert_def4(List, List, [], _).

insert_def4(NewerList, List, [VarsListHead|VarsListTail], OutStream) :-
	is_list(VarsListHead), 
	insert_def4(NewList, List, VarsListHead, OutStream),
	insert_def4(NewerList, NewList, VarsListTail, OutStream).
	
insert_def4(NewList, List, [(int, IntVar)|VarsListTail], OutStream) :-
	RangeDeclaration =.. [in, IntVar, inf..sup], 
	append([RangeDeclaration], SubList, NewList),
	insert_def4(SubList, List, VarsListTail, OutStream).

insert_def4(NewList, List, [(intlist, IntListVar)|VarsListTail], OutStream) :-
    RangeDeclaration =.. [ins, IntListVar, inf..sup], 
    append([RangeDeclaration], SubList, NewList),
    insert_def4(SubList, List, VarsListTail, OutStream).

/*
 *Considering built-in predicates
 *Based on information from http://en.wikibooks.org/wiki/Prolog/Built-in_predicates
 */

%Term unification
%transfer(=, #=, 0).		%Prolog unification
%transfer(\=, #\=, 0).		%Not Prolog unifiable

%Arithmetic evaluations
transfer(is, #=, 1).

%Arithmetic comparisons
transfer(=:=, #=, 1).	%Arithmetic equal
transfer(=\=, #\=, 1).	%Arithmetic not equal
transfer(<, #<, 1).		%Arithmetic less than
transfer(>, #>, 1).		%Arithmetic greater than
transfer(=<, #=<, 1).	%Arithmetic less than or equal to
transfer(>=, #>=, 1).	%Arithmetic greater than or equal to

%Evaluable functors
transfer(-, -, 1). 		%Negation
transfer(abs, abs, 1).  %Absolute value
transfer(sign, sign, 1).%Sign value
transfer(+, +, 1).		%Addition
transfer(-, -, 1).  	%Subtraction
transfer(*, *, 1).  	%Multiplication
transfer(/, /, 1).		%Division
transfer(//, //, 1).  	%Integer division
transfer(rem, rem, 1).	%Remainder
transfer(mod, mod, 1).  %Modulus
%float_integer_part/1, float_fractional_part/1, float/1, floor/1, truncate/1, round/1, ceiling/1

%Other arithmetic and bitwise functors
transfer(**, **, 1). 	%Power
transfer(sin, sin, 1). 	%Sine
transfer(cos, cos, 1).	%Cosine
transfer(atan, atan, 1).%Arc tangent
transfer(exp, exp, 1).	%Exponentiation
transfer(log, log, 1).	%Log
transfer(sqrt, sqrt, 1).%Square root
transfer(/\, #/\, 0).	%Bitwise and
transfer(\/, #\/, 0).	%Bitwise or
transfer(\, #\, 0). 	%Bitwise complement
%>>/2, <</2, /\/2, \//2, \/1

transfer(X, X, 0).

infer_file_types(InStream, ExtractedTypes) :-
    %ansi_format([bold,fg(red)], '********************* ~w *********************', [starty]), nl,
	find_predicates(InStream, Preds, _TypedPreds),
	remove_empty(Preds, PredsEmptyRemoved),
	sort(PredsEmptyRemoved, PredsSorted),
	add_arguments(PredsSorted, PredsArgsAdded),
	infer_predicates_types(PredsArgsAdded, Types),
	extract_types(Types, ExtractedTypes),
	numbervars(ExtractedTypes, 0, _N), 
    abolish(signature/4),
    abolish(constructor/4),
    abolish(constructor_info/4).
    %ansi_format([bold,fg(red)], '********************* ~w *********************', [finish]), nl.

infer_predicates_types([],[]).
infer_predicates_types([Pred|Preds], [Type|Types]) :-
	( ansi_format([bold,fg(yellow)], '@@@@@@@@@@@@@@@@@@@@@ ~w @@@@@@@@@@@@@@@@@@@@@', [origin]), nl,
        writeln(Pred),
      do_type_inference_tabled(Pred, _, Type)
	-> true
	; Type = 'not found'
	),
    ansi_format([bold,fg(yellow)], '@@@@@@@@@@@@@@@@@@@@@ ~w @@@@@@@@@@@@@@@@@@@@@', [finish]), nl,
	infer_predicates_types(Preds, Types).

% Added by Yu in Jun 15 
% Ported from pre_batch_multitype.pl by Spyros

% this is the outer fixpoint of the computation: it takes as 
% arguments the predicate we are interested in and the type 
% computed in the previous run, and returns the newly inferred
% type for this predicate.
do_type_inference_tabled(Pred,TypeIn,TypeOut) :-
        findall(Type,type_inference_tabled(Pred,TypeIn,Type),LTypeTemp),
        ( LTypeTemp == []
        -> fail
        ; ( test_for_inequality([TypeIn],LTypeTemp)
          -> [TypeTemp] = LTypeTemp,
            ansi_format([bold,fg(green)], '+++++++++++++++++++++ ~w +++++++++++++++++++++', [nested]), nl,
            do_type_inference_tabled(Pred,TypeTemp,TypeOut)
          ; TypeOut = TypeIn,
            ansi_format([bold,fg(green)], '+++++++++++++++++++++ ~w +++++++++++++++++++++', [finish]), nl
          )
        ).

% this is the inner fixpoint of the computation: it takes as 
% arguments the predicate we want to infer a type for and the
% type inferred for this predicate previously, and returns the
% new type inferred for the predicate.
type_inference_tabled(Pred,TypeIn,Type) :-
        findall(type_error(TypeIn,Error),
                    type_inference(Pred,TypeIn,Error),TEList),
        ( check_for_failed(TEList)
        -> fail
        ; get_types_list(TEList,List)
        ),
        unify_list_elements(List), List = [Type|_Tail].


type_inference(Pred,TypeIn,Error) :-
		find_clause(Pred,BodyComma), 
        get_env(BodyComma,Pred,TypeIn,[],Env), 
        get_head_type(Pred,Env,PredType), 
        %writeln(PredType),
        ( unify_with_occurs_check(PredType,TypeIn)
        -> Error = []
        ; Error = 'failed'
        ).

% Performs compile-time type-checking on the
% given filename. Used to generate type and constructor signatures
% which will be further manipulated to get type inference
type_check(File) :- %writeln(File),
        open(File,read,Source),
        Type = user,
        write_predefined(Type),
        read_and_expand(Source,Type).
        %close(Type).
        %close(Source).        

add_arguments([],[]).
add_arguments([(Pred/Arity)|Preds],[APred|APreds]) :-
        functor(APred,Pred,Arity),
        add_arguments(Preds,APreds).

% adds into the current environment the var-type pairs according 
% to the head prediactes and the so far inferred type to produce 
% the new environment.
add_to_env(Pred,PredType,EnvIn,EnvOut) :- 
        Pred =.. [PHead|PArgs], write(PHead), write('~~'),
        PredType =.. [THead|TArgs], writeln(THead),
        add_to_env_aux(PArgs,TArgs,EnvIn,EnvOut).

add_to_env_aux([],[],EnvIn,EnvIn).
add_to_env_aux([PArg|PArgs],[TArg|TArgs],EnvIn,EnvOut) :-
        decompose_args(PArg,TArg,EnvTemp), 
        append(EnvIn,EnvTemp,EnvOut1),
        add_to_env_aux(PArgs,TArgs,EnvOut1,EnvOut).

assert_typed(FullSignature) :-
        functor(FullSignature,Name,Arity),
        assertz(have_type(Name/Arity)).

check_for_failed([type_error(_Type,Error)|Tail]) :-
        ( Error == 'failed'
        -> true
        ; check_for_failed(Tail)
        ).

% used to handle proper and improper lists in the head type construction
construct_head_type(Pred,Pred,_,Pred) :- !.
construct_head_type(Pred,PType,Flag,Type) :- !,
        ( Flag == 'cons'
        -> Type = PType
        ; functor(Pred,Name,_Arity), construct_type(Name,PType,Type)
        ).
construct_head_type(Pred,PType,_,Type) :- 
        functor(Pred,Name,Arity), 
        ( (is_list(Pred) ; Name == '.' ; Arity == 0) % is proper or not proper list
        -> Type = PType
        ; construct_type(Name,PType,Type)% [Name|Ptype]
        ).

%construct_type(Name,PType,Type)
construct_type(Name,PType,Type) :-
        ( is_list(PType)
        -> Type =.. [Name|PType]
        ; Type =.. [Name,PType]
        ).

% invoked by add_to_env_aux is decompose_args/3, which gathers type
% information for the argument of the body according to the provided 
% type and returns the environment. Therefore [X|Y] - list(E) would 
% be [X-E, Y-list(E)] instead.
decompose_args(PArg,TArg,Env) :-
        ( var(PArg)
        -> Env = [PArg-TArg]
        ; ( type_check:constructor(PArg,TArg,[],Env)
          -> true
          ; (var(TArg)
            -> Env = [TArg-PArg]
            ; Env = []
            )
          )
        ).

do_term_expansion((:- compiler_options(Options)),[]) :-
    handle_options(Options).
do_term_expansion((:- type_check_options(Options)),[]) :-
    handle_options(Options).
do_term_expansion((:- runtime(Flag)),[]) :-
    handle_option(runtime(Flag)).
do_term_expansion((:- multitype_predicates),[]) :-
        conset(atomicpred,1).
%do_term_expansion((:- infer Predicate),[]) :-
%        assert(infer_type(Predicate)).

% modified by Yu on Jun 22, replacing all asserts in
% do_term_expansion with asserta
% changing asserta to assertz
do_term_expansion((:- type Name ---> Constructors),
             Clauses
            ) :- 
    ( \+ \+ ( numbervars(Name, 0, _), ground(Constructors) ) ->
        phrase((type_check:constructor_clauses(Constructors,Name)),
                       Clauses),
            (member(Clause,Clauses),assertz(Clause),fail ; true)
    ;   
        format("ERROR: invalid TYPE definition~w\n\tType definitions must be range-restricted!\n", [(:- type Name ---> Constructors)]),
        Clauses = []
    ).

do_term_expansion((:- type Alias == Type),
            [ Clause
            ]) :-
    basic_normalize_clause(Alias,Type,Clause),
        % Need to assert this manually so that it can be available
        % later to the type checker
        assertz(Clause).

do_term_expansion((:- type _Name),[]).      % empty type
do_term_expansion((:- pred FullSignature),
            [ Clause
            ]) :-
        assert_typed(FullSignature),
    type_check:strip_modes(FullSignature,Signature), 
        extract_types([Sig],[Signature]), 
    type_check:signature_clause(Sig,Clause), 
        % Need to assert this manually so that it can be available
        % later to the type checker
        assertz(Clause).

do_term_expansion((:- trust_pred FullSignature),
            [ SignatureClause
            , TrustedPredicateClause
            ]) :-
        assert_typed(FullSignature),
    type_check:strip_modes(FullSignature,Signature),
    type_check:signature_clause(Signature,SignatureClause),
    functor(Signature,P,N),
    TrustedPredicateClause = trusted_predicate(P/N),
        % Need to assert these manually so that they can be available
        % later to the type checker
        assertz(SignatureClause),
        assertz(TrustedPredicateClause).

% at end_of_file : 
% modified type_check_file by Yu on Jun 22 to observe the signature
% in type_check.pl
do_term_expansion(end_of_file,Clauses) :-
        type_check:type_check_file(Clauses).
    /*type_check_file(Clauses,Error),
        writeln(Error),
        (Error > 0
        -> assert(delete_file(yes))
        ; true).*/

%do_term_expansion(end_of_file,_Clauses).
:- dynamic '$$clause'/1.

do_term_expansion(Clause, NClause) :-
        findall(Name,have_type(Name/_Arity),_List), %writeln(List),
        ( type_check:only_check_participating_clauses(Clause)
       -> assertz(clause_to_check(Clause))
        %; assert(Clause) ),
        ; assertz('$$clause'(Clause)) ),
        NClause = [].

extract_types([],[]).
extract_types([Pred|Preds],[Type|Types]) :- 
        extract_type(Pred,Type), 
        extract_types(Preds,Types).

extract_type(Pred,Type) :- var(Pred), var(Type), !, Type = Pred.
extract_type('$$type'(integer,T2,T3,T4),integer) :- 
        var(T2), var(T3), var(T4), !.
extract_type('$$type'(T1,float,T3,T4),float) :-
        var(T1), var(T3), var(T4), !.
extract_type('$$type'(integer,float,T3,T4),number) :- 
        var(T3), var(T4), !.
extract_type('$$type'(integer,float,string,T4),atomic) :- 
        var(T4), !.
extract_type('$$type'(T1,float,string,T4),atomic) :- 
        var(T1), var(T4), !.
extract_type('$$type'(integer,T2,string,T4),atomic) :- 
        var(T2), var(T4), !.
extract_type('$$type'(T1,T2,T3,term),term) :-
        var(T1), var(T2), var(T3), !.
% Now, univ can be given the type 'multitype'!
extract_type('$$type'(T1,T2,T3,term),multitype) :-
        (nonvar(T1) ; nonvar(T2) ; nonvar(T3)), !.
% If we want to extract types
extract_type(Pred,Type) :- var(Type), !, 
        Pred =.. [Name|Args],
        extract_types(Args,TArgs),
        Type =.. [Name|TArgs].
% If we want to pack types
extract_type(Pred,Type) :- var(Pred), !, 
        Type =.. [Name|TArgs],
        extract_types(Args,TArgs),
        Pred =.. [Name|Args].
 
find_clause(Pred,Body) :- '$$clause'(:-(Pred,Body)).
find_clause(Pred,true) :- '$$clause'(Pred).

%find_inferred(Pred,Body) :- '$$inferred'(:-(Pred,Body)).
find_inferred(Pred1,Pred2) :- '$$inferred'(Pred2), 
                            functor(Pred1, Head, Num),
                            functor(Pred2, Head, Num). 

find_constructor(Pred,Type,EnvIn,EnvOut,_) :- 
        type_check:signature(Pred,Type,EnvIn,EnvOut).
find_constructor(Pred,Type,EnvIn,EnvOut,Flag) :- 
        type_check:constructor(Pred,Type,EnvIn,EnvOut), !,
        Flag = 'cons'.
find_constructor(Pred,Type,EnvIn,EnvOut,Flag) :- 
        type_check:constructor_info(Pred,Type,EnvIn,EnvOut), !,
        Flag = 'cons'.
find_constructor(Pred,Type,EnvIn,EnvIn,Flag) :- 
        functor_constraint:functor_constraint(Pred,Type,_Args,_Types),
        Flag = 'cons'.

find_predicates(Source,[Pred|PredList],[TypedPred|TypedPredList]) :- 
        read(Source,Term),
        find_pred(Term,Pred,TypedPred),
        ( Term = end_of_file
        -> Pred = [], PredList = [], TypedPred = [], TypedPredList = []
        ; find_predicates(Source,PredList,TypedPredList)
        ).

find_pred((:- compiler_options(_X)),[],[]).
find_pred((:- pred(TypedPred)),[],TypedPred).
find_pred(Clause,Pred,[]) :- 
        ( Clause = (:-(Head,_Body))
        -> functor(Head,Name,Arity),
            Pred = (Name/Arity)
        ; functor(Clause,Name,Arity),
            Pred = (Name/Arity)
        ).
find_pred(end_of_file,[],[]).

format_clause_and_write(Type,Term) :- 
        ( type_check:only_check_participating_clauses(Term)
        -> ( type_checking_runtime
           -> type_check:only_check_participating_clauses(Term,FA),
               wrapper_clause(FA,WrapperTerm),
               write_canonical(Type,WrapperTerm),
               writeln(Type,'.'),
               type_check:tc_clause(Term,TcTerm),
               write_canonical(Type,TcTerm),
               writeln(Type,'.')
           ; write_canonical(Type,Term),
               writeln(Type,'.') )
        ; true ).

% returns a list of free variables in Term
% freevars(Term, Vars).
freevars(Term,Vars) :- freevars(Term,[],Vars).

freevars(Term,Vars,[Term|Vars]) :- var(Term), !.
freevars(Term,Vars,Vars) :- atom(Term), !.
freevars(Term,Vars0,Vars) :- 
        Term =.. [_Head|Tail],
        freevars1(Tail,Vars0,Vars).

freevars1([],Vars,Vars).
freevars1([Head|Tail],Vars0,Vars) :-
        freevars(Head,Vars0,Vars1),
        freevars1(Tail,Vars1,Vars).

% get_env(Body, Head, PredType, EnvIn, EnvOut)
% '$$type'(integer,float,string,term).

% modified how to handle G1->G2;G3 on Jun 29
% so that it is able to resolve the problems when processing t10.P
% as the same variable Y might have already been instantiated (24)
% and trying to unify with another one (0) would cause failure.
get_env(!,_Pred,_,Env,Env) :- !.
get_env(true,_Pred,_PredType,EnvIn,EnvIn) :- !.
get_env(fail,_Pred,_PredType,EnvIn,EnvIn) :- !.
get_env((G1,G2),Pred,PredType,EnvIn,EnvOut) :- !,
        get_env(G1,Pred,PredType,EnvIn,EnvOut1),
        get_env(G2,Pred,PredType,EnvOut1,EnvOut).
get_env((G1->G2;G3),Pred,PredType,EnvIn,EnvOut) :- !, 
        get_env(G1,Pred,PredType,EnvIn,EnvOut1), 
        get_env(G2,Pred,PredType,EnvOut1,EnvOut2),
        %(get_env(G2,Pred,PredType,EnvOut1,EnvOut);
        get_env(G3,Pred,PredType,EnvOut2,EnvOut).
        %get_env(G3,Pred,PredType,EnvOut1,EnvOut)).
get_env((G is Gar),_Pred,_PredType,EnvIn,EnvOut) :- !,
        Gar =.. [_Name|Args], 
        get_arithmetic_types(Args,EnvOut1,Type),
        append([G-Type|EnvIn],EnvOut1,EnvOut).
get_env(integer(G),_Pred,_PredType,EnvIn,EnvOut) :-
        append(EnvIn,[G-'$$type'(integer,_,_,_)],EnvOut), !.
get_env(float(G),_Pred,_PredType,EnvIn,EnvOut) :-
        append(EnvIn,[G-'$$type'(_,float,_,_)],EnvOut), !.
get_env((G1 < G2),_Pred,_PredType,EnvIn,EnvOut) :- !,
        get_arithmetic_types([G1,G2],EnvOut1,_Type),
        append(EnvIn,EnvOut1,EnvOut).
get_env((G1 > G2),_Pred,_PredType,EnvIn,EnvOut) :- !,
        get_arithmetic_types([G1,G2],EnvOut1,_Type),
        append(EnvIn,EnvOut1,EnvOut).
get_env((G1 =< G2),_Pred,_PredType,EnvIn,EnvOut) :- !,
        get_arithmetic_types([G1,G2],EnvOut1,_Type),
                append(EnvIn,EnvOut1,EnvOut).
get_env((G1 == G2),_Pred,_PredType,EnvIn,EnvOut) :- !,
        get_arithmetic_types([G1,G2],EnvOut1,_Type),
        append(EnvIn,EnvOut1,EnvOut).
get_env((G1 =:= G2),_Pred,_PredType,EnvIn,EnvOut) :- !,
        get_arithmetic_types([G1,G2],EnvOut1,_Type),
        append(EnvIn,EnvOut1,EnvOut).
get_env((G1 >= G2),_Pred,_PredType,EnvIn,EnvOut) :- !,
        get_arithmetic_types([G1,G2],EnvOut1,_Type),
        append(EnvIn,EnvOut1,EnvOut).
get_env((G1 \= G2),_Pred,_PredType,EnvIn,EnvOut) :- !,
        get_arithmetic_types([G1,G2],EnvOut1,_Type),
        append(EnvIn,EnvOut1,EnvOut).
get_env((G1 = G2),_Pred,_PredType,EnvIn,EnvIn) :- !, 
        G1 = G2.
get_env(Body,Pred,PredType,EnvIn,EnvOut) :-
        ( same_pred(Pred,Body)
        -> ( \+ var(PredType)
           -> %copy_term messes with var names, so p/1 gets a type
               infer_body(Body,EnvIn,BodyType), 
               copy_term(BodyType,BodyType1), 
               copy_term(PredType,PredType1),
               BodyType1 = PredType1, 
               add_to_env(Body,PredType1,EnvIn,EnvOut),
               PredType1 = PredType 
           ; EnvIn = EnvOut
           )
        ; type_check:signature(Body,_BType,EnvIn,EnvOut), !
        ; type_check:constructor(Body,_BType,EnvIn,EnvOut), !
        ; ( 
            ansi_format([bold,fg(magenta)], '##################### ~w #####################', [getenv]), nl,
            do_type_inference_tabled(Body,_,BodyType)
          -> true
          ; infer_body(Body,EnvIn,BodyType),
            PredType = BodyType
          ),
          add_to_env(Body,BodyType,EnvIn,EnvOut) 
        ).

% make these correspond to Prolog's typing for arithmetic operations
% get_arithmetic_types(Args, EnvOut, Type)
get_arithmetic_types([Arg1,Arg2],[Arg1-'$$type'(integer,_,_,_)],'$$type'(integer,_,_,_)) :-
        var(Arg1), integer(Arg2).
get_arithmetic_types([Arg1,Arg2],[Arg2-'$$type'(integer,_,_,_)],'$$type'(integer,_,_,_)) :-
        integer(Arg1), var(Arg2), !.
get_arithmetic_types([Arg1,Arg2],[],'$$type'(integer,_,_,_)) :-
        integer(Arg1), integer(Arg2).
get_arithmetic_types([Arg1,Arg2],[Arg1-'$$type'(_,float,_,_)],'$$type'(_,float,_,_)) :-
        var(Arg1), float(Arg2), !.
get_arithmetic_types([Arg1,Arg2],[Arg2-'$$type'(_,float,_,_)],'$$type'(_,float,_,_)) :-
        float(Arg1), var(Arg2), !.
get_arithmetic_types([Arg1,Arg2],[],'$$type'(_,float,_,_)) :- 
        float(Arg1), float(Arg2), !.

% computes the type of the head predicate given current environment
% get_head_type(Pred, EnvIn, PredType).
get_head_type(Pred, EnvIn, PredType) :-
		Pred =.. [Name|Args],
		get_head_type_aux1(EnvIn, Args, TypedArgs, EnvOut),
		PredType =.. [Name|TypedArgs],
		freevars(PredType, Vars),
		get_type_bindings(PredType, Vars, EnvOut).

% added by Yu on Jul 2 to process Pred as nested list
% get_head_type_aux1(Env,[],[],Env).
% get_head_type_aux1(Env,[Pred|Preds],[TArg|TArgs],EnvOut) :-
%        get_head_type_aux(Env,Pred,EnvOut1,TArg), 
%        get_head_type_aux1(EnvOut1,Preds,TArgs,EnvOut).
get_head_type_aux1(Env,[],[],Env).
get_head_type_aux1(Env,[Pred|Preds],[TArg|TArgs],EnvOut) :-
        get_head_type_aux(Env,Pred,EnvOut1,TArg), 
        get_head_type_aux1(EnvOut1,Preds,TArgs,EnvOut).

% get_head_type_aux(EnvIn, Pred, EnvOut, TypedPred).
get_head_type_aux(Env,Pred,Env,Pred) :-  var(Pred), !.
get_head_type_aux(Env,Pred,Env,Pred) :- \+ not_dollar(Pred), !.
get_head_type_aux(Env,number,Env,'$$type'(integer,float,_,_)) :- !.
get_head_type_aux(Env,integer,Env,'$$type'(integer,_,_,_)) :- !.
get_head_type_aux(Env,float,Env,'$$type'(_,float,_,_)) :- !.
get_head_type_aux(Env,string,Env,'$$type'(_,_,string,_)) :- !.
get_head_type_aux(Env,Pred,Env,'$$type'(integer,_,_,_)) :-
        \+ var(Pred), integer(Pred),
        \+ (type_check:constructor_info(Pred,_,_,_)), !.
get_head_type_aux(Env,Pred,Env,'$$type'(_,float,_,_)) :-
        \+ var(Pred), float(Pred),
        \+ (type_check:constructor_info(Pred,_,_,_)), !. 
get_head_type_aux(Env,Pred,Env,Type) :- 
        \+ var(Pred), atom(Pred), \+ is_list(Pred),
        ( type_check:constructor_info(Pred,_,_,_),!
        -> Type = Pred
        ; ( type_check:constructor_info(_,Pred,_,_),!
          -> Type = Pred
          ; Type = '$$type'(_,_,string,_)
          )
        ), !.
get_head_type_aux(EnvIn,Pred,EnvOut,Type) :- \+ var(Pred), 
         unground(Pred,UPred,Env1), 
         ( find_constructor(UPred,PType,EnvIn,EnvOut1,Flag)
          -> construct_head_type(UPred,PType,Flag,Type), 
            append(Env1,EnvOut1,EnvOut2),remove_empty(EnvOut2,EnvOut) 
        ; get_head_type_aux2(EnvIn,Pred,EnvOut,Type)
        ).

get_head_type_aux2(Env,Pred,Env,Type) :- 
        not_dollar(Pred),
        \+ var(Pred), \+ atom(Pred), \+ is_list(Pred), \+ number(Pred),
        \+ type_check:signature(Pred,_,_,_),
        \+ type_check:constructor_info(Pred,_,_,_),
        \+ type_check:constructor_info(_,Pred,_,_), 
        Type = '$$type'(_,_,_,term).

% extracts the types computed from the list of (Type, Error) pairs.
get_types_list([],[]).
get_types_list([type_error(Type,_Error)|Tail],[Type|TypeTail]) :- 
        get_types_list(Tail,TypeTail).

% binds variables in the second argument with their repsected
% values in the environment, therefore getting all the var-type 
% pairs first as members of the environment, and then do one more 
% pass on the freevars list to do the actual binding. This is done 
% lazily and only once for each run of the algorithm.
get_type_bindings(_Pred,_Vars,Env) :- flatten(Env,Env1),
        unifup(Env1).

% similar to get_head_type/3, but does not bind variables to their types 
infer_body(Body,EnvIn,TBody) :- 
        Body =.. [Name|Args], 
        get_head_type_aux1(EnvIn,Args,TypedArgs,_EnvOut),
        TBody  =.. [Name|TypedArgs].

infer_body1(Body,EnvIn,TBody,EnvOut) :-
        Body =.. [Name|Args],
        get_head_type_aux1(EnvIn,Args,TypedArgs,EnvOut),
        TBody  =.. [Name|TypedArgs].

% make sure the functor of the Pred is not '$$type'
% not_dollar(Pred)
not_dollar(Pred) :-
        functor(Pred,Name,_Arity),
        Name \== '$$type'.

/*
% modified by Yu on Jun 23 to solve repetitive exits of type_check
% which resulted from the fail in printlist
printlist(List) :-
    member(X, List),
    writeln(X),
    fail.
*/

:- dynamic '$$inferred'/1.

printlist([]).
printlist([Head|Tail]) :-
    writeln(Head), 
    assertz('$$inferred'(Head)),
    printlist(Tail).

predefined(Expanded) :- do_term_expansion((:- type list(T) ---> [] ; [T|list(T)]),Expanded).
%predefined(Expanded) :- do_term_expansion((:- type pair(A,B) ---> A - B),Expanded).
predefined(Expanded) :- do_term_expansion((:- type boolean ---> true ; false),Expanded).
predefined(Expanded) :- do_term_expansion((:- type cmp ---> (=) ; (>) ; (<)),Expanded).
predefined(Expanded) :- do_term_expansion((:- pred compare(cmp,T,T)),Expanded).

read_and_expand(Source,Type) :-
        read(Source,Term),
        do_term_expansion(Term,_ExpandedTerm),
        format_clause_and_write(Type,Term),
        ( Term = end_of_file
        -> true
        ;   %write_canonical(ExpandedTerm),
            %write_canonical(Type,ExpandedTerm),
            %writeln(Type,'.'),
            read_and_expand(Source,Type) ).

remove_empty([],[]).
remove_empty([Env|Envs],NEnvs) :-
        Env == [],
        remove_empty(Envs,NEnvs).
remove_empty([Env|Envs],[Env|NEnvs]) :-
        Env \== [],
        remove_empty(Envs,NEnvs).

% determine if Pred1 and Pred2 have the same functor name and arity
% used to determine whether a predicate only appears in the body
% if so, we can call signature/4 or constructor/4 automatically;
% if not, we need to manually add the var-type bindings using add_env/4  
% same_pred(Pred1, Pred2).
same_pred(Pred1,Pred2) :- % simplify
        functor(Pred1,Name,Arity),
        functor(Pred2,Name,Arity).

% examines whether two given lists of types are equal or not; considering
% that they will always be sorted, if the corresponding elements are variants
% of each other, they are deemed as equal.
test_for_inequality([TypeIn|TypesIn], [TypeOut|TypesOut]) :-
        ( \+ variant(TypeIn,TypeOut)
        -> true
        ; test_for_inequality(TypesIn,TypesOut)
        ).

% given a partially typed predicate as argument, returns an ungrounded
% version by replacing all ground arguments with variables as well as the 
% new environment.
unground(Pred,UPred,Env) :- 
        Pred =.. [Name|Args],
        unground_args(Args,UArgs,Env), 
        UPred =.. [Name|UArgs].

unground_args([],[],[]).
unground_args([Arg|Args],[UArg|UArgs],[Env|Envs]) :- 
        unground_args1(Arg,UArg,Env),
        unground_args(Args,UArgs,Envs).

unground_args1(Arg,Arg,[]) :- var(Arg), !.
unground_args1(Arg,UArg,Env) :- 
        ( find_constructor(Arg,_,_,_,_), !
        -> unground(Arg,UArg,Env)
        ; get_head_type_aux([],Arg,_Env,Type),
          Env = [UArg-Type]
        ).

% unify all the elements of a list pairwise: 1st w/ 2nd and 2nd w/ 3rd.
unify_list_elements([_Head|[]]).
unify_list_elements(Head) :- Head == [].
unify_list_elements([Head1,Head2|Tail]) :- 
        Head1 = Head2,
        unify_list_elements([Head2|Tail]).


unifup([]).
unifup([K-V|KVs]) :-
        K = V,
        unifup(KVs).

/* Predefined types:
 * List
 * Pair
 * Boolean
 * Cmp (compare)
 * compare/3
 */
write_predefined(Dest) :- 
        findall(ExpandedTerm,predefined(ExpandedTerm),ExpandedTermList),
        write_list(Dest,ExpandedTermList).

write_list(_,[]).
write_list(Dest,[_ExpandedTerm|ExpandedTerms]) :-
        %write_canonical(Dest,ExpandedTerm),
        %writeln(Dest,'.'),
        write_list(Dest,ExpandedTerms).
