(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: recordobj.mli,v 1.7.6.2 2005/01/21 17:18:33 herbelin Exp $ i*)

val objdef_declare : Libnames.global_reference -> unit
val add_object_hook : Tacexpr.declaration_hook
