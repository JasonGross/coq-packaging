(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: SplitRmult.v,v 1.1.2.1 2004/07/16 19:31:36 herbelin Exp $ i*)

(*i Lemma mult_non_zero :(r1,r2:R)``r1<>0`` /\ ``r2<>0`` -> ``r1*r2<>0``. i*)


Require Rbase.

Recursive Tactic Definition SplitRmult :=
  Match Context With
  | [ |- ~(Rmult ?1 ?2)==R0 ] -> Apply mult_non_zero; Split;Try SplitRmult.

