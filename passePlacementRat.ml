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
    let nb1 = analyse_placement_bloc reg depl nb1 in
    let nb2 = analyse_placement_bloc reg depl nb2 in
    (AstPlacement.Conditionnelle (c, nb1, nb2),0)
  | _ -> failwith("pas encore fait") 

and analyse_placement_bloc reg depl li = 
  match li with
  |[] -> []
  |i::q -> 
    let (ni, ndep) = analyse_placement_instruction reg depl i in
      ni :: (analyse_placement_bloc reg ndep q)
  

let rec analyse_placement_parametres depl li =
  match li with
  | info_ast::q -> 
    let t = getTaille( getType info_ast) in
    modifier_adresse_variable (depl-t) "LB" info_ast;
    info_ast::(analyse_placement_parametres (depl-t) q)
  | _ -> failwith("aa") 

let analyse_placement_fonction (AstType.Fonction(info_ast, infol, instl)) =
  let nb = analyse_placement_bloc "LB" 3 instl in
  let nlp = analyse_placement_parametres 0 (List.rev infol) in
  AstPlacement.Fonction (info_ast, nb, nlp)


let analyser_Programme (lf, b) =
  let mlf = analyse_placement_fonction lf in 
  let mb  = analyse_placement_bloc b in
  AstPlacement.Programme (mlf,mb)
