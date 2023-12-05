(* Module de la passe de generation de code *)
(* doit être conforme à l'interface Passe *)
open Tds
open Ast
open Type
open AstPlacement
open Tam
open Code

type t1 = Ast.AstPlacement.programme
type t2 = string


let rec analyser_code_expression e =
  begin
  match e with
  |AstType.Entier i -> Tam.loadl_int i
  |AstType.Ident info -> 
    begin
      match info_ast_to_info info with 
      |InfoConst ( _, v) -> Tam.loadl_int v
      |InfoVar (n, t, depl, reg) -> Tam.load (getTaille t) depl reg
      | _ -> failwith("info non supportée")
    end
  |AstType.Unaire (op, e1) -> 
    let a = analyser_code_expression e1 in
    begin
    match op with
      |Numerateur -> a ^ Tam.pop 0 1
      |Denominateur -> a ^ Tam.pop 1 1
    end
  | _ -> failwith("autre truc qu'on doit faire")
  end

let rec analyser_code_instruction i = 
  match i with
  |AstPlacement.Declaration (info, e) -> 
    begin
    match info_ast_to_info info with
    |InfoVar (n,t,depl,reg) -> 
      begin
      let a = analyser_code_expression e in
        Tam.push (getTaille t) ^ a ^ Tam.store (getTaille t) depl reg
      end
    | _ -> failwith("aupfzbvzegv")
    end
  |AstPlacement.Affectation (info, e) -> 
    begin
    match info_ast_to_info info with
    |InfoVar (n, t, depl, reg) ->
      Tam.push (getTaille t) ^
      (analyser_code_expression e) ^ Tam.store (getTaille t) depl reg

    | _ -> failwith ("greqôg")
    end
  |AstPlacement.TantQue (c, b) ->
    (*generer etiquette automatiquement*)
    let debut = "etiq1" in
    let fin = "etiq2" in
      debut ^
      analyser_code_expression c ^
      Tam.jumpif 0 fin ^
      analyser_code_bloc b ^
      Tam.jump debut ^
      fin
  |AstPlacement.AffichageBool e ->
    Tam.subr "BOut"
  |AstPlacement.AffichageInt e ->
    Tam.subr "IOut"
  |AstPlacement.AffichageRat e ->
    Tam.subr "IOut" ^ "/" ^ Tam.subr "IOut"
  |AstPlacement.Conditionnelle (e, b1, b2) ->
    (*generer etiquette automatiquement
       analyser la conditionnelle
       si elle est vrai faire b1 sinon faire b2*)
    let debut = "etiq1" in
    let fin = "etiq2" in
      debut ^
      analyser_code_expression c ^
      Tam.jumpif 0 fin ^
      analyser_code_bloc b ^
      Tam.jump debut ^
      fin

  |AstPlacement.Retour (_,i1,i2) ->
    Tam.return i1 i2
    
  | _ -> failwith ("on a pas encore fait")
    
and analyser_code_bloc (li,tailleb) = 
  (String.concat "" (List.map analyser_code_instruction li)) ^ (Tam.pop(0) tailleb)

let analyser  (AstPlacement.Programme (lf, b)) =
  (*let mlf = List.map analyse_placement_fonction lf in *)
  analyser_code_bloc b