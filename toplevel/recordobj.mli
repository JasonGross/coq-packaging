(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(* $Id: recordobj.mli,v 1.7.6.1 2004/07/16 19:31:49 herbelin Exp $ *)

val objdef_declare : Libnames.global_reference -> unit
val add_object_hook : Tacexpr.declaration_hook
