(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: discharge.mli,v 1.6.16.1 2004/07/16 19:31:48 herbelin Exp $ i*)

open Names

(* This module implements the discharge mechanism. It provides a function to
   close the last opened section. That function calls [Lib.close_section] and
   then re-introduce all the discharged versions of the objects that were
   defined in the section. *)

val close_section : bool -> identifier -> unit
