(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i $Id: dyn.mli,v 1.3.16.1 2004/07/16 19:30:29 herbelin Exp $ i*)

(* Dynamics. Use with extreme care. Not for kids. *)

type t

val create : string -> ('a -> t) * (t -> 'a)
val tag : t -> string
