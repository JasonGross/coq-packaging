(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: RelationalChoice.v,v 1.1.2.1 2004/07/16 19:31:29 herbelin Exp $ i*)

(* This file axiomatizes the relational form of the axiom of choice *)

Axiom relational_choice :
 (A:Type;B:Type;R: A->B->Prop) 
  ((x:A)(EX y:B|(R x y)))
   -> (EXT R':A->B->Prop | 
         ((x:A)(EX y:B|(R x y)/\(R' x y)/\ ((y':B) (R' x y') -> y=y')))).
