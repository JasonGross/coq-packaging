(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(* $Id: ccproof.mli 7298 2005-08-17 12:56:38Z corbinea $ *)

open Ccalgo
open Names

type proof =
    Ax of identifier
  | SymAx of identifier
  | Refl of term
  | Trans of proof * proof
  | Congr of proof * proof
  | Inject of proof * constructor * int * int

val build_proof : 
  forest -> 
  [ `Discr of int * pa_constructor * int * pa_constructor
  | `Prove of int * int ] -> proof

val type_proof :
  (identifier, (term * term)) Hashtbl.t -> proof -> term * term


