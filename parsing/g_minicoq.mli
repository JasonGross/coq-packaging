(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: g_minicoq.mli,v 1.8.16.1 2004/07/16 19:30:39 herbelin Exp $ i*)

(*i*)
open Pp
open Names
open Term
open Environ
(*i*)

val term : constr Grammar.Entry.e

type command =
  | Definition of identifier * constr option * constr
  | Parameter of identifier * constr
  | Variable of identifier * constr
  | Inductive of 
      (identifier * constr) list *
      (identifier * constr * (identifier * constr) list) list
  | Check of constr

val command : command Grammar.Entry.e

val pr_term : path_kind -> env -> constr -> std_ppcmds
