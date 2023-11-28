(* Module de la passe de gestion des types *)
(* doit être conforme à l'interface Passe *)
open Tds
open Exceptions
open Ast
open Type

type t1 = Ast.AstTds.programme
type t2 = Ast.AstType.programme


let rec analyser_type_expression e = 
match e with 
  |AstTds.Binaire (b,e1,e2) -> 
    begin
    let(ne1, t1) = analyser_type_expression e1 in
    let(ne2, t2) = analyser_type_expression e2 in
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
  | _ -> failwith "todo"

  (*
  |AstTds.AppelFonction info le ->
    let tr = getRetour info in 
    let tp = getTypeParam info inraise
    let l = List.map analyse_type_expression le in
    let mle = List.map fst l in
    let lt = List.map snd l in
    if 
      EstCompatible tp lt then
        (AstType.AppelFonction(nle, info), tr) 
    else raise TypeInattendu

  |AstTds.Booleen (b) ->
      AstType.Booleen(b)

  |AstTds.Unaire (u, n) ->
    let n1 = analyse_type_expression n in
    AstType.Unaire(u, n1)
      
  |AstTds.Entier(i) -> 
    AstType.Entier(i)

  |AstTds.Ident (s) ->
    match chercherGlobalement tds s with
    |Some info ->(
        match info_ast_to_info info with
        |InfoVar _ -> 
          AstTds.Ident(info)
        |InfoFun _ -> raise (MauvaiseUtilisationIdentifiant s)
        |InfoConst (_,e) -> AstTds.Entier(e))
    |None ->-
      raise(IdentifiantNonDeclare s)

let analyse_type_instruction i = 
  match i with 
  |Affichage e -> let ne,te = analyserTypeExpression e in
    match te with 
    |Int -> AstType.AffichageInt (ne)
    |Rat -> AstType.AffichageRat (ne)
    |Bool -> AstType.AffichageBool (ne)
    |_ -> raise(TypesParametresInattendus)
  |Declaration t info e -> 
    let(ne, te) = analyse_type_expression e in 
    if EstCompatible te t then 
      majInfo t info 
      AstType.Declaration info ne 
    else 
      raise(TypesParametresInattendus)

  |Affectation info e -> 
    let (ne, te)= analyse_type_expression e in 
    if EstCompatible getInfo info te then
      AstType.Affectation (info, ne)
    else raise(TypesParametresInattendus)

  |Conditionnelle c b1 b2 -> 
    let(nc, tc) = analyse_type_expression c in 
    if est_compatible tc Bool then
      let nb1 = analyser_type_bloc b1 in
      let nb2 = analyser_type_bloc b2 in
      AstType.Conditionnelle ne nb1 nb2
    else raise(TypesParametresInattendus)
    
    |Empty -> AstType.Empty


    *)

let analyser = fun _ -> failwith "to do"



