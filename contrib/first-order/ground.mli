(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(* $Id: ground.mli,v 1.1.2.1 2004/07/16 19:30:10 herbelin Exp $ *)

val ground_tac:     Tacmach.tactic ->
  (Proof_type.goal Tacmach.sigma -> Sequent.t) -> Tacmach.tactic

