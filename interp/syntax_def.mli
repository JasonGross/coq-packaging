(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: syntax_def.mli,v 1.3.2.2 2004/07/16 19:30:23 herbelin Exp $ i*)

(*i*)
open Util
open Names
open Topconstr
open Rawterm
(*i*)

(* Syntactic definitions. *)

val declare_syntactic_definition : bool -> identifier -> bool -> aconstr
  -> unit

val search_syntactic_definition : loc -> kernel_name -> rawconstr


