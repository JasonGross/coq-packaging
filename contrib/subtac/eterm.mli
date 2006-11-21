(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: eterm.mli 9326 2006-10-31 12:57:26Z msozeau $ i*)

open Tacmach
open Term
open Evd
open Names
open Util

val mkMetas : int -> constr list

(* val eterm_term : evar_map -> constr -> types option -> constr * types option * (identifier * types) list *)

val eterm_obligations : identifier -> int -> evar_map -> constr -> types option -> 
  (identifier * types * Intset.t) array * constr (* Obl. name, type as product and dependencies as indexes into the array *)

val etermtac : open_constr -> tactic
