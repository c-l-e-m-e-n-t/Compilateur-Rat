(* Module de la passe de gestion des identifiants *)
(* doit être conforme à l'interface Passe *)
open Exceptions
open Tds
open Ast

type t1 = Ast.AstSyntax.programme
type t2 = Ast.AstTds.programme

(* récupere tous les labels liés aux goto pour éviter que le goto dise qu'un label est non déclaré lorsque ce n'est pas le cas*)
let rec collect_labels tds prog = 
  match prog with
  |[] -> []
  |(AstSyntax.Label (n))::q -> 
    begin 
    match chercherGlobalement tds n with
    |Some _ -> raise (DoubleDeclaration n)
    |None -> 
      let info = InfoEtiquette (n) in
      let ia = info_to_info_ast info in
      ajouter tds n ia;
      let labels = collect_labels tds q in
      ia::labels
    end
  |AstSyntax.For (_,_,_,_,_,_,b)::q -> 
    let labels = collect_labels tds b in
    let labels2 = collect_labels tds q in
    labels@labels2
  |AstSyntax.Conditionnelle (_,b1,b2)::q ->
    let labels = collect_labels tds (b1@b2@q) in
    labels
  |AstSyntax.TantQue (_,b)::q ->
    let labels = collect_labels tds b in
    let labels2 = collect_labels tds q in
    labels@labels2
  |_::q -> collect_labels tds q


(* analyse_tds_expression : tds -> AstSyntax.expression -> AstTds.expression *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre e : l'expression à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme l'expression
en une expression de type AstTds.expression *)
(* Erreur si mauvaise utilisation des identifiants *)
let rec analyse_tds_expression tds e = 
  match e with
  |AstSyntax.Booleen (b) ->
    begin
      AstTds.Booleen(b)
    end
  |AstSyntax.Entier(i) -> 
    begin
      AstTds.Entier(i)
    end
  |AstSyntax.AppelFonction(s, ne) ->
    begin
        (*rechercher dans la tds pour vérifier que l'identifiant est bien déclaré*)
        match chercherGlobalement tds s with
        |Some info ->(
          (*on traite l'info et on vérifie que cela corresponds bien a une fonction *)
          match info_ast_to_info info with
          |InfoFun _ -> 
            (*on analyse tous les éléments de la fonction*)
            let n1 = List.map (analyse_tds_expression tds) ne in
            AstTds.AppelFonction(info, n1)
          | _  -> raise (MauvaiseUtilisationIdentifiant s))
        |None ->
          raise(IdentifiantNonDeclare s)
    end
  |AstSyntax.Binaire (b, e1, e2) ->
    begin
      (*on analyse chaque coté du binaire*)
      let n1 = analyse_tds_expression tds e1 in
      let n2 = analyse_tds_expression tds e2 in
      AstTds.Binaire(b,n1, n2)
    end 
  |AstSyntax.Unaire (u, ne) ->
    begin
      (*on analyse l'expression*)
      let n1 = analyse_tds_expression tds ne in
      AstTds.Unaire(u, n1)
    end
  |AstSyntax.Affectation a ->
    AstTds.Affectation (analyse_tds_affectable a tds true)
  |AstSyntax.New t -> 
    AstTds.New t
  |AstSyntax.Null -> 
    AstTds.Null
  |AstSyntax.Addr id ->
    begin 
      (*on recherche dans la tds pour verifier que l'id est bien déclaré *)
      match Tds.chercherGlobalement tds id with  
      |Some info -> 
        begin 
          (*on vérifie que l'info est bien une infovar*)
          match info_ast_to_info info with
          | InfoVar _ -> AstTds.Addr(info)
          | _ -> raise (MauvaiseUtilisationIdentifiant id) 
          end 
     |None -> 
        raise (IdentifiantNonDeclare id) 
    end  
  |AstSyntax.NewTab (t, ne) ->
    begin
      (*on analye l'expression du tableau*)
      let n1 = analyse_tds_expression tds ne in
      AstTds.NewTab(t, n1)
    end
  |AstSyntax.InitTab (el) -> 
    begin
      let n1 = List.map (analyse_tds_expression tds) el in
      AstTds.InitTab(n1)
    end
  |AstSyntax.Tab t ->
    AstTds.Tab t

  and analyse_tds_affectable a tds modif =
    match a with
    | AstSyntax.Ident id -> 
      begin
        (*in vérifie que l'identifiant est bien déclaré*)
        match chercherGlobalement tds id with
        | Some info -> 
          begin
          (*on vérifie que l'info est bien une infovar ou une infoconst*)
          match info_ast_to_info info with 
          |InfoVar _ -> AstTds.Ident info
          |InfoConst _ -> 
            if modif then
              AstTds.Ident info
            else 
              raise (MauvaiseUtilisationIdentifiant id) 
          | _ -> raise(MauvaiseUtilisationIdentifiant id)
          end
        | None -> raise (IdentifiantNonDeclare id)
        end
    | AstSyntax.Deref aff -> 
      (*on vérifie l'affectable*)
      let aff = analyse_tds_affectable aff tds modif
        in AstTds.Deref aff
    |AstSyntax.Access (a, e2) ->
      begin
        (*on vérifie l'affectable et l'expression*)
        let n1 = analyse_tds_affectable a tds false in
        let n2 = analyse_tds_expression tds e2 in
        AstTds.Access(n1, n2)
      end
      
(* analyse_tds_instruction : tds -> info_ast option -> AstSyntax.instruction -> AstTds.instruction *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre oia : None si l'instruction i est dans le bloc principal,
                   Some ia où ia est l'information associée à la fonction dans laquelle est l'instruction i sinon *)
(* Paramètre i : l'instruction à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme l'instruction
en une instruction de type AstTds.instruction *)
(* Erreur si mauvaise utilisation des identifiants *)
let rec analyse_tds_instruction tdsE tds oia i =
  match i with
  | AstSyntax.Declaration (t, n, e) ->
    begin
      match chercherLocalement tds n with
      | None ->
          (* L'identifiant n'est pas trouvé dans la tds locale,
          il n'a donc pas été déclaré dans le bloc courant *)
          (* Vérification de la bonne utilisation des identifiants dans l'expression *)
          (* et obtention de l'expression transformée *)
          let ne = analyse_tds_expression tds e in
          (* Création de l'information associée à l'identfiant *)
          let info = InfoVar (n,Undefined, 0, "") in
          (* Création du Addr sur l'information *)
          let ia = info_to_info_ast info in
          (* Ajout de l'information (Addr) dans la tds *)
          ajouter tds n ia;
          (* Renvoie de la nouvelle déclaration où le nom a été remplacé par l'information
          et l'expression remplacée par l'expression issue de l'analyse *)
          AstTds.Declaration (t, ia, ne)
      | Some _ ->
          (* L'identifiant est trouvé dans la tds locale,
          il a donc déjà été déclaré dans le bloc courant *)
          raise (DoubleDeclaration n)
    end
  | AstSyntax.Affectation (a,e) ->
      (* Vérification de la bonne utilisation des identifiants dans l'affectable *)
      (* et obtention de l'affectable transformé *)
      let na = analyse_tds_affectable a tds false in
      let ne = analyse_tds_expression tds e in
      AstTds.Affectation (na,ne)
  | AstSyntax.Constante (n,v) ->
      begin
        match chercherLocalement tds n with
        | None ->
          (* L'identifiant n'est pas trouvé dans la tds locale,
             il n'a donc pas été déclaré dans le bloc courant *)
          (* Ajout dans la tds de la constante *)
          ajouter tds n (info_to_info_ast (InfoConst (n,v)));
          (* Suppression du noeud de déclaration des constantes devenu inutile *)
          AstTds.Empty
        | Some _ ->
          (* L'identifiant est trouvé dans la tds locale,
          il a donc déjà été déclaré dans le bloc courant *)
          raise (DoubleDeclaration n)
      end
  | AstSyntax.Affichage e ->
      (* Vérification de la bonne utilisation des identifiants dans l'expression *)
      (* et obtention de l'expression transformée *)
      let ne = analyse_tds_expression tds e in
      (* Renvoie du nouvel affichage où l'expression remplacée par l'expression issue de l'analyse *)
      AstTds.Affichage (ne)
  | AstSyntax.Conditionnelle (c,t,e) ->
      (* Analyse de la condition *)
      let nc = analyse_tds_expression tds c in
      (* Analyse du bloc then *)
      let tast = analyse_tds_bloc tdsE tds oia t in
      (* Analyse du bloc else *)
      let east = analyse_tds_bloc tdsE tds oia e in
      (* Renvoie la nouvelle structure de la conditionnelle *)
      AstTds.Conditionnelle (nc, tast, east)
  | AstSyntax.TantQue (c,b) ->
      (* Analyse de la condition *)
      let nc = analyse_tds_expression tds c in
      (* Analyse du bloc *)
      let bast = analyse_tds_bloc tdsE tds oia b in
      (* Renvoie la nouvelle structure de la boucle *)
      AstTds.TantQue (nc, bast)
  | AstSyntax.Retour (e) ->
      begin
      (* On récupère l'information associée à la fonction à laquelle le return est associée *)
      match oia with
       (* Il y a une information -> l'instruction est dans une fonction *)
       | Some ia ->
        (* Analyse de l'expression *)
        let ne = analyse_tds_expression tds e in
        AstTds.Retour (ne,ia)
        (* Il n'y a pas d'information -> l'instruction est dans le bloc principal : erreur *)
      | None -> raise RetourDansMain
      end
  | AstSyntax.For (t,n1,e1,e2,_,e3,b) -> 
    begin
    (* on vérifie que la variable n'a pas été deja utilisé localement (normalement c'est pas vraiment possible)*)
    match chercherLocalement tds n1 with
      | None ->
        (* L'identifiant n'est pas trouvé dans la tds locale,
          il n'a donc pas été déclaré dans le bloc courant *)
        (* Création de l'information associée à l'identfiant *)
        let info1 = InfoVar (n1,Undefined, 0, "") in
        let ia1 = info_to_info_ast info1 in
        (* Ajout de l'information dans la tds *)
        ajouter tds n1 ia1;
        (*on analyse toutes les expressions ainsi que le bloc qui composent notre boucle for*)
        let ec1 = analyse_tds_expression tds e1 in
        let ec2 = analyse_tds_expression tds e2 in
        let ec3 = analyse_tds_expression tds e3 in
        let bl = analyse_tds_bloc tdsE tds oia b in
        AstTds.For (t,ia1,ec1,ec2,ec3,bl)
      | Some _ ->
          raise (DoubleDeclaration n1)
      end
  | AstSyntax.Goto (n) ->
    begin
      (*on vérifie que l'étiquette existe*)
      match chercherGlobalement tdsE n with
      |Some info ->(
        (*on vérifie que l'info est bien une infoetiquette*)
        match info_ast_to_info info with
        |InfoEtiquette _ -> AstTds.Goto(info)
        |_ -> raise (MauvaiseUtilisationIdentifiant n))
      |None -> raise (IdentifiantNonDeclare n)
    end   
  | AstSyntax.Label (n) ->
    begin
      match chercherGlobalement tdsE n with
      |Some _ -> 
        (*on crée l'infoetiquette*)
        let info = InfoEtiquette (n) in
        let ia = info_to_info_ast info in
        AstTds.Label(ia)
      |None -> failwith("erreur label")
    end

(* analyse_tds_bloc : tds -> info_ast option -> AstSyntax.bloc -> AstTds.bloc *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre oia : None si le bloc li est dans le programme principal,
                   Some ia où ia est l'information associée à la fonction dans laquelle est le bloc li sinon *)
(* Paramètre li : liste d'instructions à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme le bloc en un bloc de type AstTds.bloc *)
(* Erreur si mauvaise utilisation des identifiants *)
and analyse_tds_bloc tdsE tds oia li =
  (* Entrée dans un nouveau bloc, donc création d'une nouvelle tds locale
  pointant sur la table du bloc parent *)
  let tdsbloc = creerTDSFille tds in
  (* Analyse des instructions du bloc avec la tds du nouveau bloc.
     Cette tds est modifiée par effet de bord *)
   let nli = List.map (analyse_tds_instruction tdsE tdsbloc oia) li in
   (* afficher_locale tdsbloc ; *) (* décommenter pour afficher la table locale *)
   nli

(* Fonction auxiliaire parmettant de traiter les couples lp*)
let rec traite_p tds lp =
  match lp with
  |[] -> []
  |(t,t2)::qlp -> match chercherLocalement tds t2 with 
                |None -> let info = InfoVar (t2,Undefined, 0, "") in
                        let ia = info_to_info_ast info in
                        ajouter tds t2 ia;
                        (t, ia) :: traite_p tds qlp
                |Some _ -> raise(DoubleDeclaration t2)

(* analyse_tds_fonction : tds -> AstSyntax.fonction -> AstTds.fonction *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre : la fonction à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme la fonction
en une fonction de type AstTds.fonction *)
(* Erreur si mauvaise utilisation des identifiants *)
let analyse_tds_fonction maintds (AstSyntax.Fonction(t,n,lp,li))  =
  match chercherLocalement maintds n with
  |Some _ -> 
    raise(DoubleDeclaration n)
  |None -> 
    let tdsF = creerTDSFille maintds in
    let tdsE = creerTDSMere () in
    (* collecte des labels pour le bon fonctionnement des goto*)
    (* pour les goto *)
    let _ = collect_labels tdsE li in
    (* Création de l'information associée à l'identfiant *)
    let info = InfoFun (n,t, List.map fst lp) in
    (* Création du Addr sur l'information *)
    let ia = info_to_info_ast info in
    (* Ajout de l'information (Addr) dans la tds *)
    ajouter maintds n ia;
    (*fonction aux pr traiter un param *)
    let b = traite_p tdsF lp in
    let nb = analyse_tds_bloc tdsE tdsF (Some ia) li in
    AstTds.Fonction(t, ia, b, nb) 



(* analyser : AstSyntax.programme -> AstTds.programme *)
(* Paramètre : le programme à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme le programme
en un programme de type AstTds.programme *)
(* Erreur si mauvaise utilisation des identifiants *)
let analyser (AstSyntax.Programme (fonctions,prog)) =
  let tds = creerTDSMere () in
  let tdsE = creerTDSMere () in
  (* collecte des labels pour le bon fonctionnement des goto*)
  (* pour les goto *)
  let _ = collect_labels tdsE prog in
  let nf = List.map (analyse_tds_fonction tds) fonctions in
  let nb = analyse_tds_bloc tdsE tds None prog in
  AstTds.Programme (nf,nb)
