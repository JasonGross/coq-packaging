(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: subtyping.mli,v 1.2.8.1 2004/07/16 19:30:26 herbelin Exp $ i*)

(*i*)
open Univ
open Declarations
open Environ
(*i*)

val check_subtypes : env -> module_type_body -> module_type_body -> constraints


