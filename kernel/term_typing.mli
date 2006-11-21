(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: term_typing.mli 9310 2006-10-28 19:35:09Z herbelin $ i*)

(*i*)
open Names
open Term
open Univ
open Declarations
open Inductive
open Environ
open Entries
open Typeops
(*i*)

val translate_local_def : env -> constr * types option -> 
  constr * types * Univ.constraints

val translate_local_assum : env -> types ->
  types * Univ.constraints

val infer_declaration : env -> constant_entry -> 
   constr_substituted option * constant_type * constraints * bool * bool

val build_constant_declaration : env -> 'a ->
    constr_substituted option * constant_type * constraints * bool * bool ->
      constant_body

val translate_constant : env -> constant -> constant_entry -> constant_body

val translate_mind : 
  env -> mutual_inductive_entry -> mutual_inductive_body

val translate_recipe : 
  env -> constant -> Cooking.recipe -> constant_body
