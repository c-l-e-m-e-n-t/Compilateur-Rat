(* Module de la passe de gestion des types *)
(* doit être conforme à l'interface Passe *)
open Tds
open Exceptions
open Ast
open Type

type t1 = Ast.AstTds.programme
type t2 = Ast.AstType.programme  

let rec analyse_type_affectable a =
  match a with
  |AstTds.Ident info -> getType info, AstType.Ident(info)
  |AstTds.Deref aff ->
    let naff = analyse_type_affectable aff in
    begin 
      match (snd naff) with
      |Addr t -> AstType.Deref((fst naff),t)
      | t -> failwith ("raté !")
    end



(* analyse_type_expression : AstTds.expression -> AstType.expression*typ *)
(* Paramètre e : une expression*)
(* Vérifie la bonne utilisation des types dans les expressions *)
(* Erreurs si types binaires inattendus, types inattendus ou types paramètres inattendus *)
let rec analyse_type_expression e = 
match e with 
  |AstTds.Binaire (b,e1,e2) -> 
    begin
    (* On analyse les expressions 1 et 2*)
    let(ne1, t1) = analyse_type_expression e1 in
    let(ne2, t2) = analyse_type_expression e2 in
    (* On regarde si le binaire et les expressions on bien des types qui correspondent et qui sont autorisées dans notre language*)
    match t1,b,t2 with 
    |Int, Plus, Int -> ((AstType.Binaire (PlusInt,ne1, ne2)), Int) 
    |Int, Equ, Int -> ((AstType.Binaire (EquInt,ne1, ne2)), Bool) 
    |Bool, Equ, Bool -> ((AstType.Binaire (EquBool,ne1, ne2)), Bool) 
    |Int, Mult, Int -> ((AstType.Binaire (MultInt,ne1, ne2)), Int) 
    |Rat, Mult, Rat -> ((AstType.Binaire (MultRat,ne1, ne2)), Rat) 
    |Rat, Plus, Rat -> ((AstType.Binaire (PlusRat,ne1, ne2)), Rat) 
    |Int, Fraction, Int -> ((AstType.Binaire (Fraction,ne1, ne2)), Rat) 
    |Int, Inf, Int -> ((AstType.Binaire (Inf,ne1, ne2)), Bool) 
    |_ -> raise (TypeBinaireInattendu (b, t1, t2))
    end

  |AstTds.Booleen (b) ->
    (* Verification de l'utilisation du bon type dans l'expression *)
    (* Obtention de l'expression transformée *)
    (AstType.Booleen(b), Bool)
  
  |AstTds.Entier (ent) ->
    (* Verification de l'utilisation du bon type dans l'expression *)
    (* Obtention de l'expression transformée *)
    (AstType.Entier ent, Int)

  |AstTds.Unaire (un, exp) ->  
    let(ne, te) = analyse_type_expression exp in
    begin
      match te with
      |Rat -> 
        begin
          match un with
          |Numerateur -> (AstType.Unaire (Numerateur, ne), Int) 
          |Denominateur -> (AstType.Unaire (Denominateur, ne), Int)
        end
      | _ -> raise(TypeInattendu (te, Rat))
    end
  
  |AstTds.AppelFonction (infoast, le) ->
    let tr = getType infoast in 
    let tp = getTypeParam infoast in
    let l = List.map analyse_type_expression le in
    let mle = List.map fst l in
    let lt = List.map snd l in
    if est_compatible_list tp lt then
      (AstType.AppelFonction(infoast, mle), tr) 
    else 
      raise(TypesParametresInattendus (tp, lt))  

  |AstTds.New t -> (AstType.New t , Addr t)
  |AstTds.Addr info_ast -> (AstType.Addr(info_ast),Addr(getType info_ast))
  |AstTds.Null -> (AstType.Null, Addr(Undefined))
  |AstTds.Affectation a -> let (ta,na) = analyse_type_affectable a in 
                          (AstType.Affectable na, ta)
  |AstTds.Affectable _ -> failwith("") (*todo suppr cette merde*)


(* analyse_type_instruction : AstTds.instruction -> AstType.instruction *)
(* Paramètre i : une instruction*)
(* Vérifie la bonne utilisation des types dans les instructions *)
(* Erreurs si on a des types inattendus *)
let rec analyse_type_instruction i = 
  match i with 
  |AstTds.Affichage e -> 
    begin
    let ne,te = analyse_type_expression e in
    match te with 
    |Int -> AstType.AffichageInt (ne)
    |Rat -> AstType.AffichageRat (ne)
    |Bool -> AstType.AffichageBool (ne)
    |Addr(_) -> AstType.AffichageInt(ne)
    |ti -> raise(TypeInattendu (ti, te))
    end

  |AstTds.Declaration (t, infoast, e) -> 
    let(ne, te) = analyse_type_expression e in 
    if est_compatible t te then
      let _ = modifier_type_variable te infoast in
      AstType.Declaration(infoast, ne) 
    else 
      raise(TypeInattendu (te, t))

  |AstTds.Conditionnelle (c, b1, b2) -> 
    let(nc, tc) = analyse_type_expression c in 
    if est_compatible tc Bool then
      let nb1 = analyse_type_bloc b1 in
      let nb2 = analyse_type_bloc b2 in
      AstType.Conditionnelle (nc, nb1, nb2)
    else raise(TypeInattendu (tc, Bool))
   
  |TantQue (e, b)-> 
    let(ne, te) = analyse_type_expression e in
    if est_compatible te Bool then
      let nb = analyse_type_bloc b in
      AstType.TantQue (ne,nb)
    else raise(TypeInattendu (te, Bool))
  
  |Retour (e, i) ->
    let(ne, te) = analyse_type_expression e in
    if est_compatible te (getType i) then
      AstType.Retour (ne,i)
    else 
      raise(TypeInattendu (te, getType i))

  |Empty -> AstType.Empty

  |AstTds.Affectation (aff, e) -> 
    let (ta, na) = analyse_type_affectable aff in
    let (ne, te)= analyse_type_expression e in 
    if (est_compatible te ta) then 
      AstType.Affectation (na, ne)
    else
      raise (TypeInattendu (te, ta))

(* analyse_type_bloc : AstTds.bloc -> AstType.bloc *)
(* Paramètre li : une instruction list*)
(* Vérifie la bonne utilisation des types dans les blocs en analysant toutes les instructions du bloc*)
and analyse_type_bloc li =
  List.map analyse_type_instruction li 


(* sub_modifier_type_variable : typ*Info_ast -> unit *)
(* Paramètre t : un type*)
(* Paramètre info : une info ast *)
(* Sous-fonction permettant de modifier le type d'ine variable afin de faviliter l'utilisation d'un map *)
let sub_modifier_type_variable (t, info) = 
  modifier_type_variable t info

(* analyse_type_fonction : AstTds.fonction -> AstType.fonction *)
(* Paramètre * : une fonction*)
(* Vérifie la bonne utilisation des types dans une fonction*)
(* Fail si on a autre chose qu'une InfoFun (normalement impossible) *)
let analyse_type_fonction (AstTds.Fonction (t, infoast, lp, corps)) = 
    match info_ast_to_info infoast with
    |InfoFun _ -> 
      let _ = modifier_type_fonction t (List.map fst lp) infoast in 
      let _ = List.map sub_modifier_type_variable lp in
      let infol = List.map snd lp in
      let nb = analyse_type_bloc corps in
      AstType.Fonction (infoast, infol, nb)
    |_ -> failwith "Erreur interne"

(* analyser : AstTds.programme -> AstType.programme *)
(* Paramètre nf : une liste de fonctions *)
(* Paramètre nb : le bloc principal du programme *)
(* Vérifie la bonne utilisation des types dans un programme*)
let analyser (AstTds.Programme (fonctions,prog)) =
  let nf = List.map analyse_type_fonction fonctions in
  let nb = analyse_type_bloc prog in
  AstType.Programme (nf, nb)