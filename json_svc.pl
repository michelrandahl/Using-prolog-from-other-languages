:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).
:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_json)).
:- use_module(library(clpfd)).
:- http_handler(root(handle), handle_rpc, []).

http_json:json_type('application/json-rpc').

%sudoku
sudoku(Rows) :-
    length(Rows, 9), maplist(length_(9), Rows),
    append(Rows, Vs), Vs ins 1..9,
    maplist(all_distinct, Rows),
    transpose(Rows, Columns),
    maplist(all_distinct, Columns),
    Rows = [A,B,C,D,E,F,G,H,I],
    blocks(A, B, C), blocks(D, E, F), blocks(G, H, I).

length_(L, Ls) :- length(Ls, L).
blocks([], [], []).
blocks([A,B,C|Bs1], [D,E,F|Bs2], [G,H,I|Bs3]) :-
    all_distinct([A,B,C,D,E,F,G,H,I]),
    blocks(Bs1, Bs2, Bs3).

%web stuff
server(Port) :-
  http_server(http_dispatch, [port(Port)]).

handle_rpc(Request) :-
	http_read_json(Request, JSONIn),
	json_to_prolog(JSONIn, PrologIn),
	evaluate(PrologIn, PrologOut), % application body
	PrologOut = JSONOut,
	reply_json(JSONOut).

evaluate(PrologIn, PrologOut) :-
	PrologIn = json([jsonrpc=Version, params=[Query], id=Id, method=MethodName]),
	MethodName = eval,
	atom_to_term(Query, Term, Bindings),
	Goal =.. [findall, Bindings, Term, Result],
	call(Goal),
	format(atom(StringResult), "~q", Result),
	PrologOut = json([jsonrpc=Version, result=StringResult, id=Id]).
