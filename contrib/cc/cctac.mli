(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(* $Id: cctac.mli 7298 2005-08-17 12:56:38Z corbinea $ *)

open Term 
open Proof_type

val cc_tactic : constr list -> tactic

val cc_fail : tactic
