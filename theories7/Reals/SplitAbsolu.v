(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i      $Id: SplitAbsolu.v,v 1.1.2.1 2004/07/16 19:31:36 herbelin Exp $       i*)

Require Rbasic_fun.

Recursive Tactic Definition SplitAbs :=
  Match Context With
    | [ |- [(case_Rabsolu ?1)] ] -> 
         Case (case_Rabsolu ?1); Try SplitAbs.


Recursive Tactic Definition SplitAbsolu :=
  Match Context With
    | [ id:[(Rabsolu ?)] |- ? ] -> Generalize id; Clear id;Try SplitAbsolu
    | [ |- [(Rabsolu ?1)] ] ->  Unfold Rabsolu; Try SplitAbs;Intros.
