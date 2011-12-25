(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2011     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(* $Id: decl_interp.mli 14641 2011-11-06 11:59:10Z herbelin $ *)

open Tacinterp
open Decl_expr
open Mod_subst


val intern_proof_instr : glob_sign -> raw_proof_instr -> glob_proof_instr
val interp_proof_instr : Decl_mode.pm_info ->
  Evd.evar_map -> Environ.env -> glob_proof_instr -> proof_instr
