(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: contradiction.mli,v 1.2.2.1 2004/07/16 19:30:52 herbelin Exp $ i*)

(*i*)
open Names
open Term
open Proof_type
open Rawterm
(*i*)

val absurd                      : constr -> tactic
val contradiction               : constr with_bindings option -> tactic
