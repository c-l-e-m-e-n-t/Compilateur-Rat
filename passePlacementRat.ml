(* Module de la passe de placement *)
(* doit être conforme à l'interface Passe *)

open Tds
open Exceptions
open Ast
open Type
open AstPlacement

type t1 = Ast.AstType.programme
type t2 = Ast.AstPlacement.programme


let get_Taille t = 
  match t with
 |Declaration (info, e) -> getTaille (getType info)
 | _ -> 0   

let rec analyse_placement_instruction i depl reg =
  match i with
  |AstType.Declaration (info_ast, e) ->
    begin
    match info_ast_to_info info_ast with
    |InfoVar(_,t,_,_) ->
      modifier_adresse_variable depl reg info_ast;
      AstPlacement.Declaration(info_ast, e), getTaille t
    | _ -> failwith("todo : pas une infoVar")
    end
  |AstType.Conditionnelle (c,b1,b2) -> 
    let nb1 = analyse_placement_bloc b1 depl reg in
    let nb2 = analyse_placement_bloc b2 depl reg in
    (AstPlacement.Conditionnelle (c, nb1, nb2),0)
  |AstType.TantQue (e,b) ->
    let il = analyse_placement_bloc b depl reg in
    AstPlacement.TantQue (e,il),0
    (*
  |AstType.Retour (e, info_ast) -> 
    begin
    match info_ast_to_info info_ast with
    |InfoFun (_, tr, tp) ->
      let tailleTr = getTaille tr in
      let tailleTp = List.fold_right + tp in
      AstPlacement.Retour (e, tailleTr, tailleTp),0
    | _  -> failwith ("pas une info fun")
    end*)
  | _ -> failwith("pas encore fait") 

and analyse_placement_bloc li depl reg = 
  match li with
  |t::q -> 
    let (nt,tailleT) = analyse_placement_instruction t depl reg in
    let (nq,tailleQ) = analyse_placement_bloc q (depl+tailleT) reg in
    nt::nq,tailleT+tailleQ
  |[] -> [],0

let rec analyse_placement_parametres depl li =
  match li with
  | info_ast::q -> 
    let t = getTaille( getType info_ast) in
    modifier_adresse_variable (depl-t) "LB" info_ast;
    info_ast::(analyse_placement_parametres (depl-t) q)
  | _ -> failwith("aa") 

let analyse_placement_fonction (AstType.Fonction(info_ast, infol, instl)) =
  let nb = analyse_placement_bloc instl 3 "LB" in
  let nlp = analyse_placement_parametres 0 (List.rev infol) in
  AstPlacement.Fonction (info_ast, nlp, nb)


let analyser  (AstType.Programme (lf, b)) =
  let mlf = List.map analyse_placement_fonction lf in 
  let mb  = analyse_placement_bloc b 0 "SB" in
  AstPlacement.Programme (mlf,mb)