(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: extratactics.mli,v 1.3.10.2 2005/01/21 17:14:10 herbelin Exp $ i*)

open Names
open Term
open Proof_type
open Rawterm

val h_discrHyp : quantified_hypothesis -> tactic
val h_injHyp : quantified_hypothesis -> tactic
val h_rewriteLR : constr -> tactic

val refine_tac : Genarg.open_constr -> tactic
