(* Module de la passe de generation de code *)
(* doit être conforme à l'interface Passe *)
open Tds
open Ast
open Type
open Tam

type t1 = Ast.AstPlacement.programme
type t2 = string

let rec getTailleTab e =
  match e with
  |AstType.Entier i -> i
  |AstType.Booleen _ -> failwith "boolean"
  |AstType.Unaire (_, _) -> failwith "unaire"
  |AstType.Binaire (b,e1,e2) -> 
    begin
      match b with
        |Fraction -> (getTailleTab e1) / (getTailleTab e2)
        |PlusInt -> (getTailleTab e1) + (getTailleTab e2)
        |MultInt -> (getTailleTab e1) * (getTailleTab e2)
        |EquInt -> failwith "equint"
        |EquBool -> failwith "equbool"
        |Inf -> failwith "inf"
        |PlusRat -> failwith "plusrat"
        |MultRat -> failwith "multrat"
    end
  |AstType.AppelFonction (_, _) -> failwith "appel fonction"
  |AstType.New _ -> failwith "new"
  |AstType.Null -> failwith "null"
  |AstType.Addr _ -> failwith "addr"
  |AstType.NewTab (_, e) -> getTailleTab e
  |AstType.InitTab le -> 
    begin
      match le with
        |[] -> failwith "init tab"
        |e::_ -> getTailleTab e
    end
  |AstType.Tab _ -> failwith "tab"
  | _ -> failwith "autre"

let rec getTypeFromExpr e =
  match e with
  |AstType.Entier _ -> Int
  |AstType.Booleen _ -> Bool
  |AstType.Unaire _ -> Rat
  |AstType.Binaire _ -> Rat
  |AstType.AppelFonction (info, _) -> getType info
  |AstType.New t -> t
  |AstType.Null -> failwith "null"
  |AstType.Addr info -> getType info
  |AstType.NewTab (t, _) -> t
  |AstType.InitTab le -> getTypeFromExpr (List.hd le)
  |AstType.Tab t -> t
  | _ -> failwith "autre"

(* analyser_code_expression : AstType.expression -> string *)
(*Paramètre e : expression *)
(* Renvoi le code TAM d'une expression *)
let rec analyser_code_expression e =
  match e with
  |AstType.Entier i -> Tam.loadl_int i
  |AstType.Booleen b -> 
    if b then
      loadl_int 1
    else 
      loadl_int 0
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
  |AstType.New t -> 
    Tam.loadl_int (getTaille t )^
    Tam.subr "MAlloc"

  |AstType.Null -> 
    Tam.subr "MVoid"

  |AstType.Affectation a -> 
    fst (analyse_code_affectable a)

  |AstType.Addr info -> 
    Tam.loadl_int (getAddr info)

  | AstType.NewTab (t, e) -> (*ca doit etre pas mal*)             
    Tam.loadl_int (getTaille t) ^
    analyser_code_expression e ^  
    Tam.subr "IMul" ^
    Tam.subr "MAlloc"                   

 
  | AstType.InitTab le ->(*ca doit etre pas mal*)
      let t = getTypeFromExpr (List.hd le) in
      analyser_code_expression (NewTab (t, Entier (List.length le))) ^
      List.fold_right(fun e str -> e ^ str) (List.mapi (fun _ e -> 
        analyser_code_expression e 
        ) le) "" ^
 
        Tam.storei (getTaille t*(List.length le)) 

  | AstType.Tab t ->
    begin
      match t with
        |Tab t2 -> 
          Tam.loadl_int (getTaille t2) 
        |_ -> failwith "ErrTab"
    end
  
  (*Convertir un affectable en code TAM *)
and analyse_code_affectable a =
  match a with 
  | AstType.Ident info -> 
    begin
    match info_ast_to_info info with
      |InfoVar (_,t,d,reg) -> Tam.load (getTaille t) (d) (reg), t
      |InfoConst (_,i) -> Tam.loadl_int  i, Int
      | _ -> failwith("mauvais info")
    end
  | AstType.Deref a -> 
    let str, t = analyse_code_affectable a in
    begin
      match t with
        |Pointeur _ -> 
          str^Tam.loadi (getTaille t), t
        |_ -> failwith "Err"
    end
  | AstType.Access (a, e) -> 
    let str, t = analyse_code_affectable a in
    let str_e = analyser_code_expression e in
    begin
      match t with
        |Tab t2 -> 
          str ^ 
          str_e ^ 
          Tam.loadl_int (getTaille t2) ^
          Tam.subr "IMul" ^
          Tam.subr "IAdd"^
          Tam.loadi (getTaille t2), t2
        |_ -> failwith "Err"
    end

  and analyse_code_affectable2 a =
    match a with 
    | AstPlacement.Ident info -> 
      begin
        match info_ast_to_info info with
          |InfoVar (_,t,d,reg) -> Tam.store (getTaille t) (d) (reg), t
          | _ -> failwith("mauvais info")
        end
    | AstPlacement.Deref a -> 
      let str, t = analyse_code_affectable2 a in
      begin 
        match t with
          |Pointeur _ -> 
            str^Tam.storei (getTaille t), t
          |_ -> failwith "Err"
        end
    | AstPlacement.Access (a, e) -> 
      let str, t = analyse_code_affectable2 a in
      let str_e = analyser_code_expression e in
      begin
        match t with
          |Tab t2 -> 
            str ^ 
            str_e ^ 
            Tam.loadl_int (getTaille t2) ^
            Tam.subr "IMul" ^
            Tam.subr "IAdd"^
            Tam.loadi (getTaille t2), t2
          |_ -> failwith "Err"
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
  |AstPlacement.Affectation (a, e) -> 
    analyser_code_expression e ^
    begin 
      match a with 
      | AstPlacement.Ident info -> 
        Tam.store (getTaille (getType info)) (getAddr info) (getReg info) 
      | AstPlacement.Deref _ -> fst (analyse_code_affectable2 a)
      | AstPlacement.Access _ -> fst (analyse_code_affectable2 a)
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
  (* Code tam des boucles for *)
  |AstPlacement.For (ia, e1, e2, e3, li) -> 
    (* création d'étiquettes pour boucler et sortir de la boucle*)
    let debut = Code.getEtiquette() in
    let fin = Code.getEtiquette() in
    (match info_ast_to_info ia with
    |InfoVar (_,t,depl,reg) -> 
      (*initialiser le variant de boucle*)
      let a = analyser_code_expression e1 in
      Tam.push (getTaille t) ^ a ^ Tam.store (getTaille t) depl reg ^
      (*commencer a boucler*)
      debut ^ "\n" ^
      (*verifier la condition*)
      analyser_code_expression e2 ^
      Tam.jumpif 0 fin ^
      (*réaliser le contenu de la boucle*)
      analyser_code_bloc li ^
      (*incrémenter le variant de boucle*)
      analyser_code_expression e3 ^
      Tam.store (getTaille (getType ia)) (getAddr ia) (getReg ia) ^
      (*retourner a debut de la boucle*)
      Tam.jump debut ^
      fin ^ "\n"
    | _ -> failwith("aupfzbvzegv" ))
  |AstPlacement.Goto info ->
    begin
    match info_ast_to_info info with
      |InfoEtiquette n -> Tam.jump n
      | _ -> failwith("pas une info etiquette" )
    end
  |AstPlacement.Label info ->
    begin
    match info_ast_to_info info with
      |InfoEtiquette n -> n ^ "\n"
      | _ -> failwith("pas une info etiquette" )
    end
    
  
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
  Tam.halt