(* Module de la passe de placement *)
(* doit être conforme à l'interface Passe *)
open Tds
open Ast
open Type
open AstPlacement

type t1 = Ast.AstType.programme
type t2 = Ast.AstPlacement.programme

(* get_Taille : instruction -> Int *)
(* Paramètre i : une instruction *)
(* Renvoi la taille d'une instruction *)
(* Renvoi 0 si ce n'est pas un déclaration *)
let get_Taille i = 
  match i with
 |Declaration (info, _) -> getTaille (getType info)
 | _ -> 0   


(* analyse_placement_instruction : instruction -> Int -> String -> Instruction*Int *)
(* Paramètre i : une instruction *)
(* Paramètre depl : un integer symbolisant le déplacement *)
(* Paramètre reg : le registre a utiliser *)
(* Renvoi une instruction ainsi que la taille qu'elle prend*)
let rec analyse_placement_instruction i depl reg =
  match i with
  |AstType.Declaration (info_ast, e) ->
    begin
    match info_ast_to_info info_ast with
    |InfoVar(_,t,_,_) ->
      (*on place la variable en lui réserant sa place*)
      modifier_adresse_variable depl reg info_ast;
      AstPlacement.Declaration(info_ast, e), getTaille t
    | _ -> failwith("todo : pas une infoVar")
    end
  |AstType.Conditionnelle (c,b1,b2) -> 
    let nb1 = analyse_placement_bloc b1 depl reg in
    let nb2 = analyse_placement_bloc b2 depl reg in
    (*les conditionnelles ne demandent pas de place car elles ne sont pas stockées*)
    (AstPlacement.Conditionnelle (c, nb1, nb2),0)
  |AstType.TantQue (e,b) ->
    let il = analyse_placement_bloc b depl reg in
    (*rien a placer*)
    AstPlacement.TantQue (e,il),0
  |AstType.Retour (e, info_ast) -> 
    begin
    match info_ast_to_info info_ast with
    |InfoFun (_, tr, tp) ->
      let tailleTr = getTaille tr in
      let tailleTp = List.fold_left (fun acc t -> acc + getTaille t) 0 tp in
      AstPlacement.Retour (e, tailleTr, tailleTp),0
    | _  -> failwith ("pas une info fun")
    end
  |AstType.Affectation (a, e) -> 
    (*rien a placer*)
    (AstPlacement.Affectation(analyse_placement_affectable a, e), 0)
  |AstType.AffichageBool  e -> 
    (*rien a placer*)
    (AstPlacement.AffichageBool e, 0)
  |AstType.AffichageInt e -> 
    (*rien a placer*)
    (AstPlacement.AffichageInt e, 0)
  |AstType.AffichageRat e -> 
    (*rien a placer*)
    (AstPlacement.AffichageRat e, 0)
  |AstType.Empty ->
    (*rien a placer*)
    (AstPlacement.Empty, 0)
  |AstType.For (ia, e1, e2, e3, b) ->
    (*Todo : rendre ca mieux*)
      begin
        match info_ast_to_info ia with
        |InfoVar(_,_,_,_) ->
          modifier_adresse_variable depl reg ia;
          let li = analyse_placement_bloc b depl reg in
          (*on reserve la place du variant de boucle*)
          (AstPlacement.For (ia, e1, e2, e3, li), 1)
        | _ -> failwith("todo : pas une infoVar")
      end
  |AstType.Goto e -> 
    (*rien a placer*)
    (AstPlacement.Goto e, 0)
  |AstType.Label e -> 
    (AstPlacement.Label e, 1)

    and analyse_placement_affectable a =
      match a with
        |AstType.Ident info -> AstPlacement.Ident(info)
        |AstType.Deref aff -> analyse_placement_affectable aff
        |AstType.Access (aff, e) -> AstPlacement.Access(analyse_placement_affectable aff, e)

(* analyse_placement_bloc : instruction list -> Int -> String -> bloc *)
(* Paramètre li : une liste d'instructions *)
(* Paramètre depl : un integer symbolisant le déplacement *)
(* Paramètre reg : le registre a utiliser *)
(* Renvoi un bloc*)
and analyse_placement_bloc li depl reg = 
  match li with
  |t::q -> 
    let (nt,tailleT) = analyse_placement_instruction t depl reg in
    let (nq,tailleQ) = analyse_placement_bloc q (depl+tailleT) reg in
    nt::nq,tailleT+tailleQ
  |[] -> [],0

(* analyse_placement_parametres : Int -> Info_ast list -> Info_ast list *)
(* Paramètre depl : un integer symbolisant le déplacement *)
(* Paramètre li : une liste d'instructions *)
(* Renvoi le placement des paramètres d'une liste d'info_ast*)
let rec analyse_placement_parametres depl li =
  match li with
  | info_ast::q -> 
    let t = getTaille( getType info_ast) in
    modifier_adresse_variable (depl-t) "LB" info_ast;
    info_ast::(analyse_placement_parametres (depl-t) q)
  |[] -> [] 

(* analyse_placement_fonction : Fonction ->  Fonction *)
(* Paramètre f : une fonction *)
(* Renvoi le placement d'une fonction*)
let analyse_placement_fonction (AstType.Fonction(info_ast, infol, instl)) =
  let nb = analyse_placement_bloc instl 3 "LB" in
  let nlp = analyse_placement_parametres 0 (List.rev infol) in
  AstPlacement.Fonction (info_ast, nlp, nb)

(* analyser : Ast.AstType.programme -> Ast.AstPlacement.programme *)
(* Paramètre lf : la liste des fonction du programme *)
(* Paramètre li : b le bloc principal du programme *)
(* Renvoi le placement des différents instruction du programme pour du code TAM*)
let analyser  (AstType.Programme (lf, b)) =
  let mlf = List.map analyse_placement_fonction lf in 
  let mb  = analyse_placement_bloc b 0 "SB" in
  AstPlacement.Programme (mlf,mb)