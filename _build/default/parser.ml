
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | WHILE
    | VIRG
    | TRUE
    | SLASH
    | RETURN
    | RAT
    | PV
    | PRINT
    | PO
    | PLUS
    | PF
    | NUM
    | NULL
    | NEW
    | MULT
    | INT
    | INF
    | IF
    | ID of (
# 11 "parser.mly"
       (string)
# 33 "parser.ml"
  )
    | FALSE
    | EQUAL
    | EOF
    | ENTIER of (
# 10 "parser.mly"
       (int)
# 41 "parser.ml"
  )
    | ELSE
    | DENOM
    | CONST
    | CO
    | CF
    | BOOL
    | AO
    | AND
    | AF
  
end

include MenhirBasics

# 3 "parser.mly"
  

open Type
open Ast.AstSyntax

# 63 "parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState000 : ('s, _menhir_box_main) _menhir_state
    (** State 000.
        Stack shape : .
        Start symbol: main. *)

  | MenhirState007 : (('s, _menhir_box_main) _menhir_cell1_typ _menhir_cell0_ID, _menhir_box_main) _menhir_state
    (** State 007.
        Stack shape : typ ID.
        Start symbol: main. *)

  | MenhirState012 : (('s, _menhir_box_main) _menhir_cell1_param, _menhir_box_main) _menhir_state
    (** State 012.
        Stack shape : param.
        Start symbol: main. *)

  | MenhirState015 : ((('s, _menhir_box_main) _menhir_cell1_typ _menhir_cell0_ID, _menhir_box_main) _menhir_cell1_loption_separated_nonempty_list_VIRG_param__, _menhir_box_main) _menhir_state
    (** State 015.
        Stack shape : typ ID loption(separated_nonempty_list(VIRG,param)).
        Start symbol: main. *)

  | MenhirState016 : (('s, _menhir_box_main) _menhir_cell1_AO, _menhir_box_main) _menhir_state
    (** State 016.
        Stack shape : AO.
        Start symbol: main. *)

  | MenhirState017 : (('s, _menhir_box_main) _menhir_cell1_WHILE, _menhir_box_main) _menhir_state
    (** State 017.
        Stack shape : WHILE.
        Start symbol: main. *)

  | MenhirState019 : (('s, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_state
    (** State 019.
        Stack shape : PO.
        Start symbol: main. *)

  | MenhirState020 : (('s, _menhir_box_main) _menhir_cell1_NUM, _menhir_box_main) _menhir_state
    (** State 020.
        Stack shape : NUM.
        Start symbol: main. *)

  | MenhirState023 : (('s, _menhir_box_main) _menhir_cell1_ID, _menhir_box_main) _menhir_state
    (** State 023.
        Stack shape : ID.
        Start symbol: main. *)

  | MenhirState026 : (('s, _menhir_box_main) _menhir_cell1_DENOM, _menhir_box_main) _menhir_state
    (** State 026.
        Stack shape : DENOM.
        Start symbol: main. *)

  | MenhirState027 : (('s, _menhir_box_main) _menhir_cell1_CO, _menhir_box_main) _menhir_state
    (** State 027.
        Stack shape : CO.
        Start symbol: main. *)

  | MenhirState031 : ((('s, _menhir_box_main) _menhir_cell1_CO, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_state
    (** State 031.
        Stack shape : CO e.
        Start symbol: main. *)

  | MenhirState040 : (('s, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_state
    (** State 040.
        Stack shape : e.
        Start symbol: main. *)

  | MenhirState043 : ((('s, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_NEW, _menhir_box_main) _menhir_state
    (** State 043.
        Stack shape : PO NEW.
        Start symbol: main. *)

  | MenhirState045 : ((('s, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_MULT, _menhir_box_main) _menhir_state
    (** State 045.
        Stack shape : PO MULT.
        Start symbol: main. *)

  | MenhirState046 : (((('s, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_MULT, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_state
    (** State 046.
        Stack shape : PO MULT PO.
        Start symbol: main. *)

  | MenhirState051 : ((('s, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_state
    (** State 051.
        Stack shape : PO e.
        Start symbol: main. *)

  | MenhirState055 : ((('s, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_state
    (** State 055.
        Stack shape : PO e.
        Start symbol: main. *)

  | MenhirState058 : ((('s, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_state
    (** State 058.
        Stack shape : PO e.
        Start symbol: main. *)

  | MenhirState061 : ((('s, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_state
    (** State 061.
        Stack shape : PO e.
        Start symbol: main. *)

  | MenhirState064 : ((('s, _menhir_box_main) _menhir_cell1_WHILE, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_state
    (** State 064.
        Stack shape : WHILE e.
        Start symbol: main. *)

  | MenhirState066 : (('s, _menhir_box_main) _menhir_cell1_RETURN, _menhir_box_main) _menhir_state
    (** State 066.
        Stack shape : RETURN.
        Start symbol: main. *)

  | MenhirState069 : (('s, _menhir_box_main) _menhir_cell1_PRINT, _menhir_box_main) _menhir_state
    (** State 069.
        Stack shape : PRINT.
        Start symbol: main. *)

  | MenhirState072 : (('s, _menhir_box_main) _menhir_cell1_IF, _menhir_box_main) _menhir_state
    (** State 072.
        Stack shape : IF.
        Start symbol: main. *)

  | MenhirState073 : ((('s, _menhir_box_main) _menhir_cell1_IF, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_state
    (** State 073.
        Stack shape : IF e.
        Start symbol: main. *)

  | MenhirState075 : (((('s, _menhir_box_main) _menhir_cell1_IF, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_cell1_bloc, _menhir_box_main) _menhir_state
    (** State 075.
        Stack shape : IF e bloc.
        Start symbol: main. *)

  | MenhirState078 : (('s, _menhir_box_main) _menhir_cell1_ID, _menhir_box_main) _menhir_state
    (** State 078.
        Stack shape : ID.
        Start symbol: main. *)

  | MenhirState089 : (('s, _menhir_box_main) _menhir_cell1_typ _menhir_cell0_ID, _menhir_box_main) _menhir_state
    (** State 089.
        Stack shape : typ ID.
        Start symbol: main. *)

  | MenhirState093 : (('s, _menhir_box_main) _menhir_cell1_typ _menhir_cell0_ID, _menhir_box_main) _menhir_state
    (** State 093.
        Stack shape : typ ID.
        Start symbol: main. *)

  | MenhirState098 : (('s, _menhir_box_main) _menhir_cell1_i, _menhir_box_main) _menhir_state
    (** State 098.
        Stack shape : i.
        Start symbol: main. *)

  | MenhirState105 : (('s, _menhir_box_main) _menhir_cell1_list_fonc_ _menhir_cell0_ID, _menhir_box_main) _menhir_state
    (** State 105.
        Stack shape : list(fonc) ID.
        Start symbol: main. *)

  | MenhirState107 : (('s, _menhir_box_main) _menhir_cell1_fonc, _menhir_box_main) _menhir_state
    (** State 107.
        Stack shape : fonc.
        Start symbol: main. *)


and ('s, 'r) _menhir_cell1_bloc = 
  | MenhirCell1_bloc of 's * ('s, 'r) _menhir_state * (Ast.AstSyntax.bloc)

and ('s, 'r) _menhir_cell1_e = 
  | MenhirCell1_e of 's * ('s, 'r) _menhir_state * (Ast.AstSyntax.expression)

and ('s, 'r) _menhir_cell1_fonc = 
  | MenhirCell1_fonc of 's * ('s, 'r) _menhir_state * (Ast.AstSyntax.fonction)

and ('s, 'r) _menhir_cell1_i = 
  | MenhirCell1_i of 's * ('s, 'r) _menhir_state * (Ast.AstSyntax.instruction)

and ('s, 'r) _menhir_cell1_list_fonc_ = 
  | MenhirCell1_list_fonc_ of 's * ('s, 'r) _menhir_state * (Ast.AstSyntax.fonction list)

and ('s, 'r) _menhir_cell1_loption_separated_nonempty_list_VIRG_param__ = 
  | MenhirCell1_loption_separated_nonempty_list_VIRG_param__ of 's * ('s, 'r) _menhir_state * ((Type.typ * string) list)

and ('s, 'r) _menhir_cell1_param = 
  | MenhirCell1_param of 's * ('s, 'r) _menhir_state * (Type.typ * string)

and ('s, 'r) _menhir_cell1_typ = 
  | MenhirCell1_typ of 's * ('s, 'r) _menhir_state * (Type.typ)

and ('s, 'r) _menhir_cell1_AO = 
  | MenhirCell1_AO of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_CO = 
  | MenhirCell1_CO of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_DENOM = 
  | MenhirCell1_DENOM of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_ID = 
  | MenhirCell1_ID of 's * ('s, 'r) _menhir_state * (
# 11 "parser.mly"
       (string)
# 264 "parser.ml"
)

and 's _menhir_cell0_ID = 
  | MenhirCell0_ID of 's * (
# 11 "parser.mly"
       (string)
# 271 "parser.ml"
)

and ('s, 'r) _menhir_cell1_IF = 
  | MenhirCell1_IF of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_MULT = 
  | MenhirCell1_MULT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_NEW = 
  | MenhirCell1_NEW of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_NUM = 
  | MenhirCell1_NUM of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_PO = 
  | MenhirCell1_PO of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_PRINT = 
  | MenhirCell1_PRINT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_RETURN = 
  | MenhirCell1_RETURN of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_WHILE = 
  | MenhirCell1_WHILE of 's * ('s, 'r) _menhir_state

and _menhir_box_main = 
  | MenhirBox_main of (Ast.AstSyntax.programme) [@@unboxed]

let _menhir_action_01 =
  fun a ->
    (
# 107 "parser.mly"
                          (Ident a)
# 306 "parser.ml"
     : (Ast.AstSyntax.affectable))

let _menhir_action_02 =
  fun aff ->
    (
# 108 "parser.mly"
                          (Deref aff)
# 314 "parser.ml"
     : (Ast.AstSyntax.affectable))

let _menhir_action_03 =
  fun li ->
    (
# 66 "parser.mly"
                        (li)
# 322 "parser.ml"
     : (Ast.AstSyntax.bloc))

let _menhir_action_04 =
  fun n xs ->
    let lp = 
# 229 "<standard.mly>"
    ( xs )
# 330 "parser.ml"
     in
    (
# 86 "parser.mly"
                                         (AppelFonction (n,lp))
# 335 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_05 =
  fun e1 e2 ->
    (
# 87 "parser.mly"
                          (Binaire(Fraction,e1,e2))
# 343 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_06 =
  fun () ->
    (
# 88 "parser.mly"
                          (Booleen true)
# 351 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_07 =
  fun () ->
    (
# 89 "parser.mly"
                          (Booleen false)
# 359 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_08 =
  fun e ->
    (
# 90 "parser.mly"
                          (Entier e)
# 367 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_09 =
  fun e1 ->
    (
# 91 "parser.mly"
                          (Unaire(Numerateur,e1))
# 375 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_10 =
  fun e1 ->
    (
# 92 "parser.mly"
                          (Unaire(Denominateur,e1))
# 383 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_11 =
  fun e1 e2 ->
    (
# 93 "parser.mly"
                          (Binaire (Plus,e1,e2))
# 391 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_12 =
  fun e1 e2 ->
    (
# 94 "parser.mly"
                          (Binaire (Mult,e1,e2))
# 399 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_13 =
  fun e1 e2 ->
    (
# 95 "parser.mly"
                          (Binaire (Equ,e1,e2))
# 407 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_14 =
  fun e1 e2 ->
    (
# 96 "parser.mly"
                          (Binaire (Inf,e1,e2))
# 415 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_15 =
  fun exp ->
    (
# 97 "parser.mly"
                          (exp)
# 423 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_16 =
  fun t ->
    (
# 98 "parser.mly"
                          (New t)
# 431 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_17 =
  fun aff ->
    (
# 99 "parser.mly"
                          (Affectation aff)
# 439 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_18 =
  fun n ->
    (
# 100 "parser.mly"
                          (Addr n)
# 447 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_19 =
  fun () ->
    (
# 101 "parser.mly"
                          (Null)
# 455 "parser.ml"
     : (Ast.AstSyntax.expression))

let _menhir_action_20 =
  fun li n t xs ->
    let lp = 
# 229 "<standard.mly>"
    ( xs )
# 463 "parser.ml"
     in
    (
# 62 "parser.mly"
                                                              (Fonction(t,n,lp,li))
# 468 "parser.ml"
     : (Ast.AstSyntax.fonction))

let _menhir_action_21 =
  fun e1 n t ->
    (
# 69 "parser.mly"
                                    (Declaration (t,n,e1))
# 476 "parser.ml"
     : (Ast.AstSyntax.instruction))

let _menhir_action_22 =
  fun e1 n ->
    (
# 70 "parser.mly"
                                    (Affectation (n,e1))
# 484 "parser.ml"
     : (Ast.AstSyntax.instruction))

let _menhir_action_23 =
  fun e n ->
    (
# 71 "parser.mly"
                                    (Constante (n,e))
# 492 "parser.ml"
     : (Ast.AstSyntax.instruction))

let _menhir_action_24 =
  fun e1 ->
    (
# 72 "parser.mly"
                                    (Affichage (e1))
# 500 "parser.ml"
     : (Ast.AstSyntax.instruction))

let _menhir_action_25 =
  fun exp li1 li2 ->
    (
# 73 "parser.mly"
                                    (Conditionnelle (exp,li1,li2))
# 508 "parser.ml"
     : (Ast.AstSyntax.instruction))

let _menhir_action_26 =
  fun exp li ->
    (
# 74 "parser.mly"
                                    (TantQue (exp,li))
# 516 "parser.ml"
     : (Ast.AstSyntax.instruction))

let _menhir_action_27 =
  fun exp ->
    (
# 75 "parser.mly"
                                    (Retour (exp))
# 524 "parser.ml"
     : (Ast.AstSyntax.instruction))

let _menhir_action_28 =
  fun e1 n t ->
    (
# 76 "parser.mly"
                                    (Declaration (Addr t,n,e1))
# 532 "parser.ml"
     : (Ast.AstSyntax.instruction))

let _menhir_action_29 =
  fun () ->
    (
# 208 "<standard.mly>"
    ( [] )
# 540 "parser.ml"
     : (Ast.AstSyntax.fonction list))

let _menhir_action_30 =
  fun x xs ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 548 "parser.ml"
     : (Ast.AstSyntax.fonction list))

let _menhir_action_31 =
  fun () ->
    (
# 208 "<standard.mly>"
    ( [] )
# 556 "parser.ml"
     : (Ast.AstSyntax.bloc))

let _menhir_action_32 =
  fun x xs ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 564 "parser.ml"
     : (Ast.AstSyntax.bloc))

let _menhir_action_33 =
  fun () ->
    (
# 139 "<standard.mly>"
    ( [] )
# 572 "parser.ml"
     : (Ast.AstSyntax.expression list))

let _menhir_action_34 =
  fun x ->
    (
# 141 "<standard.mly>"
    ( x )
# 580 "parser.ml"
     : (Ast.AstSyntax.expression list))

let _menhir_action_35 =
  fun () ->
    (
# 139 "<standard.mly>"
    ( [] )
# 588 "parser.ml"
     : ((Type.typ * string) list))

let _menhir_action_36 =
  fun x ->
    (
# 141 "<standard.mly>"
    ( x )
# 596 "parser.ml"
     : ((Type.typ * string) list))

let _menhir_action_37 =
  fun lfi ->
    (
# 58 "parser.mly"
                        (lfi)
# 604 "parser.ml"
     : (Ast.AstSyntax.programme))

let _menhir_action_38 =
  fun n t ->
    (
# 64 "parser.mly"
                    ((t,n))
# 612 "parser.ml"
     : (Type.typ * string))

let _menhir_action_39 =
  fun lf li ->
    (
# 60 "parser.mly"
                            (Programme (lf,li))
# 620 "parser.ml"
     : (Ast.AstSyntax.programme))

let _menhir_action_40 =
  fun x ->
    (
# 238 "<standard.mly>"
    ( [ x ] )
# 628 "parser.ml"
     : (Ast.AstSyntax.expression list))

let _menhir_action_41 =
  fun x xs ->
    (
# 240 "<standard.mly>"
    ( x :: xs )
# 636 "parser.ml"
     : (Ast.AstSyntax.expression list))

let _menhir_action_42 =
  fun x ->
    (
# 238 "<standard.mly>"
    ( [ x ] )
# 644 "parser.ml"
     : ((Type.typ * string) list))

let _menhir_action_43 =
  fun x xs ->
    (
# 240 "<standard.mly>"
    ( x :: xs )
# 652 "parser.ml"
     : ((Type.typ * string) list))

let _menhir_action_44 =
  fun () ->
    (
# 79 "parser.mly"
                (Bool)
# 660 "parser.ml"
     : (Type.typ))

let _menhir_action_45 =
  fun () ->
    (
# 80 "parser.mly"
                (Int)
# 668 "parser.ml"
     : (Type.typ))

let _menhir_action_46 =
  fun () ->
    (
# 81 "parser.mly"
                (Rat)
# 676 "parser.ml"
     : (Type.typ))

let _menhir_action_47 =
  fun t ->
    (
# 82 "parser.mly"
                (Addr t)
# 684 "parser.ml"
     : (Type.typ))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | AF ->
        "AF"
    | AND ->
        "AND"
    | AO ->
        "AO"
    | BOOL ->
        "BOOL"
    | CF ->
        "CF"
    | CO ->
        "CO"
    | CONST ->
        "CONST"
    | DENOM ->
        "DENOM"
    | ELSE ->
        "ELSE"
    | ENTIER _ ->
        "ENTIER"
    | EOF ->
        "EOF"
    | EQUAL ->
        "EQUAL"
    | FALSE ->
        "FALSE"
    | ID _ ->
        "ID"
    | IF ->
        "IF"
    | INF ->
        "INF"
    | INT ->
        "INT"
    | MULT ->
        "MULT"
    | NEW ->
        "NEW"
    | NULL ->
        "NULL"
    | NUM ->
        "NUM"
    | PF ->
        "PF"
    | PLUS ->
        "PLUS"
    | PO ->
        "PO"
    | PRINT ->
        "PRINT"
    | PV ->
        "PV"
    | RAT ->
        "RAT"
    | RETURN ->
        "RETURN"
    | SLASH ->
        "SLASH"
    | TRUE ->
        "TRUE"
    | VIRG ->
        "VIRG"
    | WHILE ->
        "WHILE"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_run_106 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_list_fonc_ _menhir_cell0_ID -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _v _tok ->
      let MenhirCell0_ID (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_list_fonc_ (_menhir_stack, _, lf) = _menhir_stack in
      let li = _v in
      let _v = _menhir_action_39 lf li in
      match (_tok : MenhirBasics.token) with
      | EOF ->
          let lfi = _v in
          let _v = _menhir_action_37 lfi in
          MenhirBox_main _v
      | _ ->
          _eRR ()
  
  let rec _menhir_run_001 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_46 () in
      _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_typ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState098 ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState016 ->
          _menhir_run_086 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState043 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState012 ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState007 ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState107 ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState000 ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_086 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | MULT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | ID _v_0 ->
              let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
              let _menhir_stack = MenhirCell0_ID (_menhir_stack, _v_0) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | EQUAL ->
                  let _menhir_s = MenhirState089 in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | TRUE ->
                      _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | PO ->
                      _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | NUM ->
                      _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | NULL ->
                      _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | ID _v ->
                      _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | FALSE ->
                      _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | ENTIER _v ->
                      _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | DENOM ->
                      _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | CO ->
                      _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | AND ->
                      _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | MULT ->
              let t = _v in
              let _v = _menhir_action_47 t in
              _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | ID _v_3 ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          let _menhir_stack = MenhirCell0_ID (_menhir_stack, _v_3) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | EQUAL ->
              let _menhir_s = MenhirState093 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TRUE ->
                  _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | PO ->
                  _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | NUM ->
                  _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | NULL ->
                  _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | ID _v ->
                  _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | FALSE ->
                  _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | ENTIER _v ->
                  _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | DENOM ->
                  _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | CO ->
                  _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | AND ->
                  _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_018 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_06 () in
      _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_e : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState093 ->
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState089 ->
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState078 ->
          _menhir_run_079 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState072 ->
          _menhir_run_073 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState069 ->
          _menhir_run_070 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState066 ->
          _menhir_run_067 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState017 ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState061 ->
          _menhir_run_062 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState058 ->
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState055 ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState051 ->
          _menhir_run_052 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState019 ->
          _menhir_run_050 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState020 ->
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState040 ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState023 ->
          _menhir_run_039 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState026 ->
          _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState031 ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState027 ->
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_094 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_typ _menhir_cell0_ID -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | PV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_ID (_menhir_stack, n) = _menhir_stack in
          let MenhirCell1_typ (_menhir_stack, _menhir_s, t) = _menhir_stack in
          let e1 = _v in
          let _v = _menhir_action_21 e1 n t in
          _menhir_goto_i _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_i : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_i (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState098
      | RETURN ->
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState098
      | RAT ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState098
      | PRINT ->
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState098
      | INT ->
          _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState098
      | IF ->
          _menhir_run_072 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState098
      | ID _v_0 ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState098
      | CONST ->
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState098
      | BOOL ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState098
      | AF ->
          let _v_1 = _menhir_action_31 () in
          _menhir_run_099 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1
      | _ ->
          _eRR ()
  
  and _menhir_run_017 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_WHILE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState017 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | PO ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NUM ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NULL ->
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ENTIER _v ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DENOM ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | CO ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AND ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_019 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_PO (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState019 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | PO ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NUM ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NULL ->
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NEW ->
          let _menhir_stack = MenhirCell1_NEW (_menhir_stack, _menhir_s) in
          let _menhir_s = MenhirState043 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | RAT ->
              _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT ->
              _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | MULT ->
          _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ENTIER _v ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DENOM ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | CO ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AND ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_020 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_NUM (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState020 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | PO ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NUM ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NULL ->
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ENTIER _v ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DENOM ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | CO ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AND ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_021 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_19 () in
      _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_022 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | PO ->
          let _menhir_stack = MenhirCell1_ID (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState023 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | PO ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NUM ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NULL ->
              _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ID _v ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ENTIER _v ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DENOM ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CO ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AND ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | PF ->
              let _v = _menhir_action_33 () in
              _menhir_goto_loption_separated_nonempty_list_VIRG_e__ _menhir_stack _menhir_lexbuf _menhir_lexer _v
          | _ ->
              _eRR ())
      | AO | CF | EQUAL | INF | MULT | PF | PLUS | PV | SLASH | VIRG ->
          let a = _v in
          let _v = _menhir_action_01 a in
          _menhir_goto_a _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_024 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_07 () in
      _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_025 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let e = _v in
      let _v = _menhir_action_08 e in
      _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_026 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_DENOM (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState026 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | PO ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NUM ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NULL ->
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ENTIER _v ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DENOM ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | CO ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AND ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_027 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_CO (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState027 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | PO ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NUM ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NULL ->
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ENTIER _v ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DENOM ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | CO ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AND ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_028 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | ID _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_18 n in
          _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_loption_separated_nonempty_list_VIRG_e__ : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_ID -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_ID (_menhir_stack, _menhir_s, n) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_04 n xs in
      _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_a : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState045 ->
          _menhir_run_048 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState093 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState089 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState078 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState072 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState069 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState066 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState017 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState019 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState061 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState058 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState055 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState051 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState020 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState023 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState040 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState026 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState027 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState031 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_048 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_MULT -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | PF ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_MULT (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_PO (_menhir_stack, _menhir_s) = _menhir_stack in
          let aff = _v in
          let _v = _menhir_action_02 aff in
          _menhir_goto_a _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_034 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let aff = _v in
      let _v = _menhir_action_17 aff in
      _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_002 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_45 () in
      _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_003 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_44 () in
      _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_045 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_PO as 'stack) -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MULT (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | PO ->
          let _menhir_stack = MenhirCell1_PO (_menhir_stack, MenhirState045) in
          let _menhir_s = MenhirState046 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | MULT ->
              _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | ID _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v =
            let a = _v in
            _menhir_action_01 a
          in
          _menhir_run_048 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_066 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_RETURN (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState066 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | PO ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NUM ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NULL ->
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ENTIER _v ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DENOM ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | CO ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AND ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_069 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_PRINT (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState069 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | PO ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NUM ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NULL ->
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ENTIER _v ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DENOM ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | CO ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AND ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_072 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_IF (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState072 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRUE ->
          _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | PO ->
          _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NUM ->
          _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NULL ->
          _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | FALSE ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ENTIER _v ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | DENOM ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | CO ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | AND ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_077 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_ID (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | EQUAL ->
          let _menhir_s = MenhirState078 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | PO ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NUM ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NULL ->
              _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ID _v ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ENTIER _v ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DENOM ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CO ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AND ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_081 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | ID _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | EQUAL ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | ENTIER _v_0 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | PV ->
                      let _tok = _menhir_lexer _menhir_lexbuf in
                      let (n, e) = (_v, _v_0) in
                      let _v = _menhir_action_23 e n in
                      _menhir_goto_i _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_099 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_i -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_i (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_32 x xs in
      _menhir_goto_list_i_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_list_i_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState098 ->
          _menhir_run_099 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState016 ->
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_096 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_AO -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_AO (_menhir_stack, _menhir_s) = _menhir_stack in
      let li = _v in
      let _v = _menhir_action_03 li in
      _menhir_goto_bloc _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_bloc : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState105 ->
          _menhir_run_106 _menhir_stack _v _tok
      | MenhirState015 ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState075 ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState073 ->
          _menhir_run_074 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState064 ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_100 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_typ _menhir_cell0_ID, _menhir_box_main) _menhir_cell1_loption_separated_nonempty_list_VIRG_param__ -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_loption_separated_nonempty_list_VIRG_param__ (_menhir_stack, _, xs) = _menhir_stack in
      let MenhirCell0_ID (_menhir_stack, n) = _menhir_stack in
      let MenhirCell1_typ (_menhir_stack, _menhir_s, t) = _menhir_stack in
      let li = _v in
      let _v = _menhir_action_20 li n t xs in
      let _menhir_stack = MenhirCell1_fonc (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | RAT ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | INT ->
          _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | BOOL ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | ID _ ->
          let _v_0 = _menhir_action_29 () in
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_108 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_fonc -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_fonc (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_30 x xs in
      _menhir_goto_list_fonc_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_list_fonc_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState107 ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState000 ->
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_104 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_list_fonc_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | ID _v_0 ->
          let _menhir_stack = MenhirCell0_ID (_menhir_stack, _v_0) in
          let _menhir_s = MenhirState105 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | AO ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_016 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_AO (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState016
      | RETURN ->
          _menhir_run_066 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState016
      | RAT ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState016
      | PRINT ->
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState016
      | INT ->
          _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState016
      | IF ->
          _menhir_run_072 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState016
      | ID _v ->
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState016
      | CONST ->
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState016
      | BOOL ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState016
      | AF ->
          let _v = _menhir_action_31 () in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _eRR ()
  
  and _menhir_run_076 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_IF, _menhir_box_main) _menhir_cell1_e, _menhir_box_main) _menhir_cell1_bloc -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_bloc (_menhir_stack, _, li1) = _menhir_stack in
      let MenhirCell1_e (_menhir_stack, _, exp) = _menhir_stack in
      let MenhirCell1_IF (_menhir_stack, _menhir_s) = _menhir_stack in
      let li2 = _v in
      let _v = _menhir_action_25 exp li1 li2 in
      _menhir_goto_i _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_074 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_IF, _menhir_box_main) _menhir_cell1_e as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_bloc (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | ELSE ->
          let _menhir_s = MenhirState075 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | AO ->
              _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_065 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_WHILE, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_e (_menhir_stack, _, exp) = _menhir_stack in
      let MenhirCell1_WHILE (_menhir_stack, _menhir_s) = _menhir_stack in
      let li = _v in
      let _v = _menhir_action_26 exp li in
      _menhir_goto_i _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_090 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_typ _menhir_cell0_ID -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | PV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_ID (_menhir_stack, n) = _menhir_stack in
          let MenhirCell1_typ (_menhir_stack, _menhir_s, t) = _menhir_stack in
          let e1 = _v in
          let _v = _menhir_action_28 e1 n t in
          _menhir_goto_i _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_079 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_ID -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | PV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_ID (_menhir_stack, _menhir_s, n) = _menhir_stack in
          let e1 = _v in
          let _v = _menhir_action_22 e1 n in
          _menhir_goto_i _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_073 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_IF as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_e (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | AO ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState073
      | _ ->
          _eRR ()
  
  and _menhir_run_070 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_PRINT -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | PV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_PRINT (_menhir_stack, _menhir_s) = _menhir_stack in
          let e1 = _v in
          let _v = _menhir_action_24 e1 in
          _menhir_goto_i _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_067 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_RETURN -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | PV ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_RETURN (_menhir_stack, _menhir_s) = _menhir_stack in
          let exp = _v in
          let _v = _menhir_action_27 exp in
          _menhir_goto_i _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_064 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_WHILE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_e (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | AO ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState064
      | _ ->
          _eRR ()
  
  and _menhir_run_062 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | PF ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_e (_menhir_stack, _, e1) = _menhir_stack in
          let MenhirCell1_PO (_menhir_stack, _menhir_s) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_13 e1 e2 in
          _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_059 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | PF ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_e (_menhir_stack, _, e1) = _menhir_stack in
          let MenhirCell1_PO (_menhir_stack, _menhir_s) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_14 e1 e2 in
          _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_056 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | PF ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_e (_menhir_stack, _, e1) = _menhir_stack in
          let MenhirCell1_PO (_menhir_stack, _menhir_s) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_12 e1 e2 in
          _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_052 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | PF ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_e (_menhir_stack, _, e1) = _menhir_stack in
          let MenhirCell1_PO (_menhir_stack, _menhir_s) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_11 e1 e2 in
          _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_050 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_PO as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | PLUS ->
          let _menhir_stack = MenhirCell1_e (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState051 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | PO ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NUM ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NULL ->
              _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ID _v ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ENTIER _v ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DENOM ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CO ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AND ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | PF ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_PO (_menhir_stack, _menhir_s) = _menhir_stack in
          let exp = _v in
          let _v = _menhir_action_15 exp in
          _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MULT ->
          let _menhir_stack = MenhirCell1_e (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState055 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | PO ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NUM ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NULL ->
              _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ID _v ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ENTIER _v ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DENOM ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CO ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AND ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | INF ->
          let _menhir_stack = MenhirCell1_e (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState058 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | PO ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NUM ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NULL ->
              _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ID _v ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ENTIER _v ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DENOM ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CO ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AND ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | EQUAL ->
          let _menhir_stack = MenhirCell1_e (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState061 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | PO ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NUM ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NULL ->
              _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ID _v ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ENTIER _v ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DENOM ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CO ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AND ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_042 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_NUM -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_NUM (_menhir_stack, _menhir_s) = _menhir_stack in
      let e1 = _v in
      let _v = _menhir_action_09 e1 in
      _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_039 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | VIRG ->
          let _menhir_stack = MenhirCell1_e (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState040 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | PO ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NUM ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NULL ->
              _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ID _v ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ENTIER _v ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DENOM ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CO ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AND ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | PF ->
          let x = _v in
          let _v = _menhir_action_40 x in
          _menhir_goto_separated_nonempty_list_VIRG_e_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_VIRG_e_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState040 ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState023 ->
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_041 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_e (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_41 x xs in
      _menhir_goto_separated_nonempty_list_VIRG_e_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_036 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_ID -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let x = _v in
      let _v = _menhir_action_34 x in
      _menhir_goto_loption_separated_nonempty_list_VIRG_e__ _menhir_stack _menhir_lexbuf _menhir_lexer _v
  
  and _menhir_run_035 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_DENOM -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_DENOM (_menhir_stack, _menhir_s) = _menhir_stack in
      let e1 = _v in
      let _v = _menhir_action_10 e1 in
      _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_032 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_CO, _menhir_box_main) _menhir_cell1_e -> _ -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | CF ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_e (_menhir_stack, _, e1) = _menhir_stack in
          let MenhirCell1_CO (_menhir_stack, _menhir_s) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_05 e1 e2 in
          _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_030 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_CO as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_e (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | SLASH ->
          let _menhir_s = MenhirState031 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRUE ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | PO ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NUM ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NULL ->
              _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ID _v ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | FALSE ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ENTIER _v ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | DENOM ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | CO ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | AND ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_044 : type  ttv_stack. (((ttv_stack, _menhir_box_main) _menhir_cell1_PO, _menhir_box_main) _menhir_cell1_NEW as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | MULT ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AO | CF | EQUAL | INF | PF | PLUS | PV | SLASH | VIRG ->
          let MenhirCell1_NEW (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_PO (_menhir_stack, _menhir_s) = _menhir_stack in
          let t = _v in
          let _v = _menhir_action_16 t in
          _menhir_goto_e _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_005 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_typ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_typ (_menhir_stack, _menhir_s, t) = _menhir_stack in
      let _v = _menhir_action_47 t in
      _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_008 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | MULT ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ID _v_0 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let (t, n) = (_v, _v_0) in
          let _v = _menhir_action_38 n t in
          (match (_tok : MenhirBasics.token) with
          | VIRG ->
              let _menhir_stack = MenhirCell1_param (_menhir_stack, _menhir_s, _v) in
              let _menhir_s = MenhirState012 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | RAT ->
                  _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | INT ->
                  _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | BOOL ->
                  _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | PF ->
              let x = _v in
              let _v = _menhir_action_42 x in
              _menhir_goto_separated_nonempty_list_VIRG_param_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_VIRG_param_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState012 ->
          _menhir_run_013 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState007 ->
          _menhir_run_010 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_013 : type  ttv_stack. (ttv_stack, _menhir_box_main) _menhir_cell1_param -> _ -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_param (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_43 x xs in
      _menhir_goto_separated_nonempty_list_VIRG_param_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_010 : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_typ _menhir_cell0_ID as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let x = _v in
      let _v = _menhir_action_36 x in
      _menhir_goto_loption_separated_nonempty_list_VIRG_param__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_loption_separated_nonempty_list_VIRG_param__ : type  ttv_stack. ((ttv_stack, _menhir_box_main) _menhir_cell1_typ _menhir_cell0_ID as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_main) _menhir_state -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_loption_separated_nonempty_list_VIRG_param__ (_menhir_stack, _menhir_s, _v) in
      let _menhir_s = MenhirState015 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | AO ->
          _menhir_run_016 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_004 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_main) _menhir_state -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | MULT ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ID _v_0 ->
          let _menhir_stack = MenhirCell0_ID (_menhir_stack, _v_0) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | PO ->
              let _menhir_s = MenhirState007 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | RAT ->
                  _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | INT ->
                  _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | BOOL ->
                  _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | PF ->
                  let _v = _menhir_action_35 () in
                  _menhir_goto_loption_separated_nonempty_list_VIRG_param__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  let _menhir_run_000 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_main =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | RAT ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | INT ->
          _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | BOOL ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | ID _ ->
          let _v = _menhir_action_29 () in
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState000 _tok
      | _ ->
          _eRR ()
  
end

let main =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_main v = _menhir_run_000 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
