(*(* Module de la passe de generation de code *)
(* doit être conforme à l'interface Passe *)
open Tds
open Ast
open Type
open Tam

type t1 = Ast.AstPlacement.programme
type t2 = string

(* analyser_code_expression : AstType.expression -> string *)
(*Paramètre e : expression *)
(* Renvoi le code TAM d'une expression *)
let rec analyser_code_expression e =
  begin
  match e with
  |AstType.Entier i -> Tam.loadl_int i
  |AstType.Booleen b -> 
    if b then
      loadl_int 1
    else 
      loadl_int 0
  |AstType.Ident info -> 
    begin
      match info_ast_to_info info with 
      |InfoConst ( _, v) -> Tam.loadl_int v
      |InfoVar (_, t, depl, reg) -> Tam.load (getTaille t) depl reg
      | _ -> failwith("info non supportée")
    end
  |AstType.Unaire (op, e1) -> 
    let a = analyser_code_expression e1 in
    begin
    match op with
      |Numerateur -> a ^ Tam.pop 0 1
      |Denominateur -> a ^ Tam.pop 1 1
      
    end
  
  |AstType.Binaire (b, e1, e2) -> 
    analyser_code_expression e1 ^ "\n" ^
    analyser_code_expression e2 ^ "\n" ^
    
    begin
      match b with
      |Fraction ->  ""
      |PlusInt ->  Tam.subr "IAdd"
      |MultInt -> Tam.subr "IMul" 
      |EquInt -> Tam.subr "IEq"
      |EquBool -> Tam.subr "IEq"
      |Inf  -> Tam.subr "ILss"
      |PlusRat -> 
        Tam.call "ST" "radd"
      
      |MultRat ->
        Tam.call "ST" "rmul" 
    end 
  |AstType.AppelFonction (info, el) -> 
    begin
    match info_ast_to_info info with 
    |InfoFun (n,_,_) -> 
      String.concat "" (List.map(analyser_code_expression) el) ^
      Tam.call "SB" n
    | _ -> failwith ("pas d'info fun")
    end
  | _ -> failwith ("todo")
  end

  
(* analyser_code_instruction : AstPlacement.instruction -> string *)
(*Paramètre i : instruction *)
(* Renvoi le code TAM d'une instruction *)
let rec analyser_code_instruction i = 
  match i with
  |AstPlacement.Declaration (info, e) -> 
    begin
    match info_ast_to_info info with
    |InfoVar (_,t,depl,reg) -> 
      begin
      let a = analyser_code_expression e in
        Tam.push (getTaille t) ^ a ^ Tam.store (getTaille t) depl reg
      end
    | _ -> failwith("aupfzbvzegv" )
    end
  |AstPlacement.Affectation (info, e) -> 
    begin
    match info_ast_to_info info with
    |InfoVar (_, t, depl, reg) ->
      Tam.push (getTaille t) ^
      (analyser_code_expression e) ^ Tam.store (getTaille t) depl reg

    | _ -> failwith ("greqôg")
    end
  |AstPlacement.TantQue (c, b) ->
    (*generer etiquette automatiquement*)
    let debut = Code.getEtiquette() in
    let fin = Code.getEtiquette() in
      debut^"\n" ^
      analyser_code_expression c ^
      Tam.jumpif 0 fin ^
      analyser_code_bloc b ^
      Tam.jump debut ^
      fin ^"\n"
  |AstPlacement.AffichageBool e ->
    (analyser_code_expression e) ^ Tam.subr "BOut"
  |AstPlacement.AffichageInt e ->
    (analyser_code_expression e) ^ Tam.subr "IOut"
  |AstPlacement.AffichageRat e ->
    (analyser_code_expression e) ^  Tam.call "ST" "rout"
  |AstPlacement.Conditionnelle (e, b1, b2) ->
    (*generer etiquette automatiquement
       analyser la conditionnelle
       si elle est vrai faire b1 sinon faire b2*)
    let sinon = Code.getEtiquette() in
    let fin = Code.getEtiquette() in
    analyser_code_expression e ^
    Tam.jumpif 0 sinon ^
    analyser_code_bloc b1 ^
    Tam.jump fin ^
    sinon ^ "\n" ^
    analyser_code_bloc b2 ^
    fin ^ "\n"
  |AstPlacement.Retour (e,i1,i2) ->
    analyser_code_expression e ^
    Tam.return i1 i2
  |AstPlacement.Empty ->
    ""
  
(* analyser_code_bloc : AstPlacement.bloc -> string *)
(* Paramètre b : bloc *)
(* Renvoi le code TAM d'un bloc *)
and analyser_code_bloc (li,tailleb) = 
  (String.concat "" (List.map analyser_code_instruction li)) ^ (Tam.pop(0) tailleb)

(* analyser_code_fonction : AstPlacement.fonction -> string *)
(* Paramètre f : fonction *)
(* Renvoi le code TAM d'une fonction *)
let analyser_code_fonction (AstPlacement.Fonction (info, _, li)) =
  match info_ast_to_info info with
  | InfoFun (n, _, _)->
    Tam.label n ^
    analyser_code_bloc li ^
    Tam.halt
  | _ -> failwith ("pas info fun")

(* analyser : Ast.AstPlacement.programme -> code TAM *)
(* Paramètre lf : la liste des fonction du programme *)
(* Paramètre li : b le bloc principal du programme *)
(* Renvoi le code TAM du programme *)
let analyser  (AstPlacement.Programme (lf , b)) =
  Code.getEntete() ^
  String.concat "" (List.map(analyser_code_fonction) lf) ^
  "main \n" ^
  analyser_code_bloc b ^
  Tam.halt*)