(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(* Certification of Imperative Programs / Jean-Christophe Filli�tre *)

(* $Id: pmlize.mli,v 1.2.16.1 2004/07/16 19:30:01 herbelin Exp $ *)

open Past
open Penv
open Names

(* translation of imperative programs into intermediate functional programs *)

val trans : Prename.t -> typed_program -> cc_term

