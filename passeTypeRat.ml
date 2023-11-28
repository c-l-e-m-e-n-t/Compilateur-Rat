(* Module de la passe de gestion des types *)
(* doit être conforme à l'interface Passe *)
open Tds
open Exceptions
open Ast
open Type

type t1 = Ast.AstTds.programme
type t2 = Ast.AstType.programme


let rec analyse_type_expression e = 
match e with 
  |AstTds.Binaire (b,e1,e2) -> 
    begin
    let(ne1, t1) = analyse_type_expression e1 in
    let(ne2, t2) = analyse_type_expression e2 in
    match t1,b,t2 with 
    |Int, Plus, Int -> ((AstType.Binaire (PlusInt,ne1, ne2)), Int) 
    |Int, Equ, Int -> ((AstType.Binaire (EquInt,ne1, ne2)), Int) 
    |Bool, Equ, Bool -> ((AstType.Binaire (EquBool,ne1, ne2)), Bool) 
    |Int, Mult, Int -> ((AstType.Binaire (MultInt,ne1, ne2)), Int) 
    |Rat, Mult, Rat -> ((AstType.Binaire (MultRat,ne1, ne2)), Rat) 
    |Rat, Plus, Rat -> ((AstType.Binaire (PlusRat,ne1, ne2)), Rat) 
    |Int, Fraction, Int -> ((AstType.Binaire (Fraction,ne1, ne2)), Int) 
    |Int, Inf, Int -> ((AstType.Binaire (MultRat,ne1, ne2)), Int) 
    |_ -> raise (TypeBinaireInattendu (b, t1, t2))
    end

  |AstTds.Booleen (b) ->
    (AstType.Booleen(b), Bool)
  
  |AstTds.Entier (ent) ->
    (AstType.Entier ent, Int)

  |AstTds.Ident (id) -> 
    (AstType.Ident id, getType id) 

    (*
  |AstTds.Unaire (un, exp) ->  
    let(ne, ty) = analyse_type_expression exp in
    begin
      match ty with
      |Rat -> (AstType.Unaire (un, ne), Int) 
      | _ -> raise(TypeInattendu (ty, Rat))
    end*)

  | _ -> failwith "todo : faire les fonctions"
  (*
  |AstTds.AppelFonction (info, le) ->
    
    let tr = getRetour info in 
    let tp = getTypeParam info in
    let l = List.map analyse_type_expression le in
    let mle = List.map fst l in
    let lt = List.map snd l in
    if 
      EstCompatible tp lt then
        (AstType.AppelFonction(nle, info), tr) 
    else raise(TypeInattendu lt)
  | _ -> failwith "todo"*)

let rec analyse_type_instruction i = 
  match i with 
  |AstTds.Affichage e -> 
    begin
    let ne,te = analyse_type_expression e in
    match te with 
    |Int -> AstType.AffichageInt (ne)
    |Rat -> AstType.AffichageRat (ne)
    |Bool -> AstType.AffichageBool (ne)
    |ti -> raise(TypeInattendu (ti, te))
    end

  |AstTds.Declaration (ty, info, e) -> 
    let(ne, te) = analyse_type_expression e in 
    if est_compatible ty te then
      AstType.Declaration(info, ne) 
    else 
      raise(TypeInattendu (te, ty))
  | _ -> failwith "todo"
  
  |AstTds.Affectation (info, e) -> 
    let (ne, te)= analyse_type_expression e in 
    let ti =getType info in
    if est_compatible ti te then
      AstType.Affectation (info, ne)
    else raise(TypeInattendu (te, ti))

  |AstTds.Conditionnelle (c, b1, b2) -> 
    let(nc, tc) = analyse_type_expression c in 
    if est_compatible tc Bool then
      let nb1 = analyse_type_bloc b1 in
      let nb2 = analyse_type_bloc b2 in
      AstType.Conditionnelle (nc, nb1, nb2)
    else raise(TypeInattendu (tc, Bool))
    
    |Empty -> AstType.Empty


and analyse_type_bloc li = 
  List.map analyse_type_instruction li 

let analyser programme =
  (*List.map analyse_type_fonction*)
  analyse_type_bloc programme

