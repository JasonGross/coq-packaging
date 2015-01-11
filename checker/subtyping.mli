(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2014     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i*)
open Univ
open Term
open Declarations
open Environ
(*i*)

(** Invariant: the first [module_type_body] is now supposed to be
    known by [env] *)

val check_subtypes : env -> module_type_body -> module_type_body -> unit


