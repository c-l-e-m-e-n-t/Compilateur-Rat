open Rat
open Compilateur

(* Changer le chemin d'accès du jar. *)
let runtamcmde = "java -jar ../../../../../tests/runtam.jar"
(* let runtamcmde = "java -jar /mnt/n7fs/.../tools/runtam/runtam.jar" *)

(* Execute the TAM code obtained from the rat file and return the ouptut of this code *)
let runtamcode cmde ratfile =
  let tamcode = compiler ratfile in
  let (tamfile, chan) = Filename.open_temp_file "test" ".tam" in
  output_string chan tamcode;
  close_out chan;
  let ic = Unix.open_process_in (cmde ^ " " ^ tamfile) in
  let printed = input_line ic in
  close_in ic;
  Sys.remove tamfile;    (* à commenter si on veut étudier le code TAM. *)
  String.trim printed

(* Compile and run ratfile, then print its output *)
let runtam ratfile =
  print_string (runtamcode runtamcmde ratfile)

(****************************************)
(** Chemin d'accès aux fichiers de test *)
(****************************************)

let pathFichiersRat = "../../../../../tests/tam/avec_fonction/fichiersRat/"

(**********)
(*  TESTS *)
(**********)

let%expect_test "testCombinaison" =
  runtam (pathFichiersRat^"testCombinaison.rat");
  [%expect{| 55 |}]

let%expect_test "testFor" =
  runtam (pathFichiersRat^"testFor.rat");
  [%expect{| 15 |}]

let%expect_test "testFor2" =
  runtam (pathFichiersRat^"testFor2.rat");
  [%expect{| 6 |}]

let %expect_test "testGoto1" =
  runtam (pathFichiersRat^"testGoto1.rat");
  [%expect{| 40 |}]

let %expect_test "testGoto2" =
  runtam (pathFichiersRat^"testGoto2.rat");
  [%expect{| 10 |}]

let%expect_test "testPointeur3" = 
  runtam (pathFichiersRat^"testPointeur3.rat"); 
  [%expect{| 423 |}]

  (*
let%expect_test "testTab1" = 
  runtam (pathFichiersRat^"testTab1.rat");
  [%expect{| [3/4][13/36] |}]*)
  
let%expect_test "pointeur1" = 
  runtam (pathFichiersRat^"testPointeur1.rat");
  [%expect{| 4 |}]

let%expect_test "pointeur2" = 
  runtam (pathFichiersRat^"testPointeur2.rat");
  [%expect{| 4 |}]
  
(* requires ppx_expect in jbuild, and `opam install ppx_expect` *)
let%expect_test "testfun1" =
  runtam (pathFichiersRat^"testfun1.rat");
  [%expect{| 1 |}]

let%expect_test "testfun2" =
  runtam (pathFichiersRat^"testfun2.rat");
  [%expect{| 7 |}]

let%expect_test "testfun3" =
  runtam (pathFichiersRat^"testfun3.rat");
  [%expect{| 10 |}]

let%expect_test "testfun4" =
  runtam (pathFichiersRat^"testfun4.rat");
  [%expect{| 10 |}]

let%expect_test "testfun5" =
  runtam (pathFichiersRat^"testfun5.rat");
  [%expect{| |}]

let%expect_test "testfun6" =
  runtam (pathFichiersRat^"testfun6.rat");
  [%expect{|truetrue|}]

let%expect_test "testfuns" =
  runtam (pathFichiersRat^"testfuns.rat");
  [%expect{| 28 |}]

let%expect_test "factrec" =
  runtam (pathFichiersRat^"factrec.rat");
  [%expect{| 120 |}]


