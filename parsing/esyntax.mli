(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: esyntax.mli,v 1.10.2.2 2005/01/21 16:42:36 herbelin Exp $ i*)

(*i*)
open Pp
open Extend
open Symbols
open Ppextend
open Topconstr
(*i*)

(* Syntax entry tables. *)

type frozen_t

(* pretty-printer summary operations *)
val init : unit -> unit
val freeze : unit -> frozen_t
val unfreeze : frozen_t -> unit

(* Search and add a PP rule for an ast in the summary *)
val find_syntax_entry :
  string -> Coqast.t -> (Ast.astpat syntax_entry * Ast.env) list
val add_rule : string -> Ast.astpat syntax_entry -> unit
val add_ppobject : Ast.astpat syntax_command -> unit
val warning_verbose : bool ref

(* Pretty-printing *)

type std_printer = Coqast.t -> std_ppcmds
type unparsing_subfunction = string -> tolerability option -> std_printer
type primitive_printer = Coqast.t -> std_ppcmds option

(* Module of constr primitive printers [old style - no scope] *)
module Ppprim :
  sig
    type t = std_printer -> std_printer
    val add : string * t -> unit
  end

val declare_primitive_printer : 
  string -> scope_name -> primitive_printer -> unit

(*i
val declare_infix_symbol : Libnames.section_path -> string -> unit
i*)

(* Generic printing functions *) 
(*i
val token_printer: std_printer -> std_printer
val print_syntax_entry : 
  string -> unparsing_subfunction -> Ast.env -> Ast.astpat syntax_entry -> std_ppcmds
i*)
val genprint : std_printer -> unparsing_subfunction
