(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2011     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: tactic_printer.mli 14641 2011-11-06 11:59:10Z herbelin $ i*)

(*i*)
open Pp
open Sign
open Evd
open Tacexpr
open Proof_type
(*i*)

(* These are the entry points for tactics, proof trees, ... *)

val print_proof : evar_map -> named_context -> proof_tree -> std_ppcmds
val pr_rule     : rule -> std_ppcmds
val pr_tactic   : tactic_expr -> std_ppcmds
val pr_proof_instr : Decl_expr.proof_instr -> Pp.std_ppcmds
val print_script :
  ?nochange:bool -> evar_map -> proof_tree -> std_ppcmds
val print_treescript :
  ?nochange:bool -> evar_map -> proof_tree -> std_ppcmds
