(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2011     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: NProperties.v 14641 2011-11-06 11:59:10Z herbelin $ i*)

Require Export NAxioms NSub.

(** This functor summarizes all known facts about N.
    For the moment it is only an alias to [NSubPropFunct], which
    subsumes all others.
*)

Module Type NPropSig := NSubPropFunct.

Module NPropFunct (N:NAxiomsSig) <: NPropSig N.
 Include NPropSig N.
End NPropFunct.
