(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, * CNRS-Ecole Polytechnique-INRIA Futurs-Universite Paris Sud *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(*i camlp4deps: "parsing/grammar.cma" i*)

(* $Id: g_fourier.ml4,v 1.1.12.1 2004/07/16 19:30:11 herbelin Exp $ *)

open FourierR

TACTIC EXTEND Fourier
  [ "FourierZ" (* constr_list(l) *) ] -> [ fourier (* l *) ]
END
