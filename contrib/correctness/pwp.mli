(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(* Certification of Imperative Programs / Jean-Christophe Filliâtre *)

(* $Id: pwp.mli,v 1.2.16.1 2004/07/16 19:30:06 herbelin Exp $ *)

open Term
open Penv

val update_post : local_env -> string -> Peffect.t -> constr -> constr

val propagate : Prename.t -> typed_program -> typed_program
