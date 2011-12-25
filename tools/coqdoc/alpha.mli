(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2011     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: alpha.mli 14641 2011-11-06 11:59:10Z herbelin $ i*)

(* Alphabetic order. *)

val compare_char : char -> char -> int
val compare_string : string -> string -> int

(* Alphabetic normalization. *)

val norm_char : char -> char
val norm_string : string -> string
