(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: refine.mli,v 1.7.2.1 2004/07/16 19:30:55 herbelin Exp $ i*)

open Term
open Tacmach

val refine : Pretyping.open_constr -> tactic
