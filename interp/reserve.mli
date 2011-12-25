(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2011     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: reserve.mli 14641 2011-11-06 11:59:10Z herbelin $ i*)

open Util
open Names
open Rawterm

val declare_reserved_type : identifier located -> rawconstr -> unit
val find_reserved_type : identifier -> rawconstr
val anonymize_if_reserved : name -> rawconstr -> rawconstr
