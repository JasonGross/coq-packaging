(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: extraargs.mli,v 1.3.2.2 2005/01/21 17:14:10 herbelin Exp $ i*)

open Tacexpr
open Term
open Proof_type
open Topconstr

val rawwit_orient : bool raw_abstract_argument_type
val wit_orient : bool closed_abstract_argument_type
val orient : bool Pcoq.Gram.Entry.e
