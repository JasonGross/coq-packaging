(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(* $Id: coqtop.ml,v 1.72.2.4 2004/09/03 15:05:23 herbelin Exp $ *)

open Pp
open Util
open System
open Options
open Names
open Libnames
open Nameops
open States
open Toplevel
open Coqinit

let get_version_date () =
  try
    let ch = open_in (Coq_config.coqtop^"/make.result") in
    let l = input_line ch in
    let i = String.index l ' ' in
    let j = String.index_from l (i+1) ' ' in
    "checked out on "^(String.sub l (i+1) (j-i-1))
  with _ -> Coq_config.date

let print_header () =
  Printf.printf "Welcome to Coq %s%s (%s)\n"
    Coq_config.version 
    (if !Options.v7 then " (V7 syntax)" else "")
    (get_version_date ());
  flush stdout

let memory_stat = ref false

let print_memory_stat () = 
  if !memory_stat then
    Format.printf "total heap size = %d kbytes\n" (heap_size_kb ())

let _ = at_exit print_memory_stat

let engagement = ref None
let set_engagement c = engagement := Some c
let engage () =
  match !engagement with Some c -> Global.set_engagement c | None -> ()
  
let set_batch_mode () = batch_mode := true

let toplevel_name = ref (make_dirpath [id_of_string "Top"])
let set_toplevel_name dir = toplevel_name := dir

let remove_top_ml () = Mltop.remove ()

let inputstate = ref None
let set_inputstate s = inputstate:= Some s
let inputstate () =
  match !inputstate with
    | Some "" -> ()
    | Some s -> intern_state s
    | None -> intern_state "initial.coq"

let outputstate = ref ""
let set_outputstate s = outputstate:=s
let outputstate () = if !outputstate <> "" then extern_state !outputstate

let check_coq_overwriting p = 
  if string_of_id (list_last (repr_dirpath p)) = "Coq" then
    error "The \"Coq\" logical root directory is reserved for the Coq library"

let set_include d p = push_include (d,p)
let set_rec_include d p = check_coq_overwriting p; push_rec_include (d,p)
let set_default_include d = set_include d Nameops.default_root_prefix
let set_default_rec_include d = set_rec_include d Nameops.default_root_prefix
 
let load_vernacular_list = ref ([] : (string * bool) list)
let add_load_vernacular verb s =
  load_vernacular_list := ((make_suffix s ".v"),verb) :: !load_vernacular_list
let load_vernacular () =
  List.iter
    (fun (s,b) -> 
      if Options.do_translate () then
	with_option translate_file (Vernac.load_vernac b) s
      else
	Vernac.load_vernac b s)
    (List.rev !load_vernacular_list)

let load_vernacular_obj = ref ([] : string list)
let add_vernac_obj s = load_vernacular_obj := s :: !load_vernacular_obj
let load_vernac_obj () = 
  List.iter Library.read_library_from_file (List.rev !load_vernacular_obj)

let require_list = ref ([] : string list)
let add_require s = require_list := s :: !require_list
let require () =
  List.iter (fun s -> Library.require_library_from_file None None s false)
    (List.rev !require_list)

let compile_list = ref ([] : (bool * string) list)
let add_compile verbose s =
  set_batch_mode ();
  Options.make_silent true; 
  compile_list := (verbose,s) :: !compile_list
let compile_files () =
  let init_state = States.freeze() in
  List.iter
    (fun (v,f) ->
      States.unfreeze init_state;
      if Options.do_translate () then
	with_option translate_file (Vernac.compile v) f
      else
	Vernac.compile v f)
    (List.rev !compile_list)

let re_exec_version = ref ""
let set_byte () = re_exec_version := "byte"
let set_opt () = re_exec_version := "opt"

(* Re-exec Coq in bytecode or native code if necessary. [s] is either
   ["byte"] or ["opt"]. Notice that this is possible since the nature of
   the toplevel has already been set in [Mltop] by the main file created
   by coqmktop (see scripts/coqmktop.ml). *)

let re_exec is_ide =
  let s = !re_exec_version in
  let is_native = (Mltop.get()) = Mltop.Native in
  let prog = Sys.argv.(0) in
  let coq = Filename.basename prog in
  if (is_native && s = "byte") || ((not is_native) && s = "opt")
  then begin
    let s = if s = "" then if is_native then "opt" else "byte" else s in
    let newprog = 
      let dir = Filename.dirname prog in
      let coqtop = if is_ide then "coqide." else "coqtop." in
      let com = coqtop ^ s ^ Coq_config.exec_extension in
      if dir <> "." then Filename.concat dir com else com 
    in
    Sys.argv.(0) <- newprog;
    Unix.handle_unix_error (Unix.execvp newprog) Sys.argv
  end

(*s Parsing of the command line.
    We no longer use [Arg.parse], in order to use share [Usage.print_usage]
    between coqtop and coqc. *)

let usage () =
  if !batch_mode then
    Usage.print_usage_coqc ()
  else
    Usage.print_usage_coqtop () ;
  flush stderr ;
  exit 1

let warning s = msg_warning (str s)

let ide_args = ref []
let parse_args is_ide =
  let rec parse = function
    | [] -> ()

    | "-impredicative-set" :: rem -> 
        set_engagement Environ.ImpredicativeSet; parse rem

    | ("-I"|"-include") :: d :: rem -> set_default_include d; parse rem
    | ("-I"|"-include") :: []       -> usage ()

    | "-R" :: d :: p :: rem ->set_rec_include d (dirpath_of_string p);parse rem
    | "-R" :: ([] | [_]) -> usage ()

    | "-top" :: d :: rem -> set_toplevel_name (dirpath_of_string d); parse rem
    | "-top" :: [] -> usage ()

    | "-q" :: rem -> no_load_rc (); parse rem

    | "-opt" :: rem -> set_opt(); parse rem
    | "-byte" :: rem -> set_byte(); parse rem
    | "-full" :: rem -> warning "option -full deprecated\n"; parse rem

    | "-batch" :: rem -> set_batch_mode (); parse rem
    | "-boot" :: rem -> boot := true; no_load_rc (); parse rem	     
    | "-quality" :: rem -> term_quality := true; no_load_rc (); parse rem
    | "-outputstate" :: s :: rem -> set_outputstate s; parse rem
    | "-outputstate" :: []       -> usage ()

    | "-nois" :: rem -> set_inputstate ""; parse rem
	     
    | ("-inputstate"|"-is") :: s :: rem -> set_inputstate s; parse rem
    | ("-inputstate"|"-is") :: []       -> usage ()

    | "-load-ml-object" :: f :: rem -> Mltop.dir_ml_load f; parse rem
    | "-load-ml-object" :: []       -> usage ()

    | "-load-ml-source" :: f :: rem -> Mltop.dir_ml_use f; parse rem
    | "-load-ml-source" :: []       -> usage ()

    | ("-load-vernac-source"|"-l") :: f :: rem -> 
	add_load_vernacular false f; parse rem
    | ("-load-vernac-source"|"-l") :: []       -> usage ()

    | ("-load-vernac-source-verbose"|"-lv") :: f :: rem -> 
	add_load_vernacular true f; parse rem
    | ("-load-vernac-source-verbose"|"-lv") :: []       -> usage ()

    | "-load-vernac-object" :: f :: rem -> add_vernac_obj f; parse rem
    | "-load-vernac-object" :: []       -> usage ()

    | "-dump-glob" :: f :: rem -> dump_into_file f; parse rem
    | "-dump-glob" :: []       -> usage ()

    | "-require" :: f :: rem -> add_require f; parse rem
    | "-require" :: []       -> usage ()

    | "-compile" :: f :: rem -> add_compile false f; parse rem
    | "-compile" :: []       -> usage ()

    | "-compile-verbose" :: f :: rem -> add_compile true f; parse rem
    | "-compile-verbose" :: []       -> usage ()

    | "-dont-load-proofs" :: rem -> Options.dont_load_proofs := true; parse rem

    | "-translate" :: rem -> make_translate true; parse rem

    | "-unsafe" :: f :: rem -> add_unsafe f; parse rem
    | "-unsafe" :: []       -> usage ()

    | "-debug" :: rem -> set_debug (); parse rem

    | "-emacs" :: rem -> Options.print_emacs := true; parse rem
	  
    | "-where" :: _ -> print_endline Coq_config.coqlib; exit 0

    | ("-quiet"|"-silent") :: rem -> Options.make_silent true; parse rem

    | ("-?"|"-h"|"-H"|"-help"|"--help") :: _ -> usage ()

    | ("-v"|"--version") :: _ -> Usage.version ()

    | "-init-file" :: f :: rem -> set_rcfile f; parse rem
    | "-init-file" :: []       -> usage ()

    | "-user" :: u :: rem -> set_rcuser u; parse rem
    | "-user" :: []       -> usage ()

    | "-notactics" :: rem -> remove_top_ml (); parse rem

    | "-just-parsing" :: rem -> Vernac.just_parsing := true; parse rem

    | ("-m" | "--memory") :: rem -> memory_stat := true; parse rem

    | "-xml" :: rem -> Options.xml_export := true; parse rem

    (* Scanned in Options! *)
    | "-v7" :: rem -> (* Options.v7 := true; *) parse rem
    | "-v8" :: rem -> (* Options.v7 := false; *) parse rem

    (* Translator options *)
    | "-strict-implicit" :: rem -> 
	Options.translate_strict_impargs := false; parse rem

    | s :: rem -> 
	if is_ide then begin
	  ide_args := s :: !ide_args;
	  parse rem
	end else begin
	  prerr_endline ("Don't know what to do with " ^ s); usage ()
	end
  in
  try
    parse (List.tl (Array.to_list Sys.argv))
  with 
    | UserError(_,s) as e -> begin
	try
	  Stream.empty s; exit 1
	with Stream.Failure ->
	  msgnl (Cerrors.explain_exn e); exit 1
      end
    | e -> begin msgnl (Cerrors.explain_exn e); exit 1 end


(* To prevent from doing the initialization twice *)
let initialized = ref false

let init is_ide =
  if not !initialized then begin
    initialized := true;
    Sys.catch_break false; (* Ctrl-C is fatal during the initialisation *)
    Lib.init();
    try
      parse_args is_ide;
      re_exec is_ide;
      if_verbose print_header ();
      init_load_path ();
      inputstate ();
      engage ();
      if not !batch_mode then Declaremods.start_library !toplevel_name;
      init_library_roots ();
      load_vernac_obj ();
      require ();
      load_rcfile();
      load_vernacular ();
      compile_files ();
      outputstate ();
    with e ->
      flush_all();
      if not !batch_mode then message "Error during initialization :";
      msgnl (Toplevel.print_toplevel_error e);
      exit 1
  end;
  if !batch_mode then (flush_all(); Profile.print_profile (); exit 0);
  Lib.declare_initial_state ()

let init_ide () = init true; List.rev !ide_args

let start () =
  init false;
  Toplevel.loop();
  (* Initialise and launch the Ocaml toplevel *)
  Coqinit.init_ocaml_path();
  Mltop.ocaml_toploop();
  exit 1

(* [Coqtop.start] will be called by the code produced by coqmktop *)
