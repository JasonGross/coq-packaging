(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: evarconv.mli,v 1.11.14.1 2004/07/16 19:30:44 herbelin Exp $ i*)

(*i*)
open Term
open Sign
open Environ
open Reductionops
open Evarutil
(*i*)

val the_conv_x : env -> evar_defs -> constr -> constr -> bool

val the_conv_x_leq : env -> evar_defs -> constr -> constr -> bool

(*i For debugging *)
val evar_conv_x : env -> evar_defs -> conv_pb -> constr -> constr -> bool
val evar_eqappr_x : 
  env -> evar_defs ->
    conv_pb -> constr * constr list -> constr * constr list -> bool
(*i*)
