(* Module de la passe de gestion des types *)
(* doit être conforme à l'interface Passe *)
open Tds
open Exceptions
open Ast
open Type

type t1 = Ast.AstTds.programme
type t2 = Ast.AstType.programme  

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
    (*on analyse l'expression*)
    let(ne, te) = analyse_type_expression exp in
    begin
      (*verification du type*)
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
    (*analyse du type de toutes les expression de la fonction*)
    let l = List.map analyse_type_expression le in
    let mle = List.map fst l in
    let lt = List.map snd l in
    (*verification de la compatibilité des types des paramètres de la fonction*)
    if est_compatible_list tp lt then
      (AstType.AppelFonction(infoast, mle), tr) 
    else 
      raise(TypesParametresInattendus (tp, lt))  

  |AstTds.NewTab (t,e) ->
    let (ne, te) = analyse_type_expression e in
    (*on verifie que le type de te est bien un int car il corresponds a la longueur du tableau*)
    if est_compatible te Int then
      AstType.NewTab(t, ne), Tab(t)
    else raise(TypeInattendu (te, Int))

  |AstTds.New t -> 
    (* Verification de l'utilisation du bon type dans l'expression *)
    (* Obtention de l'expression transformée *)
    (AstType.New t , Pointeur t)

  |AstTds.Addr info_ast -> 
    (* Verification de l'utilisation du bon type dans l'expression *)
    (* Obtention de l'expression transformée *)
    (AstType.Addr(info_ast), Pointeur(getType info_ast))

  |AstTds.Null -> 
    (* Verification de l'utilisation du bon type dans l'expression *)
    (* Obtention de l'expression transformée *)
    (AstType.Null, Pointeur(Undefined))

  |AstTds.Affectation a -> 
    (*on anayse le type de l'affectable*)
    let (na, ta) = analyse_type_affectable a in 
    (AstType.Affectation na, ta)
  
  |AstTds.InitTab le ->
    (*on analyse le type de toutes les expressions du tableau*)
    let l = List.map analyse_type_expression le in
    let mle = List.map fst l in
    let lt = List.map snd l in
    let t = List.hd lt in
    (*on verifie que tous les types sont compatibles dans le tableau mais comme on a pas acces a l'info c'est pas tres opti*)
    if est_compatible_list2 t lt then
      (AstType.InitTab(mle), Tab(t))
    else raise(TypesParametresInattendus (lt, [t]))
    
  |AstTds.Tab t ->
    (* Verification de l'utilisation du bon type dans l'expression *)
    (* Obtention de l'expression transformée *)
    AstType.Tab t, Tab(t)

  and analyse_type_affectable a =
    match a with
    |AstTds.Ident info -> 
      begin
      (*vérification du type d'un identifiant*)
      match info_ast_to_info info with
        |Tds.InfoVar(_,t,_,_) -> (AstType.Ident info,t)
        |Tds.InfoFun _ -> failwith ("pas id")
        |Tds.InfoConst _ -> (AstType.Ident info, Int)
        |Tds.InfoEtiquette _ -> failwith ("pas id")
      end
    |AstTds.Deref aff ->
      (*verification que l'on a bien un pointeur*)
      (match analyse_type_affectable aff with
      | (naff, Pointeur(t)) -> (AstType.Deref(naff),t)
      |_ -> failwith("err"))
    |AstTds.Access (aff, e) ->
      let (naff, t) = analyse_type_affectable aff in
      let (ne, te) = analyse_type_expression e in
      begin
      (*verification que l'on a bien un tableau et que l'expression est bien un tableau*)
        match (naff, t) with
        |naff, tcase -> 
          if est_compatible Int te then
            (AstType.Access(naff, ne), tcase) 
          else raise(TypeInattendu (t, te))
      end

(* analyse_type_instruction : AstTds.instruction -> AstType.instruction *)
(* Paramètre i : une instruction*)
(* Vérifie la bonne utilisation des types dans les instructions *)
(* Erreurs si on a des types inattendus *)
let rec analyse_type_instruction i = 
  match i with 
  |AstTds.Affichage e -> 
    begin
    let ne,te = analyse_type_expression e in
    (* Verification de l'utilisation du bon type dans l'expression *)
    (* Obtention de l'expression transformée *)
    match te with 
    |Int -> AstType.AffichageInt (ne)
    |Rat -> AstType.AffichageRat (ne)
    |Bool -> AstType.AffichageBool (ne)
    |Pointeur(_) -> AstType.AffichageInt(ne)
    |Tab(Int) -> AstType.AffichageInt(ne)
    |Tab(Rat) -> AstType.AffichageRat(ne)
    |Tab(Bool) -> AstType.AffichageBool(ne)
    |ti -> raise(TypeInattendu (ti, te))
    end

  |AstTds.Declaration (t, infoast, e) -> 
    let(ne, te) = analyse_type_expression e in 
    (*verification du type de l'expression par rapport au type attendu*)
    if est_compatible t te then
      let _ = modifier_type_variable te infoast in
      AstType.Declaration(infoast, ne) 
    else 
      raise(TypeInattendu (te, t))

  |AstTds.Conditionnelle (c, b1, b2) -> 
    let(nc, tc) = analyse_type_expression c in 
    (*on verifie que l'on a bien un booleen comme condition*)
    if est_compatible tc Bool then
      let nb1 = analyse_type_bloc b1 in
      let nb2 = analyse_type_bloc b2 in
      AstType.Conditionnelle (nc, nb1, nb2)
    else raise(TypeInattendu (tc, Bool))
   
  |TantQue (e, b)-> 
    let(ne, te) = analyse_type_expression e in
    (*on verifie que l'on a bien un booleen comme condition*)
    if est_compatible te Bool then
      let nb = analyse_type_bloc b in
      AstType.TantQue (ne,nb)
    else raise(TypeInattendu (te, Bool))
  
  |Retour (e, i) ->
    let(ne, te) = analyse_type_expression e in
    (*on verifie que le type de l'expression est bien compatible avec le type de retour de la fonction*)
    if est_compatible te (getType i) then
      AstType.Retour (ne,i)
    else 
      raise(TypeInattendu (te, getType i))

  |Empty -> AstType.Empty

  |AstTds.Affectation (aff, e) -> 
    let (na, ta) = analyse_type_affectable aff in
    let (ne, te)= analyse_type_expression e in 
    (*on verifie que le type de l'expression est bien compatible avec le type de l'affectable*)
    if (est_compatible te ta) then 
      AstType.Affectation (na, ne)
    else
      raise (TypeInattendu (te, ta))

  |AstTds.For (t,ia, ec1, ec2, ec3, b) ->
    if (est_compatible(Int) t) then
      let _ = modifier_type_variable t ia in
      let (nec1, ntc1) = analyse_type_expression ec1 in
      let (nec2, ntc2) = analyse_type_expression ec2 in
      let (nec3, ntc3) = analyse_type_expression ec3 in
      (*on verifie  que le variant de boucle est un int, que la confition d'arret est bien un booléen ainsi que le type de l'incrémentation de la boicle*)
      if (est_compatible ntc1 Int) && (est_compatible ntc2 Bool) && (est_compatible ntc3 Int) then
        let nb = analyse_type_bloc b in
        AstType.For (ia, nec1, nec2, nec3, nb)
      else
        raise (TypeInattendu (ntc1, Int))
    else
      raise (TypeInattendu (t, Int))
  |AstTds.Goto i -> 
    AstType.Goto i
  |AstTds.Label i -> 
    AstType.Label i
  

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