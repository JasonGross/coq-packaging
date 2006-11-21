(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: extratactics.mli 9073 2006-08-22 08:54:29Z jforest $ i*)

open Util
open Names
open Term
open Proof_type
open Rawterm
open Tacexpr
open Topconstr
open Genarg

val h_discrHyp : quantified_hypothesis -> tactic
val h_injHyp : quantified_hypothesis -> tactic

val refine_tac : Genarg.open_constr -> tactic

